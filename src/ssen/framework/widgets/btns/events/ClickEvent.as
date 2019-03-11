package ssen.framework.widgets.btns.events {
	import ssen.debug.tostr;

	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ClickEvent extends Event {
		public static const LONG_DOWN : String = "buttonLongDown";
		public static const CLICK : String = "buttonClick";
		public static const DOUBLE_CLICK : String = "buttonDoubleClick";

		public function ClickEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			return new ClickEvent(type, bubbles, cancelable);
		}

		override public function toString() : String {
			return tostr("ButtonEvent", {type:type});
		}
	}
}
