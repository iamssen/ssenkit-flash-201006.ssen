package test {
	import ssen.core.draw.materials.GraphicsMaterial;

	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class Donut extends DrawShape {
		private var _x : Number;
		private var _y : Number;
		private var _radius : Number;
		private var _innerRadius : Number;
		private var _startDeg : Number;
		private var _endDeg : Number;
		private var _path : GraphicsPath;

		public function Donut(x : Number = 50, y : Number = 50, radius : Number = 100, innerRadius : Number = 50, startDeg : Number = 0, endDeg : Number = 360, visible : Boolean = true) {
			_x = x;
			_y = y;
			_radius = radius;
			_innerRadius = innerRadius;
			_startDeg = startDeg;
			_endDeg = endDeg;
			_path = new GraphicsPath;
			createPath();
			super(visible);
		}

		/* *********************************************************************
		 * get
		 ********************************************************************* */
		override public function getPath() : GraphicsPath {
			return _path;
		}

		public function get material() : GraphicsMaterial {
			return GraphicsMaterial(_material);
		}

		public function set material(material : GraphicsMaterial) : void {
			_material = material;
		}

		public function draw(graphics : Graphics) : void {
			if (_material) _material.draw(graphics, this);
		}

		/* *********************************************************************
		 * util
		 ********************************************************************* */
		private function createPath() : void {
			// (degree) start 와 end 를 계산해서 그릴 각도를 구한다.
			var arc : Number = _endDeg > _startDeg ? _endDeg - _startDeg : 360 - _startDeg + _endDeg;
			// segs 각도를 45 로 나누어서 등분을 결정한다.
			var s : int = Math.ceil(arc / 45);
			// theta : radian 등분의 갯수 단위로 radian 이 얼마만큼 증가할지 구한다.
			var th : Number = ((arc / s) / 180) * Math.PI;			
			// angle : radian 시작 radian 을 계산한다.
			var a : Number = (_startDeg / 180) * Math.PI;
			// GraphicsPath 의 command, data
			var outCmd : Vector.<int> = new Vector.<int>();
			var outData : Vector.<Number> = new Vector.<Number>;
			var inCmd : Vector.<int> = new Vector.<int>;
			var inData : Vector.<Number> = new Vector.<Number>;
			// 외부 최초점을 moveTo 로 옮겨준다.
			outCmd.push(1);
			outData.push(_x + _radius * Math.cos(a), _y + _radius * Math.sin(a));
			inCmd.push(3);
			inData.push(_x + _innerRadius * Math.cos(a), _y + _innerRadius * Math.sin(a));
			// controlAngle : radian 컨트롤 점의 radian angle
			var ca : Number;
	
			// draw
			while (--s >= 0) {
				a += th;
				ca = a - (th / 2);
				outCmd.push(3);
				outData.push(_x + (_radius / Math.cos(th / 2)) * Math.cos(ca), _y + (_radius / Math.cos(th / 2)) * Math.sin(ca), _x + _radius * Math.cos(a), _y + _radius * Math.sin(a));
				inCmd.unshift(3);
				inData.unshift(_x + _innerRadius * Math.cos(a), _y + _innerRadius * Math.sin(a), _x + (_innerRadius / Math.cos(th / 2)) * Math.cos(ca), _y + (_innerRadius / Math.cos(th / 2)) * Math.sin(ca));
			}
			// 내부 최초점을 lineTo 로 바꿔준다.
			inCmd[0] = 2;
			// 내부 마지막점과 외부 최초점을 연결하는 lineTo 를 설정해준다.
			inCmd.push(2);
			inData.push(outData[0], outData[1]);
			// 외부 데이터 + 내부 데이터 
			outCmd = outCmd.concat(inCmd);
			outData = outData.concat(inData);
			
			_path.commands = outCmd;
			_path.data = outData;
		}

		/* *********************************************************************
		 * properties
		 ********************************************************************* */
		public function get x() : Number {
			return _x;
		}

		public function set x(x : Number) : void {
			_x = x;
			createPath();
		}

		public function get y() : Number {
			return _y;
		}

		public function set y(y : Number) : void {
			_y = y;
			createPath();
		}

		public function get radius() : Number {
			return _radius;
		}

		public function set radius(radius : Number) : void {
			_radius = radius;
			createPath();
		}

		public function get innerRadius() : Number {
			return _innerRadius;
		}

		public function set innerRadius(innerRadius : Number) : void {
			_innerRadius = innerRadius;
			createPath();
		}

		public function get startDeg() : Number {
			return _startDeg;
		}

		public function set startDeg(startDeg : Number) : void {
			_startDeg = startDeg;
			createPath();
		}

		public function get endDeg() : Number {
			return _endDeg;
		}

		public function set endDeg(endDeg : Number) : void {
			_endDeg = endDeg;
			createPath();
		}
	}
}
