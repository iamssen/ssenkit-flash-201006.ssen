package ssen.framework.widgets.btns {
	import ssen.framework.ss_internal;

	import flash.display.Sprite;
	
	use namespace ss_internal;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BtnInteraction {
		protected var _button : Btn;
		protected var _sprite : Sprite;
		protected var _state : String;
		private var _drawState : String;
		private var _drawAction : String;
		public var pid : int;

		public function setting(button : Btn, config : BtnConfig) : void {
			_button = button;
			_sprite = Sprite(button.display);
			_sprite.mouseChildren = false;
		}

		public function unsetting() : void {
			_button = null;
			_sprite = null;
		}

		public function register(initializeState : String) : void {
		}

		public function deregister() : void {
		}

		public function get state() : String {
			return _state;
		}

		public function set state(state : String) : void {
			_state = state;
		}

		protected function setDrawState(state : String) : void {
			_drawState = state;
			_button.setDrawState();
		}

		protected function setDrawAction(action : String) : void {
			_drawAction = action;
			_button.setDrawAction();
		}

		public function get drawState() : String {
			return _drawState;
		}

		public function get drawAction() : String {
			return _drawAction;
		}
	}
}
