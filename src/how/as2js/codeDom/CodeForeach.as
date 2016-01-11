package how.as2js.codeDom
{

	public class CodeForeach extends CodeObject
	{
		public var identifier:CodeObject;
		public var loopObject:CodeObject;
		public var executable:CodeExecutable;
		public function CodeForeach()
		{
			
		}
		override public function out(tabCount:int):String
		{
			loopObject.owner = owner;
			if(executable)
			{
				executable.parent = owner;
				executable.owner = owner;
				executable.tempData = owner.tempData;	
			}
			identifier.owner = owner;
			
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

			
			return getTab(tabCount)+"for each (var " + varName + identifier.out(0) + typeName + " in " + loopObject.out(0) + ")" + getLeftBrace(tabCount) +
				(executable?executable.out(tabCount+1):"") + getTab(tabCount) + "}";
		}
	}
}