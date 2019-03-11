package ssen.framework.widgets.scroll {
	import ssen.core.draw.material.IDrawMaterialSet;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ScrollConfig {
		public var direction : Boolean;
		public var width : int;
		public var height : int;
		public var min : Number;
		public var max : Number;
		public var total : Number;
		public var pos : Number;
		public var trackMode : Boolean;
		public var trackHide : Boolean;
		public var thumbMaterial : IDrawMaterialSet;
		public var trackMaterial : IDrawMaterialSet;

		public function viewConfig(direction : Boolean, width : int, height : int) : void {
			this.direction = direction;
			this.width = width;
			this.height = height;
		}

		public function valueConfig(min : Number = 0, max : Number = 0, total : Number = 0, pos : Number = 0) : void {
			this.min = min;
			this.max = max;
			this.total = total;
			this.pos = pos;
		}

		public function trackConfig(mode : Boolean = false, hide : Boolean = false) : void {
			this.trackMode = mode;
			this.trackHide = hide;
		}

		public function materialConfig(thumb : IDrawMaterialSet, track : IDrawMaterialSet) : void {
			this.thumbMaterial = thumb;
			this.trackMaterial = track;
		}

		public function clear() : void {
			this.thumbMaterial = null;
			this.trackMaterial = null;
		}
	}
}
