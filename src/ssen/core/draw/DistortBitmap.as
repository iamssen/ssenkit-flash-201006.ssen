package ssen.core.draw {
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsTrianglePath;
	import flash.display.IGraphicsData;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class DistortBitmap implements IDrawData {
		private var _tlX : Number;
		private var _tlY : Number;
		private var _trX : Number;
		private var _trY : Number;
		private var _dlX : Number;
		private var _dlY : Number;
		private var _drX : Number;
		private var _drY : Number;
		private var _fill : GraphicsBitmapFill;
		private var _path : GraphicsTrianglePath;
		private var _changed : Boolean;
		private var _bitmap : BitmapData;
		private var _smooth : Boolean;
		private var _stroke : GraphicsStroke;

		public function DistortBitmap(tlX : Number = 0, tlY : Number = 0, trX : Number = 100, trY : Number = 0, dlX : Number = 0, dlY : Number = 100, drX : Number = 100, drY : Number = 100, bitmap : BitmapData = null, smooth : Boolean = false) {
			_fill = new GraphicsBitmapFill();
			_path = new GraphicsTrianglePath();
			_stroke = new GraphicsStroke(0);
			
			_tlX = tlX;
			_tlY = tlY;
			_trX = trX;
			_trY = trY;
			_dlX = dlX;
			_dlY = dlY;
			_drX = drX;
			_drY = drY;
			_bitmap = bitmap;
			_smooth = smooth;
			
			_changed = true;
		}

		/** 좌상단 위치점을 바꾼다 */
		public function tl(x : Number, y : Number) : void {
			_tlX = x;
			_tlY = y;
			_changed = true;
		}

		/** 우상단 위치점을 바꾼다 */
		public function tr(x : Number, y : Number) : void {
			_trX = x;
			_trY = y;
			_changed = true;
		}

		/** 좌하단 위치점을 바꾼다 */
		public function dl(x : Number, y : Number) : void {
			_dlX = x;
			_dlY = y;
			_changed = true;
		}

		/** 우하단 위치점을 바꾼다 */
		public function dr(x : Number, y : Number) : void {
			_drX = x;
			_drY = y;
			_changed = true;
		}

		public function draw(graphics : Graphics) : void {
			if (_changed) {
				_fill.bitmapData = _bitmap;
				_fill.smooth = _smooth;
				_fill.repeat = false;
				
				PathMaker.distort(_path, _tlX, _tlY, _trX, _trY, _dlX, _dlY, _drX, _drY);
				
				_changed = false;
			}
			
			graphics.drawGraphicsData(Vector.<IGraphicsData>([_fill, _stroke, _path, new GraphicsEndFill()]));
		}

		public function deconstruct() : void {
			_fill = null;
			_path = null;
			_stroke = null;
			_bitmap = null;
		}
	}
}
