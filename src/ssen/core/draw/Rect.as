package ssen.core.draw {
	import ssen.core.draw.material.IDrawMaterial;

	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class Rect implements IDrawData {
		public var x : Number;
		public var y : Number;
		public var width : Number;
		public var height : Number;
		private var _material : IDrawMaterial;
		private var _path : GraphicsPath;

		public function Rect(x : Number = 0, y : Number = 0, width : Number = 100, height : Number = 100, material : IDrawMaterial = null) {
			_material = material;
			_path = new GraphicsPath();
			
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}

		public function draw(graphics : Graphics) : void {
			PathMaker.rect(_path, x, y, width, height);
			_material.draw(graphics, x, y, width, height, _path);
		}
		
		public function deconstruct() : void {
			_path = null;
			_material = null;
		}
	}
}
