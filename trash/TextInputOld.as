package ssen.framework.widgets.input {
	import ssen.core.draw.PathMaker;
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.core.geom.Padding;
	import ssen.framework.widgets.core.InvalidSpriteWidget;
	import ssen.framework.widgets.scroll.Scroll;
	import ssen.framework.widgets.scroll.ScrollDirection;
	import ssen.framework.widgets.scroll.scrollConfig;

	import flash.display.GraphicsPath;
	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextInputOld extends InvalidSpriteWidget {
		private var _scrv : Scroll;
		private var _scrh : Scroll;
		private var _width : Number;
		private var _height : Number;
		private var _material : IDrawMaterialSet;
		private var _control : TextControl;
		private var _padding : Padding;

		protected function getMaterial() : IDrawMaterialSet {
			return DefaultMaterial.material;
		}

		protected function getScrollV() : Scroll {
			var scroll : Scroll = new Scroll();
			return scroll;
		}

		protected function getScrollH() : Scroll {
			var scroll : Scroll = new Scroll();
			return scroll;
		}

		protected function getTextWidget() : TextControl {
			return new MultilineTextControl();
		}

		protected function getPadding() : Padding {
			return new Padding(10, 10, 10, 10);
		}

		/* *********************************************************************
		 * widget 
		 ********************************************************************* */
		override protected function wconstruct() : void {
			super.wconstruct();
			_scrv = getScrollV();
			_scrh = getScrollH();
			_material = getMaterial();
			_scrv.construct();
			_scrh.construct();
			_padding = getPadding();
		}

		override protected function wsetting(config : Object) : void {
			config["input"] = this;
			_width = config["width"];
			_height = config["height"];
			_control = config["textWidget"] ? config["textWidget"] : getTextWidget();
			_control.construct();
			_control.setting(config);
			
			var vw : Number = _control.verticalScrollEnabled ? 10 : 0;
			var hh : Number = _control.horizontalScrollEnabled ? 10 : 0;
			if (_control.horizontalScrollEnabled) _scrh.setting(scrollConfig(ScrollDirection.HORIZONTAL, _width - _padding.leftAndRight - vw, hh));
			if (_control.verticalScrollEnabled) _scrv.setting(scrollConfig(ScrollDirection.VERTICAL, vw, _height - _padding.topAndBottom - hh));
			//objstr("test", config);
			setInvalid("size", true);
			setInvalid("compose", true);
		}

		override protected function wregister(initializeState : String = "run") : void {
			_control.register(sprite, -1, initializeState);
			if (_control.horizontalScrollEnabled) {
				_scrh.register(sprite, -1, initializeState);
				_scrh.addEventListener(Event.SCROLL, scrollHandler);
			}
			if (_control.verticalScrollEnabled) {
				_scrv.register(sprite, -1, initializeState);
				_scrv.addEventListener(Event.SCROLL, scrollHandler);
			}
			addToService();
			render();
			state = initializeState;
		}

		private function scrollHandler(event : Event) : void {
			if (_scrh.registered) _control.horizontalScrollPosition = _scrh.scrollPosition;
			if (_scrv.registered) _control.verticalScrollPosition = _scrv.scrollPosition;
		}

		override protected function wderegister() : void {
			_control.deregister();
			graphics.clear();
			removeFromService();
		}

		override protected function wunsetting() : void {
		}

		override protected function wdeconstruct() : void {
			super.wdeconstruct();
		}

		/* *********************************************************************
		 * runtime 
		 ********************************************************************* */
		override public function set state(state : String) : void {
			super.state = state;
			// TODO
		}

		public function get width() : Number {
			return _width;
		}

		public function set width(width : Number) : void {
			_width = width;
			setInvalid("size", true);
		}

		public function get height() : Number {
			return _height;
		}

		public function set height(height : Number) : void {
			_height = height;
			setInvalid("size", true);
		}

		/* *********************************************************************
		 * draw 
		 ********************************************************************* */
		public function setDrawState() : void {
		}

		public function setDrawAction() : void {
		}

		public function scroll() : void {
			if (_scrh.registered) {
				_scrh.scrollPosition = _control.horizontalScrollPosition;
			}
			if (_scrv.registered) {
				_scrv.scrollPosition = _control.verticalScrollPosition;
			}
		}

		public function composition() : void {
			//if (_control.getTextFlow().flowComposer) _control.getTextFlow().flowComposer.composeToPosition();
			var bounds : Rectangle = _control.getContentBounds();
			var tw : int = Math.ceil(bounds.width);
			var th : int = Math.ceil(bounds.height);
			if (_scrh.registered) {
				_scrh.resetScrollInfo(0, tw - _control.compositionWidth, tw);
			}
			if (_scrv.registered) {
				_scrv.resetScrollInfo(0, th - _control.compositionHeight, th);
			}
			trace(0, tw - _control.compositionWidth, tw, 0, th - _control.compositionHeight, th, bounds);
		}

		/* *********************************************************************
		 * rendering
		 ********************************************************************* */
		override protected function rendering() : void {
			var vscroll : Boolean = _scrv.registered;
			var hscroll : Boolean = _scrh.registered;
			if (getInvalid("size") || getInvalid("state")) {
				if (_material) {
					graphics.clear();
					var path : GraphicsPath = new GraphicsPath();
					PathMaker.rect(path, 0, 0, width, height);
					_material.draw(state, "default", graphics, 0, 0, width, height, path);
				}
			}
			if (getInvalid("size")) {
				if (vscroll && hscroll) {
					_control.container.x = _padding.left;
					_control.container.y = _padding.top;
					_control.compositionWidth = _width - _scrv.width - _padding.leftAndRight;
					_control.compositionHeight = _height - _scrh.height - _padding.topAndBottom;
					_scrh.width = _control.compositionWidth;
					_scrh.display.x = _padding.left;
					_scrh.display.y = _control.container.y + _control.compositionHeight;
					_scrv.height = _control.compositionHeight;
					_scrv.display.x = _control.container.x + _control.compositionWidth;
					_scrv.display.y = _padding.top;
				} else if (vscroll && !hscroll) {
					_control.container.x = _padding.left;
					_control.container.y = _padding.top;
					_control.compositionWidth = _width - _scrv.width - _padding.leftAndRight;
					_control.compositionHeight = _height - _padding.topAndBottom;
					_scrv.height = _control.compositionHeight;
					_scrv.display.x = _control.container.x + _control.compositionWidth;
					_scrv.display.y = _padding.top;
				} else if (!vscroll && hscroll) {
					_control.container.x = _padding.left;
					_control.container.y = _padding.top;
					_control.compositionWidth = _width - _padding.leftAndRight;
					_control.compositionHeight = _height - _scrh.height - _padding.topAndBottom;
					_scrh.width = _control.compositionWidth;
					_scrh.display.x = _padding.left;
					_scrh.display.y = _control.container.y + _control.compositionHeight;
				} else {
					_control.container.x = _padding.left;
					_control.container.y = _padding.top;
					_control.compositionWidth = _width - _padding.leftAndRight;
					_control.compositionHeight = _height - _padding.topAndBottom;
				}
				_control.updateContainer();
			}
			
			if (getInvalid("compose")) {
				_control.composeToPosition();
				composition();
			}
			
			super.rendering();
		}
	}
}

import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.draw.material.SolidMaterial;

import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;

internal class DefaultMaterial implements IDrawMaterialSet {
	private var _default : SolidMaterial;
	private static var _material : DefaultMaterial;

	public static function get material() : DefaultMaterial {
		if (_material) return _material;
		_material = new DefaultMaterial();
		return _material;
	}

	public function DefaultMaterial() {
		_default = new SolidMaterial(new GraphicsSolidFill(0xaaaaaa));
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		_default.draw(graphics, x, y, width, height, path);
	}
}