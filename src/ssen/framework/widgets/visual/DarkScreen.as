package ssen.framework.widgets.visual {
	import ssen.core.draw.material.SolidMaterial;
	import ssen.framework.service.SS;
	import ssen.framework.ss_internal;
	import ssen.framework.widgets.core.Widget;

	import flash.display.DisplayObject;
	import flash.display.GraphicsSolidFill;
	import flash.display.Shape;
	import flash.events.Event;
	
	use namespace ss_internal;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class DarkScreen extends Widget implements IValueVisual {
		private var _solid : SolidMaterial;
		private var _alpha : Number;
		private var _fill : GraphicsSolidFill;
		private var _display : Shape;

		public function get value() : Number {
			return _alpha;
		}

		public function set value(value : Number) : void {
			_alpha = value;
			draw();
		}

		override protected function wconstruct() : void {
			_fill = new GraphicsSolidFill(0x000000, 0);
			_solid = new SolidMaterial(_fill);
			_display = new Shape();
		}

		override protected function wregister(initializeState : String = "run") : void {
			SS.frame.addEventListener(Event.RESIZE, resize);
		}

		override protected function wderegister() : void {
			SS.frame.removeEventListener(Event.RESIZE, resize);
		}

		override protected function wdeconstruct() : void {
			_fill = null;
			_solid = null;
			_display = null;
		}

		private function resize(event : Event) : void {
			draw();
		}

		private function draw() : void {
			_fill.alpha = _alpha * 0.4;
			_display.graphics.clear();
			_solid.draw(_display.graphics, 0, 0, SS.frame.sw, SS.frame.sh);
		}

		override ss_internal function get display() : DisplayObject {
			return _display;
		}
	}
}
