package ssen.framework.widgets.core {
	import ssen.framework.ss_internal;
	import ssen.framework.widgets.core.events.WidgetEvent;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	use namespace ss_internal;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Widget extends EventDispatcher implements IWidget {
		private var _constructed : Boolean;
		private var _setted : Boolean;
		private var _registered : Boolean;
		private var _state : String;
		private var _service : DisplayObjectContainer;
		private var _index : int;

		final public function construct() : void {
			if (constructed) return;
			_constructed = true;
			wconstruct();
		}

		final public function setting(config : Object = null) : void {
			if (!constructed || setted) return;
			_setted = true;
			wsetting(config);
		}

		final public function register(service : DisplayObjectContainer = null, index : int = -1, initializeState : String = "run") : void {
			if (!constructed || !setted || registered) return;
			_registered = true;
			_service = service;
			_index = index;
			wregister(initializeState);
			dispatchEvent(new WidgetEvent(WidgetEvent.REGISTERED));
		}

		final public function deregister() : void {
			if (!registered) return;
			_registered = false;
			wderegister();
			dispatchEvent(new WidgetEvent(WidgetEvent.DEREGISTERED));
		}

		final public function unsetting() : void {
			if (registered || !setted) return;
			_setted = false;
			wunsetting();
		}

		final public function deconstruct() : void {
			if (registered || setted || !constructed) return;
			_constructed = false;
			wdeconstruct();
		}

		protected function wconstruct() : void {
		}

		protected function wsetting(config : Object) : void {
		}

		protected function wregister(initializeState : String = "run") : void {
		}

		protected function wderegister() : void {
		}

		protected function wunsetting() : void {
		}

		protected function wdeconstruct() : void {
		}

		final protected function addToService() : void {
			if (_index > -1) {
				_service.addChildAt(display, _index);
			} else {
				_service.addChild(display);
			}
		}

		final protected function removeFromService() : void {
			_service.removeChild(display);
			_service = null;
			_index = -1;
		}

		final public function get registered() : Boolean {
			return _registered;
		}

		final public function get setted() : Boolean {
			return _setted;
		}

		final public function get constructed() : Boolean {
			return _constructed;
		}

		public function get state() : String {
			return _state;
		}

		public function set state(state : String) : void {
			_state = state;
		}

		ss_internal function get display() : DisplayObject {
			return null;
		}
	}
}
