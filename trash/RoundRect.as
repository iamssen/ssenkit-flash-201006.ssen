package test {
	import flash.display.GraphicsPath;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class RoundRect extends Rect {
		public var ellipseWidth : Number;
		public var ellipseHeight : Number;

		public function RoundRect(x : Number = 0, y : Number = 0, width : Number = 100, height : Number = 100, ellipseWidth : Number = 10, ellipseHeight : Number = 10, visible : Boolean = true) {
			x = x;
			y = y;
			width = width;
			height = height;
			ellipseWidth = ellipseWidth;
			ellipseHeight = ellipseHeight;
			super(x, y, width, height, visible);
		}

		override public function getPath() : GraphicsPath {
			if (!_path) {
				_path = new GraphicsPath;
				_path.commands = Vector.<int>([1,2,3,2,3,2,3,2,3]);
				_path.data = new Vector.<Number>(26, true);
			}
			var x0 : Number = x;
			var x1 : Number = x + ellipseWidth;
			var x2 : Number = x + width - ellipseWidth;
			var x3 : Number = x + width;
			var y0 : Number = y;
			var y1 : Number = y + ellipseHeight;
			var y2 : Number = y + height - ellipseHeight;
			var y3 : Number = y + height;
			_path.data[0] = x1;
			_path.data[1] = y0;
			_path.data[2] = x2;
			_path.data[3] = y0;
			_path.data[4] = x3;
			_path.data[5] = y0;
			_path.data[6] = x3;
			_path.data[7] = y1;
			_path.data[8] = x3;
			_path.data[9] = y2;
			_path.data[10] = x3;
			_path.data[11] = y3;
			_path.data[12] = x2;
			_path.data[13] = y3;
			_path.data[14] = x1;
			_path.data[15] = y3;
			_path.data[16] = x0;
			_path.data[17] = y3;
			_path.data[18] = x0;
			_path.data[19] = y2;
			_path.data[20] = x0;
			_path.data[21] = y1;
			_path.data[22] = x0;
			_path.data[23] = y0;
			_path.data[24] = x1;
			_path.data[25] = y0;
			return _path;
		}
	}
}
