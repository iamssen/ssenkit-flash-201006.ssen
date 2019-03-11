package ssen.framework.widgets.togglers {
	import ssen.framework.widgets.btns.BtnConfig;
	import ssen.framework.widgets.btns.Btn;
	import ssen.framework.widgets.btns.BtnInteraction;
	import ssen.framework.widgets.core.WidgetState;
	import ssen.framework.widgets.togglers.events.ToggleEvent;

	import de.polygonal.ds.pooling.ObjectPool;

	import flash.events.MouseEvent;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToggleBtnInteraction extends BtnInteraction {
		private var _toggle : Boolean;
		private var _evt : Boolean;

		override public function setting(button : Btn, config : BtnConfig) : void {
			super.setting(button, config);
			_toggle = config.toggle;
		}

		override public function unsetting() : void {
			super.unsetting();
			put(this);
		}

		override public function register(initializeState : String) : void {
			state = initializeState;
		}

		override public function deregister() : void {
			eventOff();
		}

		override public function set state(state : String) : void {
			if (state == WidgetState.PREVIEW) state = WidgetState.DISABLE;
			if (super.state == state) return;
			super.state = state;
			switch (state) {
				case WidgetState.RUN : 
					eventOn();
					setDrawState(WidgetState.RUN);
					break;
				case WidgetState.DISABLE : 
					eventOff();
					setDrawState(WidgetState.DISABLE);
					break;
			}
		}

		override public function get drawState() : String {
			if (state == WidgetState.RUN && toggle) {
				return "selected";
			} else {
				return state;
			}
		}

		private function eventOn() : void {
			if (_evt) return;
			_evt = true;
			_sprite.buttonMode = true;
			_sprite.mouseEnabled = true;
			_sprite.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			_sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_sprite.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_sprite.addEventListener(MouseEvent.CLICK, click);
		}

		private function eventOff() : void {
			if (!_evt) return;
			_evt = false;
			_sprite.buttonMode = false;
			_sprite.mouseEnabled = false;
			_sprite.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			_sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_sprite.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_sprite.removeEventListener(MouseEvent.CLICK, click);
		}

		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function click(event : MouseEvent) : void {
			_toggle = !_toggle;
			setDrawState(WidgetState.RUN);
			_button.dispatchEvent(new ToggleEvent(ToggleEvent.TOGGLE, _toggle));
		}

		private function mouseUp(event : MouseEvent) : void {
			if ((_sprite.mouseX > 0 && _sprite.mouseX < _button.width) && (_sprite.mouseY > 0 && _sprite.mouseY < _button.height)) {
				setDrawAction("over");
			} else {
				setDrawAction("default");
			}
		}

		private function mouseDown(event : MouseEvent) : void {
			setDrawAction("down");
		}

		private function mouseOut(event : MouseEvent) : void {
			setDrawAction("default");
		}

		private function mouseOver(event : MouseEvent) : void {
			if (event.buttonDown) {
				setDrawAction("down");
			} else {
				setDrawAction("over");
			}
		}

		/* *********************************************************************
		 * toggle 
		 ********************************************************************* */
		public function get toggle() : Boolean {
			return _toggle;
		}

		public function set toggle(toggle : Boolean) : void {
			_toggle = toggle;
			setDrawState(WidgetState.RUN);
		}

		/* *********************************************************************
		 * pooling
		 ********************************************************************* */
		public static var size : int = 40;
		private static var _pool : ObjectPool;

		public static function get() : ToggleBtnInteraction {
			if (!_pool) {
				_pool = new ObjectPool(size);
				_pool.allocate(ToggleBtnInteraction);
			}
			if (_pool._count >= _pool.size()) return null;
			var pid : int = _pool.next();
			var obj : ToggleBtnInteraction = ToggleBtnInteraction(_pool.get(pid));
			obj.pid = pid;
			return obj;
		}

		public static function put(obj : ToggleBtnInteraction) : void {
			_pool.put(obj.pid);
		}

		public static function free() : void {
			_pool.free();
			_pool = null;
		}
	}
}
