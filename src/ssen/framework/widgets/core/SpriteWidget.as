package ssen.framework.widgets.core {
	import ssen.framework.ss_internal;

	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	use namespace ss_internal;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SpriteWidget extends Widget {
		private var _display : Sprite;

		override protected function wconstruct() : void {
			_display = new Sprite();
		}

		override protected function wdeconstruct() : void {
			_display = null;
		}

		override ss_internal function get display() : DisplayObject {
			return _display;
		}

		protected function get graphics() : Graphics {
			return _display.graphics;
		}

		protected function get sprite() : Sprite {
			return _display;
		}

		public function get x() : Number {
			return _display.x;
		}

		public function set x(x : Number) : void {
			_display.x = x;
		}

		public function get y() : Number {
			return _display.y;
		}

		public function set y(y : Number) : void {
			_display.y = y;
		}

		public function get width() : Number {
			return _display.width;
		}

		public function get height() : Number {
			return _display.height;
		}
	}
}
