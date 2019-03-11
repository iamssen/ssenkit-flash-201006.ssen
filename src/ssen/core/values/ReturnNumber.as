package ssen.core.values {
	import ssen.debug.tostr;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class ReturnNumber extends ReturnValue {
		private var _number : Number;

		public function ReturnNumber(number : Number = 0, error : int = 0, errorMessage : String = "") {
			super(error, errorMessage);
			_number = number;
		}

		public function get number() : Number {
			return _number;
		}

		override protected function toString2() : String {
			return tostr("ReturnNumber", {number:_number});
		}
	}
}
