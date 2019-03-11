package ssen.styles.flour.btn {
	import ssen.core.draw.material.BitmapMaterial;
	import ssen.core.draw.material.IDrawMaterialSet;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourCloseBtnMaterial implements IDrawMaterialSet {
		private static var _material : FlourCloseBtnMaterial;

		public static function get material() : FlourCloseBtnMaterial {
			if (_material) return _material;
			_material = new FlourCloseBtnMaterial();
			return _material;
		}

		[Embed(source="close-run-default.png")]

		public static var runDefaultImage : Class;

		[Embed(source="close-run-over.png")]
		public static var runOverImage : Class;

		[Embed(source="close-disable-default.png")]
		public static var disableDefaultImage : Class;
		private var _run_default : BitmapData;
		private var _run_over : BitmapData;
		private var _disable_default : BitmapData;
		private var _material : BitmapMaterial;

		public function FlourCloseBtnMaterial() {
			_run_default = new runDefaultImage().bitmapData;
			_run_over = new runOverImage().bitmapData;
			_disable_default = new disableDefaultImage().bitmapData;
		
			_material = new BitmapMaterial(_run_default);
		}

		public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
			switch (state) {
				case "disable" :
					_material.bitmap = _disable_default;
					break;
				default :
					switch (action) {
						case "over" :
						case "down" : 
							_material.bitmap = _run_over;
							break;
						default : 
							_material.bitmap = _run_default;
							break;
					}
					break;
			}
			_material.draw(graphics, x, y, width, height, path);
		}
	}
}