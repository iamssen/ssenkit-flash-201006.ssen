package ssen.core.draw {
	import ssen.core.draw.material.SolidMaterial;

	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Donut implements IDrawData {
		private var _x : Number;
		private var _y : Number;
		private var _radius : Number;
		private var _innerRadius : Number;
		private var _startDeg : Number;
		private var _endDeg : Number;
		private var _path : GraphicsPath;
		private var _changed : Boolean;
		private var _material : SolidMaterial;

		/* *********************************************************************
		 * polygonal ds 의 graph data 와 합치는 방법을 생각해보자
		 ********************************************************************* */
		public function Donut(x : Number = 50, y : Number = 50, radius : Number = 100, innerRadius : Number = 50, startDeg : Number = 0, endDeg : Number = 360, material : SolidMaterial = null) {
			_path = new GraphicsPath();
			
			_x = x;
			_y = y;
			_radius = radius;
			_innerRadius = innerRadius;
			_startDeg = startDeg;
			_endDeg = endDeg;
			
			_material = material;
			
			_changed = true;
		}

		public function get x() : Number {
			return _x;
		}

		public function set x(x : Number) : void {
			_x = x;
			_changed = true;
		}

		public function get y() : Number {
			return _y;
		}

		public function set y(y : Number) : void {
			_y = y;
			_changed = true;
		}

		public function get radius() : Number {
			return _radius;
		}

		public function set radius(radius : Number) : void {
			_radius = radius;
			_changed = true;
		}

		public function get innerRadius() : Number {
			return _innerRadius;
		}

		public function set innerRadius(innerRadius : Number) : void {
			_innerRadius = innerRadius;
			_changed = true;
		}

		public function get startDeg() : Number {
			return _startDeg;
		}

		public function set startDeg(startDeg : Number) : void {
			_startDeg = startDeg;
			_changed = true;
		}

		public function get endDeg() : Number {
			return _endDeg;
		}

		public function set endDeg(endDeg : Number) : void {
			_endDeg = endDeg;
			_changed = true;
		}

		public function draw(graphics : Graphics) : void {
			if (_changed) {
				PathMaker.donut(_path, _x, _y, _radius, _innerRadius, _startDeg, _endDeg);
				_changed = false;
			}
			_material.draw(graphics, 0, 0, 0, 0, _path);
		}

		public function get material() : SolidMaterial {
			return _material;
		}

		public function set material(material : SolidMaterial) : void {
			_material = material;
		}

		public function deconstruct() : void {
			_path = null;
			_material = null;
		}
	}
}
