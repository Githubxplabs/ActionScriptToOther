package how.as2js
{
	import flash.utils.Dictionary;
	
	import how.as2js.codeDom.CodeObject;
	import how.as2js.compiler.TokenType;

	public class Utils
	{
		private static var es6to5:Class;

		private static var _reNameDict:Dictionary = new Dictionary();
		private static var _obfuscatedPrefix:String = "_010101";
		private static var _index:int = 1000000;
		
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
		
		public static function obfuscated(codeObject:CodeObject, source:String, target:String):void
		{
			if (codeObject != null)
			{
				codeObject.refactorName(source, target);
			}
		}
		
		public static function obfuscatedSelf(codeObject:CodeObject):void
		{
			if (codeObject != null)
			{
				codeObject.refactorNameSelf();
			}
		}
		
		public static function getObfuscatedKey(name:String):String
		{
			var result:String = _reNameDict[name];
			if (result != null)
			{
				return result;
			}
			
			_index++;
//			result = _obfuscatedPrefix + _index.toString(2); 
			result = _obfuscatedPrefix + name; 
			_reNameDict[name] = result;
			
			return result;
		}
		
		public static function getObfuscatedFixedKey(name:String):String
		{
			var result:String = _reNameDict[name];
			if (result != null)
			{
				return result;
			}
			return null;
		}
		
		public static function isObfuscatedName(name:String):Boolean
		{
			if (name.slice(0, 7) == _obfuscatedPrefix)
			{
				return true;
			}
			return false;
		}
		
		public static function isAtPropertiesEnd(ch:String):Boolean
		{
			if (ch == "\r" || ch == "\n" || ch == ";" || 
				ch == "=" || ch == ">" || ch == "<" || 
				ch == "-" || ch == "+" || ch == "*" || 
				ch == "/" || ch == "%" || ch == "." ||
				ch == "(" || ch == ")" || ch == "{" || 
				ch == "}" || ch == "[" || ch == "]")
			{
				return true;
			}
			return false;
		}
	}
}