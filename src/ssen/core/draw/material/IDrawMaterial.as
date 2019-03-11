package ssen.core.draw.material {
	import flash.display.GraphicsPath;
	import flash.display.Graphics;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public interface IDrawMaterial {
		function draw(graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void
	}
}
