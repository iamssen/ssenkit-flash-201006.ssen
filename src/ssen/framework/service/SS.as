package ssen.framework.service {

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class SS {
		private static var _frame : IFrameService;

		public static function get frame() : IFrameService {
			return _frame;
		}

		public static function set frame(frame : IFrameService) : void {
			_frame = frame;
		}
	}
}
