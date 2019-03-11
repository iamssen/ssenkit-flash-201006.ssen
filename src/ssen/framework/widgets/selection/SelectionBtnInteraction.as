package ssen.framework.widgets.selection {
	import ssen.debug.ErrMsg;
	import ssen.framework.widgets.btns.Btn;
	import ssen.framework.widgets.btns.BtnInteraction;
	import ssen.framework.widgets.btns.BtnConfig;
	import ssen.framework.widgets.core.WidgetState;

	import de.polygonal.ds.pooling.ObjectPool;

	import flash.events.MouseEvent;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SelectionBtnInteraction extends BtnInteraction {
		private var _selection : Boolean;
		private var _selectionGroup : SelectionGroup;
		private var _value : Object;
		private var _evt : Boolean;

		override public function setting(button : Btn, config : BtnConfig) : void {
			super.setting(button, config);
			if (!config.selectionGroup) throw new Error(ErrMsg.typeUnMatch("BtnConfig 에 selectionConfig 정보가 없음"));
			_selectionGroup = config.selectionGroup;
			_selection = config.selection;
			_value = config.selectionValue;
		}

		override public function register(initializeState : String) : void {
			state = initializeState;
		}

		override public function deregister() : void {
			eventOff();
		}

		override public function unsetting() : void {
			super.unsetting();
			_selectionGroup = null;
			_value = null;
			put(this);
		}

		override public function set state(state : String) : void {
			if (state == WidgetState.PREVIEW) state = WidgetState.DISABLE;
			if (super.state == state) return;
			super.state = state;
			switch (state) {
				case WidgetState.RUN : 
					setDrawState(WidgetState.RUN);
					break;
				case WidgetState.DISABLE : 
					setDrawState(WidgetState.DISABLE);
					break;
			}
			
			interactionOnOff();
		}

		override public function get drawState() : String {
			if (state == WidgetState.RUN && selection) {
				return "selected";
			} else {
				return state;
			}
		}

		private function interactionOnOff() : void {
			if (state == WidgetState.DISABLE || (selection && !_selectionGroup.multiSelection)) {
				eventOff();
			} else {
				eventOn();
			}
		}

		private function eventOn() : void {
			if (_evt) return;
			_evt = true;
			_sprite.mouseEnabled = true;
			_sprite.buttonMode = true;
			_sprite.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			_sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_sprite.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_sprite.addEventListener(MouseEvent.CLICK, click);
		}

		private function eventOff() : void {
			if (!_evt) return;
			_evt = false;
			_sprite.mouseEnabled = false;
			_sprite.buttonMode = false;
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
			_selectionGroup.selection(_button, !_selection);
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
		 * selection 
		 ********************************************************************* */
		public function get selection() : Boolean {
			return _selection;
		}

		public function set selection(selection : Boolean) : void {
			if (_selection == selection) return;
			_selection = selection;
			setDrawState(WidgetState.RUN);
			interactionOnOff();
		}

		public function get value() : Object {
			return _value;
		}

		/* *********************************************************************
		 * pooling
		 ********************************************************************* */
		public static var size : int = 40;
		private static var _pool : ObjectPool;

		public static function get() : SelectionBtnInteraction {
			if (!_pool) {
				_pool = new ObjectPool(size);
				_pool.allocate(SelectionBtnInteraction);
			}
			if (_pool._count >= _pool.size()) return null;
			var pid : int = _pool.next();
			var obj : SelectionBtnInteraction = SelectionBtnInteraction(_pool.get(pid));
			obj.pid = pid;
			return obj;
		}

		public static function put(obj : SelectionBtnInteraction) : void {
			_pool.put(obj.pid);
		}

		public static function free() : void {
			_pool.free();
			_pool = null;
		}
	}
}
