package test {
	import flash.utils.getTimer;

	import de.polygonal.ds.SLLNode;
	import de.polygonal.ds.DLLNode;
	import de.polygonal.ds.DLL;
	import de.polygonal.ds.SLL;

	import flash.display.Sprite;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DSLinkedListTest extends Sprite {
		public function DSLinkedListTest() {
			var max : int = 1 << 10;
			// node.prev 가 지원되는 양방향형 linked list
			var dll : DLL = new DLL(max);
			// node.prev 가 지원되지 않는 단방향형 linked list
			var sll : SLL = new SLL(max);
			var f : int = -1;
			while(++f < max) {
				dll.append(f);
				sll.append(f);
			}
			
			// 특정 노드 뒤에 새로운 값을 추가한다.
			//dll.insertAfter(dn, 5);
			// 특정 노드 앞에 새로운 값을 추가한다.
			//dll.insertBefore(dn, 6);
			// 특정 순서의 노드를 가져온다.
			trace(dll.getNodeAt(10));
			// 맨 앞의 노드를 가져온다.
			trace(dll.head());
			// 맨 뒤의 노드를 가져온다.
			trace(dll.tail());
			
			
			
			var dn : DLLNode = dll.getNodeAt(0);
			var sn : SLLNode = sll.getNodeAt(0);
			var t : int;
			
			t = getTimer();
			while(dn.hasNext()) {
				dn = dn.next;
			}
			trace(getTimer() - t);
			
			t = getTimer();
			while(sn.hasNext()) {
				sn = sn.next;
			}
			trace(getTimer() - t);
		}
	}
}
