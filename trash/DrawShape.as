package test {
	import ssen.core.draw.materials.IDrawMaterial;

	import flash.display.GraphicsPath;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DrawShape {
		private var _visible : Boolean;
		protected var _material : IDrawMaterial;
		protected var _path : GraphicsPath;

		public function DrawShape(visible : Boolean) {
			_visible = visible;
		}

		public function getPath() : GraphicsPath {
			return null;
		}

		public function get visible() : Boolean {
			return _visible;
		}

		public function set visible(visible : Boolean) : void {
			_visible = visible;
		}		
	}
}
