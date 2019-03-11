package test {
	import de.polygonal.ds.ArrayedQueue;
	import de.polygonal.ds.pooling.ObjectPool;

	import flash.display.Sprite;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DSPoolTest extends Sprite {
		private var _pool : ObjectPool;

		public function DSPoolTest() {
			// pool 의 사용량과 총 크기를 알아낸다.
			trace(pool._count, pool.size());
			// 빈 pool 의 id 를 리턴해주고, used count 를 올려준다.
			// trace(pool.next());
			var queue : ArrayedQueue = new ArrayedQueue(pool.size());
			var dummy : Dummy = object;
			while(dummy) {
				trace("get", dummy);
				queue.enqueue(dummy);
				dummy = object;
			}
			trace(pool);
			while(!queue.isEmpty()) {
				object = Dummy(queue.dequeue());
			}
			trace(pool);
			
			// pool 을 allocate 이전의 상황으로 되돌려준다.
			pool.free();
		}

		/* *********************************************************************
		 * pool 생성 및 삭제
		 ********************************************************************* */
		public function get pool() : ObjectPool {
			if (_pool) return _pool;
			_pool = new ObjectPool(8);
			// by new Class();
			// pool.allocate(Dummy);
			// by factory method
			// pool.allocate(null, testFactoryMethod);
			// by Factory class instance
			_pool.allocate(null, null, new DummyFactory());
			return _pool;
		} 

		/* *********************************************************************
		 * pool 의 임대 및 반환
		 ********************************************************************* */
		public function get object() : Dummy {
			// 총 크기와 비교해서 넘으면 null 리턴
			if (pool._count >= pool.size()) return null;
			// 다음 id 를 알아낸다
			var id : int = pool.next();
			// 오브젝트를 받는다
			var dummy : Dummy = Dummy(pool.get(id));
			dummy.id = id;
			return dummy;
		}

		public function set object(object : Dummy) : void {
			// 오브젝트를 반환시킴
			pool.put(object.id);
		}

		private function testFactoryMethod() : Dummy {
			trace("created from Factory method");
			var dummy : Dummy = new Dummy;
			dummy.a = 10;
			dummy.b = 10;
			dummy.c = "created from Factory method";
			return dummy;
		}
	}
}

import de.polygonal.ds.pooling.Factory;

internal class Dummy {
	public var id : int;
	public var a : int;
	public var b : int;
	public var c : String;

	public function toString() : String {
		return ["Dummy", id, a, b, c].toString();
	}
}

internal class DummyFactory implements Factory {
	public function create() : Object {
		trace("created from Factory class");
		var dummy : Dummy = new Dummy;
		dummy.a = 10;
		dummy.b = 10;
		dummy.c = "created from Factory";
		return dummy;
	}
}