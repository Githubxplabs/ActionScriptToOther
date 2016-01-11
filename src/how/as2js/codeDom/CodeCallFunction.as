package how.as2js.codeDom
{
	import how.as2js.Utils;

	public class CodeCallFunction extends CodeObject
	{
		public var member:CodeObject;
		public var parameters:Vector.<CodeObject>;
		
		override public function refactorName(source:String, target:String):void
		{
			Utils.obfuscated(member, source, target);
			
			for (var i:int = 0; i < parameters.length; i++) 
			{
				Utils.obfuscated(parameters[i], source, target);
			}
			
		}
		
		override public function refactorNameSelf():void
		{
			Utils.obfuscatedSelf(member);
			
			for (var i:int = 0; i < parameters.length; i++) 
			{
				Utils.obfuscatedSelf(parameters[i]);
			}
		}
		
		override public function out(tabCount:int):String
		{
			member.owner = owner;
			var arg:String = "";
			for (var i:int = 0; i < parameters.length; i++) 
			{
				parameters[i].owner = owner;
				arg += parameters[i].out(tabCount);
				if(i != parameters.length - 1)
				{
					arg += ", ";
				}
			}
			return member.out(tabCount) + insertString + "(" + arg + ")";
		}
		
		override public function outJS(tabCount:int):String
		{
			member.owner = owner;
			var arg:String = "";
			for (var i:int = 0; i < parameters.length; i++) 
			{
				parameters[i].owner = owner;
				arg += parameters[i].out(tabCount);
				if(i != parameters.length - 1)
				{
					arg += ",";
				}
			}
			return member.out(tabCount) + "(" + arg + ")";
		}
		override public function outEgret(tabCount:int):String
		{
			member.owner = owner;
			var arg:String = "";
			for (var i:int = 0; i < parameters.length; i++) 
			{
				parameters[i].owner = owner;
				arg += parameters[i].out(tabCount);
				if(i != parameters.length - 1)
				{
					arg += ",";
				}
			}
			return member.out(tabCount) + insertString + "(" + arg + ")";
		}
	}
}