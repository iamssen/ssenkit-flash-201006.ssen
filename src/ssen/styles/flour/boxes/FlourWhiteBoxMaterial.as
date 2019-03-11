package ssen.styles.flour.boxes {
	import ssen.core.draw.material.BitmapMaterial;
	import ssen.core.draw.material.IDrawMaterialSet;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.geom.Rectangle;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourWhiteBoxMaterial implements IDrawMaterialSet {
		private static var _box : IDrawMaterialSet;

		public static function get box() : IDrawMaterialSet {
			if (_box) return _box;
			_box = new FlourWhiteBoxMaterial();
			return _box;
		}

		[Embed(source="white-run-default.png")]

		public static var runDefaultImage : Class;

		[Embed(source="white-disable-default.png")]
		public static var disableDefaultImage : Class;
		private var _run_default : BitmapData;
		private var _disable_default : BitmapData;
		private var _material : BitmapMaterial;

		public function FlourWhiteBoxMaterial() {
			_run_default = new runDefaultImage().bitmapData;
			_disable_default = new disableDefaultImage().bitmapData;
			_material = new BitmapMaterial(_run_default, false, new Rectangle(3, 3, 4, 4));
		}

		public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
			switch (state) {
				case "disable" :
					_material.bitmap = _disable_default;
					break;
				default : 
					_material.bitmap = _run_default;
					break;
			}
			_material.draw(graphics, x, y, width, height, path);
		}
	}
}
