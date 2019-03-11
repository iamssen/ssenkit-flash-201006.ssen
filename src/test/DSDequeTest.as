package test {
	import de.polygonal.ds.ArrayedDeque;

	import flash.display.Sprite;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DSDequeTest extends Sprite {
		public function DSDequeTest() {
			var deq : ArrayedDeque = new ArrayedDeque(4);
			// < 전방에 값을 쌓아준다.
			deq.pushFront(1);
			deq.pushFront(2);
			deq.pushFront(3);
			// < 전방값, > 후방값
			trace(deq.front(), deq.back());
			// > 후방에 값을 쌓아준다.
			deq.pushBack(9);
			trace(deq.front(), deq.back());
			// < 전방의 값을 삭제해준다.
			deq.popFront();
			// > 후방의 값을 삭제해준다.
			deq.popBack();
			trace(deq._size, deq._count);
			deq.popBack();
			trace(deq._size, deq._count);
			deq.popBack();
			trace(deq._size, deq._count);
			deq.popBack();
			trace(deq._size, deq._count);
			deq.popBack();
			deq.popBack();
			deq.popBack();
			deq.popBack();
			trace(deq.front(), deq.back());
		}
	}
}
