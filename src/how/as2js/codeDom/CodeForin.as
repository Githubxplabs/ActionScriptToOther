package how.as2js.codeDom
{
	import how.as2js.Utils;

	public class CodeForin extends CodeObject
	{
		public var identifier:CodeObject;
		public var loopObject:CodeObject;
		public var executable:CodeExecutable;
		public var name:String;
		public function CodeForin()
		{
			
		}
		
		override public function refactorName(source:String, target:String):void
		{
			Utils.obfuscated(loopObject, source, target);
			Utils.obfuscated(executable, source, target);
		}
		
		override public function refactorNameSelf():void
		{
			Utils.obfuscatedSelf(loopObject);
			Utils.obfuscatedSelf(executable);
		}
		
		override public function out(tabCount:int):String
		{
			loopObject.owner = owner;
			identifier.owner = owner;
			if(executable)
			{
				executable.parent = owner;
				executable.owner = owner;
				executable.tempData = owner.tempData;	
			}
			
			var varName:String = "";
			var typeName:String = "";
			
			if (identifier is CodeMember)
			{
				if ((identifier as CodeMember).memType != null)
				{
					varName = "var ";
					typeName = " " + ((identifier as CodeMember).memType as CodeMember).memberString;
				}
				
			}
			
			return getTab(tabCount)+"for (" + varName + identifier.out(0) + typeName + " in " + loopObject.out(0) + ")" + getLeftBrace(tabCount) +
				executable.out(tabCount+1) + getTab(tabCount) + "}";
		}
	}
}