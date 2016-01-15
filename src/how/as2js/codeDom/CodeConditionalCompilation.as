/*******************************************
 * Author : hanxianming
 * Date   : 2016-1-14
 * Use    : 
 *******************************************/

package how.as2js.codeDom
{
	public final class CodeConditionalCompilation extends CodeObject
	{
		public var executable:CodeExecutable;//函数执行命令
		public var left:CodeObject;
		public var right:CodeObject;
		public function CodeConditionalCompilation(left:CodeObject, right:CodeObject, executable:CodeExecutable)
		{
			this.left = left;
			this.right = right;
			this.executable = executable;
		}
	}
}