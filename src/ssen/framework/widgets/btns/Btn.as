package ssen.framework.widgets.btns {
	import ssen.core.draw.PathMaker;
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.debug.ErrMsg;
	import ssen.framework.widgets.core.InvalidSpriteWidget;
	import ssen.framework.widgets.selection.ISelectionItem;
	import ssen.framework.widgets.selection.SelectionBtnInteraction;
	import ssen.framework.widgets.togglers.IToggler;
	import ssen.framework.widgets.togglers.ToggleBtnInteraction;
	import ssen.styles.flour.btn.FlourBtnStyleSet;

	import flash.display.GraphicsPath;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Btn extends InvalidSpriteWidget implements IToggler, ISelectionItem {
		private var _material : IDrawMaterialSet;
		private var _interaction : BtnInteraction;
		private var _width : Number;
		private var _height : Number;
		private var _path : GraphicsPath;
		private var _drawState : String;
		private var _drawAction : String;

		protected function getMaterial() : IDrawMaterialSet {
			return FlourBtnStyleSet.material;
		}

		private function getInteraction() : BtnInteraction {
			return ClickBtnInteraction.get();
		}

		/* *********************************************************************
		 * widget
		 ********************************************************************* */
		override protected function wsetting(config : Object) : void {
			if (!config is BtnConfig) throw new Error(ErrMsg.typeUnMatch("BtnConfig 가 필요함"));
			var cfg : BtnConfig = BtnConfig(config);
			_material = cfg.material ? cfg.material : getMaterial();
			_interaction = cfg.interaction ? cfg.interaction : getInteraction();
			_interaction.setting(this, cfg);
			
			_width = cfg.width;
			_height = cfg.height;
			_drawAction = "default";
			
			setInvalid("size", true);
		}

		override protected function wregister(initializeState : String = "run") : void {
			_interaction.register(initializeState);
			_path = new GraphicsPath();
			render();
			addToService();
		}

		override protected function wderegister() : void {
			_interaction.deregister();
			_path = null;
			removeFromService();
			graphics.clear();
		}

		override protected function wunsetting() : void {
			_material = null;
			unsetInvalidate();
			_interaction.unsetting();
			_interaction = null;
		}

		/* *********************************************************************
		 * runtime 
		 ********************************************************************* */
		override public function get state() : String {
			return _interaction.state;
		}

		override public function set state(state : String) : void {
			_interaction.state = state;
		}

		override public function get width() : Number {
			return _width;
		}

		public function set width(width : Number) : void {
			_width = width;
			setInvalid("width", true);
		}

		override public function get height() : Number {
			return _height;
		}

		public function set height(height : Number) : void {
			_height = height;
			setInvalid("height", true);
		}

		/* *********************************************************************
		 * state
		 ********************************************************************* */
		public function setDrawState() : void {
			if (_interaction.drawState != _drawState) {
				_drawState = _interaction.drawState;
				setInvalid("draw", true);
			}
		}

		public function setDrawAction() : void {
			if (_interaction.drawAction != _drawAction) {
				_drawAction = _interaction.drawAction;
				setInvalid("draw", true);
			}
		}

		protected function get drawState() : String {
			return _drawState;
		}

		protected function get drawAction() : String {
			return _drawAction;
		}

		/* *********************************************************************
		 * implements IToggler 
		 ********************************************************************* */
		public function get toggle() : Boolean {
			if (_interaction is ToggleBtnInteraction) return ToggleBtnInteraction(_interaction).toggle;
			return false;
		}

		public function set toggle(toggle : Boolean) : void {
			if (_interaction is ToggleBtnInteraction) ToggleBtnInteraction(_interaction).toggle = toggle;
		}

		/* *********************************************************************
		 * implements ISelectionItem 
		 ********************************************************************* */
		public function get selection() : Boolean {
			if (_interaction is SelectionBtnInteraction) return SelectionBtnInteraction(_interaction).selection;
			return false;
		}

		public function set selection(selection : Boolean) : void {
			if (_interaction is SelectionBtnInteraction) SelectionBtnInteraction(_interaction).selection = selection;
		}

		public function get value() : Object {
			if (_interaction is SelectionBtnInteraction) return SelectionBtnInteraction(_interaction).value;
			return null;
		}

		/* *********************************************************************
		 * rendering
		 ********************************************************************* */
		override protected function rendering() : void {
			if (getInvalid("size") || getInvalid("draw")) {
				graphics.clear();
				PathMaker.rect(_path, 0, 0, width, height);
				_material.draw(drawState, drawAction, graphics, 0, 0, width, height, _path);
			}
			super.rendering();
		}
	}
}