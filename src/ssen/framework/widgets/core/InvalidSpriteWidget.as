package ssen.framework.widgets.core {
	import ssen.framework.service.SS;
	import ssen.framework.widgets.core.events.WidgetEvent;

	import de.polygonal.ds.HashMap;

	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class InvalidSpriteWidget extends SpriteWidget {
		private var _invalid : HashMap;

		override protected function wconstruct() : void {
			super.wconstruct();
			_invalid = new HashMap();
		}

		private function invalidate() : void {
			if (registered) {
				SS.frame.stage.addEventListener(Event.RENDER, render, false, 0, true);
				SS.frame.stage.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
				SS.frame.stage.invalidate();
			} else {
				addEventListener(WidgetEvent.REGISTERED, onRegistered, false, 0, true);
			}
		}

		private function onRegistered(event : WidgetEvent) : void {
			removeEventListener(WidgetEvent.REGISTERED, onRegistered);
			invalidate();
		}

		protected function render(event : Event = null) : void {
			if (registered) {
				SS.frame.stage.removeEventListener(Event.RENDER, render);
				SS.frame.stage.removeEventListener(Event.ENTER_FRAME, render);
			}
			if (_invalid.size() > 0) rendering();
		}

		protected function unsetInvalidate() : void {
			if (SS.frame.stage.hasEventListener(Event.RENDER)) SS.frame.stage.removeEventListener(Event.RENDER, render);
			if (SS.frame.stage.hasEventListener(Event.ENTER_FRAME)) SS.frame.stage.removeEventListener(Event.ENTER_FRAME, render);
			if (hasEventListener(WidgetEvent.REGISTERED)) removeEventListener(WidgetEvent.REGISTERED, onRegistered);
			_invalid.clear();
		}

		protected function rendering() : void {
			_invalid.clear();
		}

		protected final function setInvalid(key : String, val : Boolean) : void {
			if (_invalid.has(key)) {
				_invalid.remap(key, val);
			} else {
				_invalid.set(key, val);
			}
			invalidate();
		}

		protected final function getInvalid(key : String) : * {
			return _invalid.get(key);
		}
	}
}
