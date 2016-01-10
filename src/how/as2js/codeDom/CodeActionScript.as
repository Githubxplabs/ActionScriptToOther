package how.as2js.codeDom
{
	import flash.utils.Dictionary;
	
	import how.as2js.Config;
	import how.as2js.Utils;
	import how.as2js.codeDom.temp.TempData;
	import how.as2js.compiler.TokenType;

	public final class CodeActionScript extends CodeEgret
	{
		public function CodeActionScript()
		{
			super();
		}
		
		override public function out(tabCount:int):String
		{
			tabCount++;
			setTempData();
			return getBody(tabCount);
		}
		
		override protected function getBody(tabCount:int):String
		{
			var tempStr:String = toPackage(tabCount-1);
			tempStr += "{" + Config.nextLine;
			tempStr += toImport(tabCount);
			tempStr += Config.nextLine;
			tempStr += getTab(tabCount) + "public " + toFinal() + toDynamic() + "class " + name + " extends " + toParent() + Config.nextLine;
			tempStr += getTab(tabCount) + "{" + Config.nextLine;
			tempStr += toVariable(tabCount);
//			tempStr += getTab(++tabCount) + "public function " + name + "()" + Config.nextLine;
//			tempStr += getTab(tabCount) + "{" + Config.nextLine;
			tempStr += toFunction(++tabCount);
			
			return tempStr + "" +"})\n"+toGetSetFunction(tabCount-1)+toStaticVariable(tabCount-1)+toStaticFunction(tabCount-1);
		}
		
		override protected function toFunction(tabCount:int):String
		{
			var functionString:String = "";	
			for (var i:int = 0; i < functions.length; i++) 
			{
				var codeFunction:CodeFunction = functions[i];
				codeFunction.executable.tempData = tempData;
				codeFunction.isCtor = codeFunction.name == name;
				functionString += codeFunction.out(tabCount);				
//				var funName:String = (functions[i].type == CodeFunction.TYPE_GET "get") || functions[i].type == CodeFunction.TYPE_SET?"[\""+functions[i].name+"\"]":"."+functions[i].name;
//				if(!functions[i].IsStatic)
//				{
//					if(functions[i].isCtor)
//					{
//						functions[i].insertString = toVariable(tabCount+1);
//						functionString += getTab(tabCount) + functions[i].out(tabCount)+";\n";
//					}
//					else
//					{
//						functionString += getTab(tabCount)+"p"+funName+" = "+functions[i].out(tabCount)+";\n";
//					}
//				}
//				else
//				{
//					functions[i].executable.tempData = new TempData();
//					functions[i].executable.tempData.staticTempData = new Dictionary();
//					functions[i].executable.tempData.thisTempData = tempData.staticTempData;
//					functions[i].executable.tempData.importTempData = tempData.importTempData;
//					functionString += getTab(tabCount)+name+funName+" = "+functions[i].out(tabCount)+";\n";
//				}
			}
			return functionString;
		}
		
		override protected function toVariable(tabCount:int):String
		{
			var variableString:String = "";
			for (var i:int = 0; i < variables.length; i++) 
			{
				var variable:CodeVariable = variables[i]; 
				if(variable.value)
				{
					variable.value.owner = new CodeExecutable(0);
					variable.value.owner.tempData = tempData;
				}
				if(variable.type)
				{
					variable.type.owner = new CodeExecutable(0);
					variable.type.owner.tempData = tempData;
				}
				var value:String = variable.value ? variable.value.out(0) : "";
				var type:String = variable.type ? variable.type.out(0) : "";
				variableString += getTab(tabCount + 1) + Utils.getModifierTypeName(variable.modifierType) + (variable.isStatic ? " static" : "") + (variable.isConst ? " const " : " var ") + variable.key + ":" + type + (value == "" ? "" : " = " + value) + ";\n";	
			}
			return variableString + Config.nextLine;
		}
		
		override public function toParent():String
		{
			return parent;
		}
		
		private function toFinal():String
		{
			return isFinal ? "final " : "";
		}
		
		private function toDynamic():String
		{
			return isDynamic ? "dynamic " : "";
		}
		
		override protected function toImport(tabCount:int):String
		{
			var importString:String = "";
			
			for (var i:int = 0; i < imports.length; i++) 
			{
				importString += getTab(tabCount) + "import " + imports[i] + "\n";
			}
			return importString;
		}

		
		override protected function toPackage(tabCount:int):String
		{
			var result:String = "";
			result += "package " + packAge + "\n";
			return result;
		}

	}
}