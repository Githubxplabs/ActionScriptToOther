package how.as2js.codeDom
{
	import how.as2js.Utils;
	
	
	/**
	 * 成员变量
	 */
	public class CodeVariable
	{
		public var key:Object;//属性键
		public var value:CodeObject;//属性值
		public var modifierType:int;//修饰符 公共/私有等
		public var isStatic:Boolean = true;//是否静态
		public var isConst:Boolean = true;//是否常量
		public var type:CodeObject;//属性类型
		public var isOverride:Boolean = false;
		public var embed:String;
		public function CodeVariable(key:Object,value:CodeObject,modifierType:int,isStatic:Boolean,isConst:Boolean,isOverride:Boolean,type:CodeObject, embed:String)
		{
			this.key = key;
			this.value = value;
			this.modifierType = modifierType;
			this.isStatic = isStatic;
			this.isConst = isConst;
			this.isOverride = isOverride;
			this.type = type;
			this.embed = embed;
		}
		
		public function refactorName(source:String, target:String):void
		{
			if (key == source)
			{
				key = target;
			}
			
			Utils.obfuscated(value, source, target);
			Utils.obfuscated(type, source, target);
		}
		
		public function refactorNameSelf():void
		{
			var target:String = Utils.getObfuscatedFixedKey(key.toString());
			if (target != null)
			{
				key = target;
			}
			
			Utils.obfuscatedSelf(value);
			Utils.obfuscatedSelf(type);
		}
	}
}