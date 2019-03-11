package ssen.core.net {
	import de.polygonal.ds.pooling.ObjectPool;

	import flash.net.URLRequest;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class LoadOrder {
		public static var size : int = 50;
		private static var _pool : ObjectPool;
		public var req : URLRequest;
		public var data : Object;
		public var httpStatus : int;
		public var errorMessage : String;
		public var factory : IValueObjectFactory;
		public var allow : Function;
		private var pid : int;
		public var id : String;

		public static function get(id : String, req : URLRequest, factory : IValueObjectFactory) : LoadOrder {
			if (!_pool) {
				_pool = new ObjectPool(size);
				_pool.allocate(LoadOrder);
			}
			if (_pool._count >= _pool.size()) return null;
			var pid : int = _pool.next();
			var lo : LoadOrder = LoadOrder(_pool.get(pid));
			lo.id = id;
			lo.pid = pid;
			lo.req = req;
			lo.factory = factory;
			lo.data = null;
			lo.httpStatus = 0;
			lo.errorMessage = "";
			lo.allow = null;
			return lo;
		}

		public static function put(lo : LoadOrder) : void {
			lo.id = "";
			lo.req = null;
			lo.data = null;
			lo.allow = null;
			lo.factory = null;
			_pool.put(lo.pid);
		}

		public static function free() : void {
			_pool.free();
			_pool = null;
		}
	}
}
