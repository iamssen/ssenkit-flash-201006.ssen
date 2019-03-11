package ssen.framework.widgets.btns {
	import ssen.framework.widgets.btns.events.ClickEvent;
	import ssen.framework.widgets.core.WidgetState;

	import de.polygonal.ds.pooling.ObjectPool;

	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ClickBtnInteraction extends BtnInteraction {
		private var _timer : Timer;
		private var _clickTime : int;
		private var _longDownEnable : Boolean;
		private var _longDownTime : int;
		private var _evt : Boolean;
		private var _doubleClickTime : int;

		override public function setting(button : Btn, config : BtnConfig) : void {
			super.setting(button, config);
			_longDownEnable = config.longDownEnable;
			_longDownTime = config.longDownTime;
			_doubleClickTime = config.doubleClickTime;
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
			_button.dispatchEvent(new ClickEvent(ClickEvent.CLICK));
			if (getTimer() - _clickTime < _doubleClickTime) {
				_button.dispatchEvent(new ClickEvent(ClickEvent.DOUBLE_CLICK));
				_clickTime = 0;
			} else {
				_clickTime = getTimer();
			}
		}

		private function stageUp(event : MouseEvent) : void {
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, downTimeCheck);
			_sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, stageUp);
			_timer = null;
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
			if (_longDownEnable) {
				_timer = new Timer(_longDownTime);
				_timer.addEventListener(TimerEvent.TIMER, downTimeCheck);
				_timer.start();
				_sprite.stage.addEventListener(MouseEvent.MOUSE_UP, stageUp);
			}
		}

		private function downTimeCheck(event : TimerEvent) : void {
			_button.dispatchEvent(new ClickEvent(ClickEvent.LONG_DOWN));
			_timer.stop();		
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
		 * pooling
		 ********************************************************************* */
		public static var size : int = 40;
		private static var _pool : ObjectPool;

		public static function get() : ClickBtnInteraction {
			if (!_pool) {
				_pool = new ObjectPool(size);
				_pool.allocate(ClickBtnInteraction);
			}
			if (_pool._count >= _pool.size()) return null;
			var pid : int = _pool.next();
			var obj : ClickBtnInteraction = ClickBtnInteraction(_pool.get(pid));
			obj.pid = pid;
			return obj;
		}

		public static function put(obj : ClickBtnInteraction) : void {
			_pool.put(obj.pid);
		}

		public static function free() : void {
			_pool.free();
			_pool = null;
		}
	}
}
