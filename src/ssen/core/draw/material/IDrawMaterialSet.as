package ssen.core.draw.material {
	import flash.display.Graphics;
	import flash.display.GraphicsPath;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IDrawMaterialSet {
		function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void
	}
}
