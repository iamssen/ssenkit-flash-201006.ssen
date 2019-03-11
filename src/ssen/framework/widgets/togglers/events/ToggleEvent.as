package ssen.framework.widgets.togglers.events {
	import ssen.debug.tostr;

	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToggleEvent extends Event {
		public static const TOGGLE : String = "toggle";
		private var _toggle : Boolean;

		public function ToggleEvent(type : String, toggle : Boolean, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			_toggle = toggle;
		}

		public function get toggle() : Boolean {
			return _toggle;
		}

		
		override public function clone() : Event {
			return new ToggleEvent(type, toggle, bubbles, cancelable);
		}

		override public function toString() : String {
			return tostr("ToggleEvent", {type:type, toggle:toggle});
		}
	}
}
