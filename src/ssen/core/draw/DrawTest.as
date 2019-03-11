package ssen.core.draw {
	import ssen.core.MathX;
	import ssen.core.draw.material.BitmapMaterial;
	import ssen.core.draw.material.IDrawMaterial;
	import ssen.core.draw.material.RoundRectMaterial;
	import ssen.core.draw.material.SolidMaterial;

	import flash.display.BitmapData;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DrawTest extends Sprite {

		[Embed(source="/asset/profile.png")]
		public static var profileImage : Class;

		[Embed(source="/asset/chess.png")]
		public static var chessImage : Class;
		private var solid : SolidMaterial;
		private var scalev : BitmapMaterial;
		private var scaleh : BitmapMaterial;
		private var scale9 : BitmapMaterial;
		private var plain : BitmapMaterial;
		private var round : RoundRectMaterial;

		public function DrawTest() {
			var profile : BitmapData = new profileImage().bitmapData;
			var chess : BitmapData = new chessImage().bitmapData;
			plain = new BitmapMaterial(profile, true);
			scale9 = new BitmapMaterial(chess, false, new Rectangle(10, 10, 10, 10));
			scaleh = new BitmapMaterial(chess, false, new Rectangle(10, 0, 10, 0));
			scalev = new BitmapMaterial(chess, false, new Rectangle(0, 10, 0, 10));
			var stroke : GraphicsStroke = new GraphicsStroke(1, true);
			stroke.fill = new GraphicsSolidFill(MathX.rand(0x000000, 0x444444), 0.5);
			solid = new SolidMaterial(new GraphicsSolidFill(MathX.rand(0x999999, 0xffffff), 0.5), stroke);
			round = new RoundRectMaterial(10, 10, new GraphicsSolidFill(MathX.rand(0x999999, 0xffffff), 0.5), stroke);
			
			stage.addEventListener(MouseEvent.CLICK, click);
		}

		private function click(event : MouseEvent) : void {
			graphics.clear();
			
			//			var datas : Array = [randomRect(plain), randomRect(scale9), randomRect(scaleh), randomRect(scalev)];
			//			datas.push(randomRect(solid), randomRect(round), randomLine(solid), randomDonut(solid));
			var datas : Array = [randomRect(scaleh)];
			drawDatas(graphics, datas);
			trace(System.totalMemory / 1024);
		}

		private function randomRect(material : IDrawMaterial) : Rect {
			return new Rect(MathX.rand(10, 300), MathX.rand(10, 300), MathX.rand(10, 150), MathX.rand(10, 150), material);
		}

		private function randomLine(material : SolidMaterial) : Line {
			return new Line(MathX.rand(10, 300), MathX.rand(10, 300), MathX.rand(10, 300), MathX.rand(10, 300), material);
		}

		private function randomDonut(material : SolidMaterial) : Donut {
			return new Donut(MathX.rand(10, 300), MathX.rand(10, 300), MathX.rand(30, 70), MathX.rand(10, 50), MathX.rand(0, 360), MathX.rand(0, 360), material);
		}
	}
}
