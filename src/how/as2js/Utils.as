package how.as2js
{
	import how.as2js.compiler.TokenType;

	public class Utils
	{
		private static var es6to5:Class;
		public static function IsLetter(str:String):Boolean
		{			
			if (new RegExp("[A-Za-z]").test(str)){ 
				return true; 
			}else{ 
				return false; 
			}
		}
		public static function IsDigit(str:String):Boolean
		{
			if (new RegExp("[0-9]").test(str)){ 
				return true; 
			}else{ 
				return false; 
			}
		}
		public static function IsNullOrEmpty(str:String):Boolean
		{
			return str == null || str == "";
		}
		public static function IsLetterOrDigit(str:String):Boolean
		{
			if (new RegExp("[A-Za-z0-9]").test(str)){ 
				return true; 
			}else{ 
				return false; 
			} 
		}
		
		public static function getModifierTypeName(type:int):String
		{
			var modifierName:String = "public";
			switch(type)
			{
				case TokenType.Public:
					modifierName = "public";
					break;
				case TokenType.Private:
					modifierName = "private";
					break;
				case TokenType.Protected:
					modifierName = "protected";
					break;
				case TokenType.Internal:
					modifierName = "internal";
					break;
			}
			return modifierName;
		}
	}
}