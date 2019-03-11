package ssen.debug {
	import ssen.core.DisplayX;

	import flash.display.Sprite;

	/**
	 * 간단한 입력으로 TestButton 을 여러개 사용할 수 있다.
	 * @author SSen
	 */
	public class TestButtonGroup extends Sprite {
		private var _group : Array;

		/**
		 * 새로운 TestButtonGroup 을 생성함
		 * @param test 홀수 인자는 테스트 제목, 짝수 인자는 테스트 함수로 입력해야 한다
		 */
		public function TestButtonGroup(...test) {
			_group = new Array();
			
			var f : int;
			var btn : TestButton;
			for (f = 0;f < test.length;f += 2) {
				btn = new TestButton(test[f], test[f + 1]);
				addChild(btn);
				_group.push(btn);
			}
			
			align();
		}

		/**
		 * 새로운 테스트들을 추가한다
		 * @param test 홀수 인자는 테스트 제목, 짝수 인자는 테스트 함수로 입력해야 한다
		 */
		public function addTest(...test) : void {
			var f : int;
			var btn : TestButton;
			for (f = 0;f < test.length;f += 2) {
				btn = new TestButton(test[f], test[f + 1]);
				addChild(btn);
				_group.push(btn);
			}
			
			align();
		}

		// 정렬
		private function align() : void {
			DisplayX.align(_group);
		}
	}
}
