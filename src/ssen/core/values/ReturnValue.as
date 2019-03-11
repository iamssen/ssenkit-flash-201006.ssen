package ssen.core.values {
	import ssen.debug.tostr;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class ReturnValue {
		public var error : int;
		public var errorMessage : String;

		public function ReturnValue(error : int = 0, errorMessage : String = "") {
			this.error = error;
			this.errorMessage = errorMessage;
		}

		public function toString() : String {
			if (error) return tostr("Error", {type:error, errorMessage:errorMessage});
			return toString2();
		}

		protected function toString2() : String {
			return "";
		}
	}
}
