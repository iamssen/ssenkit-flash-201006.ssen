package test {
	import de.polygonal.gl.VectorRenderer;

	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.MovieClip;

	/**
	 * @author seoyeonlee
	 */
	public class PolygonalGLTest extends MovieClip {
		public function PolygonalGLTest() {
			var ren : VectorRenderer = new VectorRenderer();
			ren.style.fillColor = 0xaaaaaa;
			ren.style.fillAlpha = 0.5;
			trace(GraphicsSolidFill(ren.style.getFill()).color = 0xeeeeee);
			ren.fillStart();
			ren.rect4(110, 110, 50, 50);
			ren.rect4(110, 110, 50, 50);
			ren.fillEnd();
			
			trace(GraphicsSolidFill(ren._buffer[0]).color, GraphicsSolidFill(ren._buffer[0]).alpha, GraphicsPath(ren._buffer[1]).commands, GraphicsPath(ren._buffer[1]).data, ren._buffer[2]);
			//graphics.drawGraphicsData(ren._buffer);
			//ren.tri6(10, 10, 110, 10, 10, 110);
			ren.flush(graphics);
			
			graphics.beginFill(0x000000, 0.3);
			graphics.drawRect(300, 300, 10, 10);
			graphics.endFill();
		}
	}
}
