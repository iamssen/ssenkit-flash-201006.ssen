package ssen.core {
	import ssen.core.geom.GeomX;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DisplayX {
		private static var _p : Point = new Point;

		public static function nextPos(prev : DisplayObject, object : DisplayObject, br : Boolean = false, spaceX : int = 5, spaceY : int = 5) : void {
			if (br) {
				object.x = prev.x;
				object.y = prev.y + prev.height + spaceY;
			} else {
				object.x = prev.x + prev.width + spaceX;
				object.y = prev.y;
			}
		}

		public static function getStagePos(object : DisplayObject) : Point {
			if (!object.parent) return new Point(0, 0);
			_p.x = object.x;
			_p.y = object.y;
			return object.parent.localToGlobal(_p);
		}

		public static function setStagePos(object : DisplayObject, x : Number, y : Number) : void {
			_p.x = x;
			_p.y = y;
			var p : Point = object.parent.globalToLocal(_p);
			object.x = p.x;
			object.y = p.y;
		}

		public static function capture(object : DisplayObject) : BitmapData {
			var bitmapData : BitmapData = new BitmapData(object.width, object.height, true, 0x00ffffff);
			bitmapData.draw(object);
			return bitmapData;
		}

		public static function align(objecties : Array, startX : int = 0, startY : int = 0, maxX : int = 400, spaceX : int = 5, spaceY : int = 10, valign : String = "middle") : void {
			var d : Object;
			var f : int = -1;
			var nx : Number = startX;
			var ny : Number = startY;
			var nh : Number = 0;
			var va : Boolean = valign != "top";
			if (va) {
				var line : Array = new Array;
				var s : int;
			}
			while(++f < objecties.length) {
				d = objecties[f];
				d.x = nx;
				d.y = ny;
				
				if (va) line.push(d);
				if (d.height > nh) nh = d.height;
				nx += d.width + spaceX;
				if (nx > maxX) {
					if (va) {
						if (valign == GeomX.MIDDLE) {
							s = line.length;
							while (--s >= 0) {
								d = line[s];
								d.y += (nh >> 1) - (d.height >> 1);
							}
						} else if (valign == GeomX.BOTTOM) {
							s = line.length;
							while (--s >= 0) {
								d = line[s];
								d.y += nh - d.height;
							}
						}
						line.length = 0;
					}
					
					nx = startX;
					ny += nh + spaceY;
					nh = 0;
				}
			}
		}

		public static function translate(objecties : Array, x : Number, y : Number) : void {
			var d : DisplayObject;
			var f : int = objecties.length;
			while (--f >= 0) {
				d = objecties[f];
				d.x += x;
				d.y += y;
			}
		}

		public static function addChildren(container : DisplayObjectContainer, children : Array) : void {
			var d : DisplayObject;
			var f : int = -1;
			while(++f < children.length) {
				d = children[f];
				container.addChild(d);
			}
		}

		public static function removeChildren(container : DisplayObjectContainer, children : Array) : void {
			var d : DisplayObject;
			var f : int = -1;
			while(++f < children.length) {
				d = children[f];
				container.removeChild(d);
			}
		}
	}
}
