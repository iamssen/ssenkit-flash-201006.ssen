package ssen.styles.flour.boxes {
	import ssen.core.MathX;

	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourWindowTest extends Sprite {
		private var material : FlourWindowBoxMaterial;

		public function FlourWindowTest() {
			material = new FlourWindowBoxMaterial();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(event : Event) : void {
			stage.addEventListener(MouseEvent.CLICK, stageClick);
		}

		private function stageClick(event : MouseEvent) : void {
			graphics.clear();
			material.headerHeight = MathX.rand(15, 70);
			material.draw(graphics, MathX.rand(10, 100), MathX.rand(10, 100), MathX.rand(50, 200), MathX.rand(50, 200));
		}
	}
}
