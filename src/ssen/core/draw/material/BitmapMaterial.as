package ssen.core.draw.material {
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class BitmapMaterial implements IDrawMaterial {
		private var _bitmap : BitmapData;
		private var _smooth : Boolean;
		private var _scale9Grid : Rectangle;

		public function BitmapMaterial(bitmapData : BitmapData, smooth : Boolean = false, scale9Grid : Rectangle = null) {
			_bitmap = bitmapData;
			_smooth = smooth;
			_scale9Grid = scale9Grid;
		}

		public function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
			if (!_scale9Grid) {
				defaultDraw(graphics, x, y, width, height);
			} else {
				var mat : Matrix;
				var topFix : Number = _scale9Grid.top;
				var bottomFix : Number = _bitmap.height - _scale9Grid.top - _scale9Grid.height;
				var leftFix : Number = _scale9Grid.left;
				var rightFix : Number = _bitmap.width - _scale9Grid.left - _scale9Grid.width;
				ow = _bitmap.width;
				oh = _bitmap.height;
				 
				var min : Number;
				var ow : Number;
				var oh : Number;
				var cols : Array;
				var dCols : Array;
				var rows : Array;
				var dRows : Array;
				
				var origin : Rectangle;
				var draw : Rectangle;
			
				var cy : int;
				var cx : int;
				if (_scale9Grid.x == 0 && (_scale9Grid.width == width || _scale9Grid.width == 0)) {
					min = topFix + bottomFix;
					
					if (height > min) {
						mat = new Matrix();
						rows = [0, topFix, oh - bottomFix, oh];
						dRows = [0, topFix, height - bottomFix, height];
				
						cy = -1;
						while(++cy < 3) {
							origin = new Rectangle(0, rows[cy], width, rows[cy + 1] - rows[cy]);
							draw = new Rectangle(0, dRows[cy], width, dRows[cy + 1] - dRows[cy]);
							mat.identity();
							mat.a = width / _bitmap.width;
							mat.d = draw.height / origin.height;
							mat.tx = (draw.x - origin.x * mat.a) + x;
							mat.ty = (draw.y - origin.y * mat.d) + y;
							scaleDraw(graphics, x, y, draw, mat);
						}
					} else {
						defaultDraw(graphics, x, y, width, height);
					}
				} else if (_scale9Grid.y == 0 && (_scale9Grid.height == height || _scale9Grid.height == 0)) {
					min = leftFix + rightFix;
					if (width > min) {
						mat = new Matrix();
						cols = [0, leftFix, ow - rightFix, ow];
						dCols = [0, leftFix, width - rightFix, width];
						
						cx = -1;
						while(++cx < 3) {
							origin = new Rectangle(cols[cx], 0, cols[cx + 1] - cols[cx], height);
							draw = new Rectangle(dCols[cx], 0, dCols[cx + 1] - dCols[cx], height);
							mat.identity();
							mat.a = draw.width / origin.width;
							mat.d = height / _bitmap.height;
							mat.tx = (draw.x - origin.x * mat.a) + x;
							mat.ty = (draw.y - origin.y * mat.d) + y;
							scaleDraw(graphics, x, y, draw, mat);
						}
					} else {
						defaultDraw(graphics, x, y, width, height);
					}
				} else {
					min = topFix + bottomFix;
					ow = bitmap.width;
					oh = bitmap.height;
					if (height > min) {
						mat = new Matrix();
						cols = [0, leftFix, ow - rightFix, ow];
						dCols = [0, leftFix, width - rightFix, width];
						rows = [0, topFix, oh - bottomFix, oh];
						dRows = [0, topFix, height - bottomFix, height];
						
						cx = -1;
						while(++cx < 3) {
							cy = -1;
							while(++cy < 3) {
								origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
								draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
								mat.identity();
								mat.a = draw.width / origin.width;
								mat.d = draw.height / origin.height;
								mat.tx = (draw.x - origin.x * mat.a) + x;
								mat.ty = (draw.y - origin.y * mat.d) + y;
								scaleDraw(graphics, x, y, draw, mat);
							}
						}
					} else {
						defaultDraw(graphics, x, y, width, height);
					}
				}
			}
		}

		private function scaleDraw(graphics : Graphics, x : Number, y : Number, draw : Rectangle, mat : Matrix) : void {
			//graphics.lineStyle(1, 0x000000);
			graphics.beginBitmapFill(_bitmap, mat, false, _smooth);
			graphics.drawRect(draw.x + x, draw.y + y, draw.width, draw.height);
			//trace(draw.x + x, draw.y + y, draw.width, draw.height);
			graphics.endFill();
		}

		private function defaultDraw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number) : void {
			var mat : Matrix = new Matrix();
			mat.a = width / _bitmap.width;
			mat.d = height / _bitmap.height;
			mat.tx = x;
			mat.ty = y;
				
			graphics.beginBitmapFill(_bitmap, mat, false, _smooth);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}

		public function get bitmap() : BitmapData {
			return _bitmap;
		}

		public function set bitmap(bitmap : BitmapData) : void {
			_bitmap = bitmap;
		}

		public function get smooth() : Boolean {
			return _smooth;
		}

		public function set smooth(smooth : Boolean) : void {
			_smooth = smooth;
		}

		public function get scale9Grid() : Rectangle {
			return _scale9Grid;
		}

		public function set scale9Grid(scale9Grid : Rectangle) : void {
			_scale9Grid = scale9Grid;
		}
	}
}
