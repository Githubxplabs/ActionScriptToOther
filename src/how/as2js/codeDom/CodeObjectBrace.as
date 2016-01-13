/*******************************************
 * Author : hanxianming
 * Date   : 2016-1-13
 * Use    : 带有大括号的对象{a:1}
 *******************************************/

package how.as2js.codeDom
{
	public final class CodeObjectBrace extends CodeObject
	{
		
		public var objects:Vector.<CodeObjectBrace> = new Vector.<CodeObjectBrace>();
		
		public var left:CodeObject;
		public var right:CodeObject;
		
		public function CodeObjectBrace()
		{
		}
	}
}