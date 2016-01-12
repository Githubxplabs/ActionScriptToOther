package how.as2js.codeDom
{
	

	public class CodeThrow extends CodeObject
	{
		public var obj:CodeObject;
		
		public function CodeThrow()
		{
			
		}
		
		override public function out(tabCount:int):String
		{
			obj.owner = owner;
			return "throw " + obj.out(0);
		}
	}
}