package how.as2js.codeDom
{
	import how.as2js.Utils;

	public class CodeNew extends CodeObject
	{
		public var newObject:CodeObject;
		public function CodeNew()
		{
		}
		override public function out(tabCount:int):String
		{
			newObject.owner = owner;
			return "new " + newObject.out(tabCount);
		}
		
		override public function refactorName(source:String, target:String):void
		{
			Utils.obfuscated(newObject, source, target);
		}
		
		override public function refactorNameSelf():void
		{
			Utils.obfuscatedSelf(newObject);
		}
	}
}