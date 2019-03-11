package ssen.debug {

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ErrMsg {
		public static function notImplements(msg : String) : String {
			return "!!!! not implements :: " + msg;
		}

		public static function typeUnMatch(msg : String) : String {
			return "!!!! type unmatch :: " + msg;
		}
	}
}
