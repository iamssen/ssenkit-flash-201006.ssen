package ssen.core.draw.material {
	import ssen.core.draw.PathMaker;

	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class RoundRectMaterial implements IDrawMaterial {
		private var _fill : IGraphicsFill;
		private var _stroke : IGraphicsStroke;
		private var _ellipseWidth : Number;
		private var _ellipseHeight : Number;

		public function RoundRectMaterial(ellipseWidth : Number = 10, ellipseHeight : Number = 10, fill : IGraphicsFill = null, stroke : IGraphicsStroke = null) {
			_ellipseWidth = ellipseWidth;
			_ellipseHeight = ellipseHeight;
			_fill = fill;
			_stroke = stroke;
		}

		public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
			var p : GraphicsPath = new GraphicsPath();
			PathMaker.roundRect(p, x, y, width, height, ellipseWidth, ellipseHeight);
			graphics.drawGraphicsData(Vector.<IGraphicsData>([_fill, _stroke, p, new GraphicsEndFill()]));
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

		public function get ellipseWidth() : Number {
			return _ellipseWidth;
		}

		public function set ellipseWidth(ellipseWidth : Number) : void {
			_ellipseWidth = ellipseWidth;
		}

		public function get ellipseHeight() : Number {
			return _ellipseHeight;
		}

		public function set ellipseHeight(ellipseHeight : Number) : void {
			_ellipseHeight = ellipseHeight;
		}
	}
}
