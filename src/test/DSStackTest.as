package test {
	import de.polygonal.ds.ArrayedStack;

	import flash.display.Sprite;

	/**
	 * 후입선출 구조
	 * 
	 * @author ssen(i@ssen.name)
	 */
	public class DSStackTest extends Sprite {
		public function DSStackTest() {
			var stk : ArrayedStack = new ArrayedStack();
			// top 에 값을 추가해준다.
			stk.push(1);
			stk.push(2);
			stk.push(3);
			stk.push(4);
			// top 에 존재하는 값을 가져온다.
			trace(stk, stk.top());
			// top 의 위치에 있는 값을 제거해준다.
			stk.pop();
			trace(stk);
		}
	}
}
