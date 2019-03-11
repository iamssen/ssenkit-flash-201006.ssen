package ssen.styles.flour.boxes {
	import ssen.core.draw.material.BitmapMaterial;
	import ssen.core.draw.material.IDrawMaterial;

	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.geom.Rectangle;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourWindowBoxMaterial implements IDrawMaterial {

		[Embed(source="window-bg-run-default.png")]
		public static var bgImage : Class;

		[Embed(source="window-inner-run-default.png")]
		public static var innerImage : Class;
		private static var _bg : BitmapMaterial;
		private static var _inner : BitmapMaterial;
		private var _headerHeight : int;

		public function FlourWindowBoxMaterial(headerHeight : int = 22) {
			_headerHeight = headerHeight;
			if (!_bg) {
				_bg = new BitmapMaterial(new bgImage().bitmapData, false, new Rectangle(12, 20, 26, 18));
				_inner = new BitmapMaterial(new innerImage().bitmapData, false, new Rectangle(12, 12, 26, 26));
			}
		}

		public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
			_bg.draw(graphics, x, y, width, height, path);
			_inner.draw(graphics, x + 4, y + headerHeight, width - 8, height - headerHeight - 4);
		}

		public function get headerHeight() : int {
			return _headerHeight;
		}

		public function set headerHeight(headerHeight : int) : void {
			_headerHeight = headerHeight;
		}
	}
}