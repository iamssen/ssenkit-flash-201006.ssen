package ssen.core.values {
	import ssen.debug.tostr;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class ReturnString extends ReturnValue {
		private var _string : String;

		public function ReturnString(str : String, error : int = 0, errorMessage : String = "") {
			super(error, errorMessage);
			_string = str;
		}

		public function get string() : String {
			return _string;
		}

		override protected function toString2() : String {
			return tostr("ReturnString", {string:_string});
		}
	}
}
