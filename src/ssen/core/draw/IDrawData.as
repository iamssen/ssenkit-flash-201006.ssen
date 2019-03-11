package ssen.core.draw {
	import flash.display.Graphics;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public interface IDrawData {
		function draw(graphics : Graphics) : void

		function deconstruct() : void
	}
}
