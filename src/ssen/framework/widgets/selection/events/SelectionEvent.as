package ssen.framework.widgets.selection.events {
	import ssen.debug.tostr;
	import ssen.framework.widgets.selection.SelectionGroup;

	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SelectionEvent extends Event {
		public static const SELECTION : String = "selection";
		private var _selectionGroup : SelectionGroup;

		public function SelectionEvent(type : String, selectionGroup : SelectionGroup, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			_selectionGroup = selectionGroup;
		}

		public function get selectionGroup() : SelectionGroup {
			return _selectionGroup;
		}

		
		override public function clone() : Event {
			return new SelectionEvent(type, selectionGroup, bubbles, cancelable);
		}

		
		override public function toString() : String {
			return tostr("SelectionEvent", {type:type, selectionGroup:selectionGroup});
		}
	}
}
