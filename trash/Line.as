package test {
	import ssen.core.draw.materials.GraphicsMaterial;

	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class Line extends DrawShape {
		public var x0 : Number;
		public var x1 : Number;
		public var y0 : Number;
		public var y1 : Number;
		private var _path : GraphicsPath;
		private var _material : GraphicsMaterial;

		public function Line(x0 : Number, x1 : Number, y0 : Number, y1 : Number, visible : Boolean = true) {
			this.x0 = x0;
			this.x1 = x1;
			this.y0 = y0;
			this.y1 = y1;
			super(visible);
		}

		/* *********************************************************************
		 * get
		 ********************************************************************* */
		override public function getPath() : GraphicsPath {
			return _path;
		}

		public function get material() : GraphicsMaterial {
			return _material;
		}

		public function set material(material : GraphicsMaterial) : void {
			_material = material;
		}

		public function draw(graphics : Graphics) : void {
			if (_material) _material.draw(graphics, this);
		}
	}
}
