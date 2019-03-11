package ssen.framework.widgets.core.events {
	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class WidgetEvent extends Event {
		public static const REGISTERED : String = "registered";
		public static const DEREGISTERED : String = "deregistered";

		public function WidgetEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
