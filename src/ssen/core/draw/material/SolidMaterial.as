package ssen.core.draw.material {
	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class SolidMaterial implements IDrawMaterial {
		private var _fill : IGraphicsFill;
		private var _stroke : IGraphicsStroke;

		public function SolidMaterial(fill : IGraphicsFill = null, stroke : IGraphicsStroke = null) {
			_fill = fill;
			_stroke = stroke;
		}

		public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
			graphics.drawGraphicsData(Vector.<IGraphicsData>([_fill, _stroke, path, new GraphicsEndFill()]));
		}

		public function get fill() : IGraphicsFill {
			return _fill;
		}

		public function set fill(fill : IGraphicsFill) : void {
			_fill = fill;
		}

		public function get stroke() : IGraphicsStroke {
			return _stroke;
		}

		public function set stroke(stroke : IGraphicsStroke) : void {
			_stroke = stroke;
		}
	}
}
