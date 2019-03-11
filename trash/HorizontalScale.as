package ssen.core.draw 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class HorizontalScale extends GraphicsBitmapDraw
	{
		private var _x : Number;
		private var _y : Number;
		private var _width : Number;
		private var _height : Number;
		private var _leftFix : Number;
		private var _rightFix : Number;
		private var _fill : GraphicsBitmapFill;
		private var _mat : Matrix;
		private var _path : GraphicsPath;
		public function HorizontalScale(x : Number = 0, y : Number = 0, width : Number = 100, leftFix : Number = 10, rightFix : Number = 10, bitmapData : BitmapData = null, smooth : Boolean = false)
		{
			_fill = new GraphicsBitmapFill();
			_mat = new Matrix();
			_path = new GraphicsPath();
			
			_x = x;
			_y = y;
			_width = width;
			_height = bitmapData ? bitmapData.height : 100;
			_leftFix = leftFix;
			_rightFix = rightFix;
			
			this.bitmapData = bitmapData;
			this.smooth = smooth;
			changed = true;
		}
		override public function draw(graphics : Graphics) : void 
		{
			var min : Number = _leftFix + _rightFix;
			var ow : Number = bitmapData.width;
			var oh : Number = bitmapData.height;
			if (_width > min) {
				var cols : Array = [0, _leftFix, ow - _rightFix, ow];
				var dCols : Array = [0, _leftFix, _width - _rightFix, _width];

				var origin : Rectangle;
				var draw : Rectangle;
			
				var cx : int = -1;
				while(++cx < 3) {
					origin = new Rectangle(cols[cx], 0, cols[cx + 1] - cols[cx], _height);
					draw = new Rectangle(dCols[cx], 0, dCols[cx + 1] - dCols[cx], _height);
					_mat.identity();
					_mat.a = draw.width / origin.width;
					_mat.d = draw.height / origin.height;
					_mat.tx = (draw.x - origin.x * _mat.a) + _x;
					_mat.ty = (draw.y - origin.y * _mat.d) + _y;
					_fill.bitmapData = bitmapData;
					_fill.matrix = _mat;
					PathMaker.rect(_path, draw.x + _x, draw.y + _y, draw.width, draw.height);
					GraphicsDraw.draw(graphics, _path, _fill, stroke);
				}
			} else {
				_mat.identity();
				_mat.tx = _x % ow;
				_mat.ty = _y % oh;
				_mat.a = _width / ow;
				_mat.d = _height / oh;
				_fill.bitmapData = bitmapData;
				_fill.matrix = _mat;
				PathMaker.rect(_path, _x, _y, _width, _height);
				GraphicsDraw.draw(graphics, _path, _fill, stroke);
			}
			changed = false;
		}
		public function get x() : Number
		{
			return _x;
		}
		public function set x(x : Number) : void
		{
			_x = x;
			changed = true;
		}
		public function get y() : Number
		{
			return _y;
		}
		public function set y(y : Number) : void
		{
			_y = y;
			changed = true;
		}
		public function get width() : Number
		{
			return _width;
		}
		public function set width(width : Number) : void
		{
			_width = width;
			changed = true;
		}
		public function get height() : Number
		{
			return _height;
		}
		public function set height(height : Number) : void
		{
			_height = height;
			changed = true;
		}
		public function get leftFix() : Number
		{
			return _leftFix;
		}
		public function set leftFix(leftFix : Number) : void
		{
			_leftFix = leftFix;
			changed = true;
		}
		public function get rightFix() : Number
		{
			return _rightFix;
		}
		public function set rightFix(rightFix : Number) : void
		{
			_rightFix = rightFix;
			changed = true;
		}
	}
}
