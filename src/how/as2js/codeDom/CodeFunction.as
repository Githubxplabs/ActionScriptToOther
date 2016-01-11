package how.as2js.codeDom
{
	import flash.utils.Dictionary;
	
	import how.as2js.Utils;

	public class CodeFunction extends CodeObject
	{
		public static const TYPE_NORMAL:int = 0;
		public static const TYPE_GET:int = 1;
		public static const TYPE_SET:int = 2;
		public var type:int;
		public var IsStatic:Boolean;
		public var listParameters:Vector.<String>;              //参数
		public var listParameterTypes:Vector.<CodeMember>;              //参数类型
		public var listValues:Vector.<CodeObject>;//默认值
		public var executable:CodeExecutable;//函数执行命令
		private var parameterCount:int;                       //参数个数
		private var params:Boolean;                       //参数个数
		public var name:String;
		public var isCtor:Boolean;//是否是构造函数
		public var returnType:CodeMember;//返回类选
		public var modifierType:int;//修饰符
		public function CodeFunction(strName:String,listParameters:Vector.<String>,listParameterTypes:Vector.<CodeMember>,listValues:Vector.<CodeObject>,executable:CodeExecutable,bParams:Boolean,IsStatic:Boolean,type:int,returnType:CodeMember, modifierType:int)
		{
			this.name = strName;
			this.type = type;
			this.IsStatic = IsStatic;
			this.listParameters = listParameters;
			this.listParameterTypes = listParameterTypes;
			this.listValues = listValues;
			this.executable = executable;
			this.parameterCount = listParameters.length;
			this.params = bParams;
			this.returnType = returnType;
			this.modifierType = modifierType;
		}
		
		override public function refactorName(source:String, target:String):void
		{
			
			if (name == source)
			{
				name = target;
			}
			
			var sizeListParameterTypes:int = listParameterTypes.length;
			for (var i:int = 0; i < sizeListParameterTypes; i++) 
			{
				Utils.obfuscated(listParameterTypes[i], source, target);
			}
			
			var sizeListValues:int = listValues.length;
			for (var j:int = 0; j < sizeListValues; j++) 
			{
				Utils.obfuscated(listValues[j], source, target);
			}
			
			var sizeListParameters:int = listParameters.length;
			for (var k:int = 0; k < sizeListParameters; k++) 
			{
				if (listParameters[k] == source)
				{
					listParameters[k] = target;
				}
			}
			
			Utils.obfuscated(returnType, source, target);
			Utils.obfuscated(executable, source, target);
		}
		
		override public function refactorNameSelf():void
		{
			var target:String = Utils.getObfuscatedFixedKey(name);
			if (target != null)
			{
				name = target;
			}
			
			var sizeListParameterTypes:int = listParameterTypes.length;
			for (var i:int = 0; i < sizeListParameterTypes; i++) 
			{
				Utils.obfuscatedSelf(listParameterTypes[i]);
			}
			
			var sizeListValues:int = listValues.length;
			for (var j:int = 0; j < sizeListValues; j++) 
			{
				Utils.obfuscatedSelf(listValues[j]);
			}
			
			var sizeListParameters:int = listParameters.length;
			for (var k:int = 0; k < sizeListParameters; k++) 
			{
				
				target = Utils.getObfuscatedFixedKey(listParameters[k]);
				if (target != null)
				{
					listParameters[k] = target;
				}
			}
			
			Utils.obfuscatedSelf(returnType);
			Utils.obfuscatedSelf(executable);
		}
		
		override public function out(tabCount:int):String
		{
			var functionString:String = "";
			if(owner)
			{
				executable.tempData = owner.tempData;	
			}
			executable.tempData.tempData = new Dictionary();
			
			var tempParamsString:String = "";
			for (var j:int = 0; j < listParameters.length; j++) 
			{
				tempParamsString += listParameters[j];
				tempParamsString += ":";
				tempParamsString += listParameterTypes[j].memberString;
				if (listValues[j] != null)
				{
					tempParamsString += " = " + listValues[j].out(0);
				}
				if (j != listParameters.length - 1)
				{
					tempParamsString += ", ";
				}
			}
			
			functionString += getTab(tabCount) + 
				Utils.getModifierTypeName(modifierType) +
				(IsStatic ? "static " : "") + " function " +
				(type == CodeFunction.TYPE_GET ? "get " : "") +
				(type == CodeFunction.TYPE_SET ? "set " : "") +
				name + "(" +tempParamsString + ")" +
				(!returnType ? "" : (":" + returnType.memberString)) + "\n" +
				getTab(tabCount) + "{\n" +
				executable.out(tabCount + 1) +
				getTab(tabCount) + "}\n\n";
			
			return functionString;
		}
		
		override public function outJS(tabCount:int):String
		{
			if(owner)
			{
				executable.tempData = owner.tempData;	
			}
			executable.tempData.tempData = new Dictionary();
			var valuesString:String = "";
			for (var i:int = 0; i < listValues.length; i++)
			{
				valuesString += getTab(tabCount+1) + listParameters[i] +  " = " + listParameters[i]+"!=null||"+listParameters[i]+"!=undefined?"+listParameters[i]+":" + listValues[i].out(0) + ";\n";
			}
			return "function"+(executable.parent?name:" ")+"("+toParam(tabCount)+")"+getLeftBrace(tabCount)+valuesString+executable.out(tabCount+1)+insertString+getTab(tabCount)+"}";
		}
		override public function outEgret(tabCount:int):String
		{
			if(owner)
			{
				executable.tempData = owner.tempData;	
			}
			executable.tempData.tempData = new Dictionary();
			var valuesString:String = "";
			for (var i:int = 0; i < listValues.length; i++)
			{
				valuesString += getTab(tabCount+1) + listParameters[i] +  " = " + listParameters[i]+"!=null||"+listParameters[i]+"!=undefined?"+listParameters[i]+":" + listValues[i].out(0) + ";\n";
			}
			return "function "+(isCtor?name:"")+"("+toParam(tabCount)+")"+getLeftBrace(tabCount)+valuesString+executable.out(tabCount+1)+getTab(tabCount)+"}";
		}
		protected function toParam(tabCount:int):String
		{
			var paramString:String = "";
			for (var i:int = 0; i < listParameters.length; i++) 
			{
				if(params && i == parameterCount - 1)
				{
					paramString = paramString + "..." + listParameters[i];
				}
				else
				{
					paramString += listParameters[i];	
				}
				executable.tempData.tempData[paramString] = null;
				if(i<listParameters.length-1)
				{
					paramString += ",";
				}
			}
			return paramString;
		}
	}
}