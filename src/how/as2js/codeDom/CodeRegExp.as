/*******************************************
 * Author : hanxianming
 * Date   : 2016-1-12
 * Use    : 正则表达式
 *******************************************/

package how.as2js.codeDom
{
	public final class CodeRegExp extends CodeObject
	{
		public var regExp:String;
		
		public function CodeRegExp(regExp:String)
		{
			this.regExp = regExp;
		}
	}
}