package ssen.core.net {
	import flash.display.Loader;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class UnloadCollection {
		private var _col : Vector.<Loader>;

		public function UnloadCollection() {
			_col = new Vector.<Loader>;
		}

		public function add(loader : Loader) : void {
			_col.push(loader);
		}

		public function unloadAndStop() : void {
			var f : int = _col.length;
			while (--f >= 0) {
				_col[f].unloadAndStop();
			}
			_col.length = 0;
		}
	}
}
