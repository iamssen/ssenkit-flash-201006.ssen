package ssen.core.draw.material {
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsFill;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class FrameMaterial implements IDrawMaterial {
		public static const POSITION_INSIDE : String = "inside";
		public static const POSITION_CENTER : String = "center";
		public static const POSITION_OUTSIDE : String = "outside";
		private var _borders : Vector.<Number>;
		private var _outerFill : IGraphicsFill;
		private var _innerFill : IGraphicsFill;
		private var _borderPosition : String;

		public function FrameMaterial(border : Object, outerFill : IGraphicsFill, innerFill : IGraphicsFill, borderPosition : String = "inside") {
			_borders = new Vector.<Number>(4, true);
			setBorder(border);
			_outerFill = outerFill;
			_innerFill = innerFill;
			_borderPosition = borderPosition;
		}

		private function setBorder(border : Object) : void {
			if (!isNaN(Number(border))) {
				_borders[0] = _borders[1] = _borders[2] = _borders[3] = Number(border);
			} else {
				_borders[0] = border["top"];
				_borders[1] = border["right"];
				_borders[2] = border["bottom"];
				_borders[3] = border["left"];
			}
		}

		public function get borderTop() : Number {
			return _borders[0];
		}

		public function set borderTop(borderTop : Number) : void {
			_borders[0] = borderTop;
		}

		public function get borderRight() : Number {
			return _borders[1];
		}

		public function set borderRight(borderRight : Number) : void {
			_borders[1] = borderRight;
		}

		public function get borderBottom() : Number {
			return _borders[2];
		}

		public function set borderBottom(borderBottom : Number) : void {
			_borders[2] = borderBottom;
		}

		public function get borderLeft() : Number {
			return _borders[3];
		}

		public function set borderLeft(borderLeft : Number) : void {
			_borders[3] = borderLeft;
		}

		public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		}

		public function get outerFill() : IGraphicsFill {
			return _outerFill;
		}

		public function set outerFill(outerFill : IGraphicsFill) : void {
			_outerFill = outerFill;
		}

		public function get innerFill() : IGraphicsFill {
			return _innerFill;
		}

		public function set innerFill(innerFill : IGraphicsFill) : void {
			_innerFill = innerFill;
		}

		public function get borderPosition() : String {
			return _borderPosition;
		}

		public function set borderPosition(borderPosition : String) : void {
			_borderPosition = borderPosition;
		}
	}
}
