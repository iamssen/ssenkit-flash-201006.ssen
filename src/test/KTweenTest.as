package test {
	import net.kawa.tween.KTJob;
	import net.kawa.tween.KTween;
	import net.kawa.tween.easing.Quad;

	import ssen.core.MathX;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class KTweenTest extends Sprite {
		private var sp : Sprite;
		private var job : KTJob;

		public function KTweenTest() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(event : Event) : void {
			sp = getSprite();
			sp.x = 10;
			sp.y = 10;
			addChild(sp);
			
			stage.addEventListener(MouseEvent.CLICK, stageClick);
		}

		private function stageClick(event : MouseEvent = null) : void {
			if (job && !job.finished) job.abort();
			job = KTween.to(sp, 1, {x:MathX.rand(10, 540), y:MathX.rand(10, 390)}, Quad.easeOut, complete);
		}

		private function complete() : void {
			trace("complete");
		}

		
		private function getSprite() : Sprite {
			var sp : Sprite = new Sprite();
			sp.graphics.beginFill(0x000000);
			sp.graphics.drawRect(-2, -2, 4, 4);
			sp.graphics.endFill();
			return sp;
		}
	}
}
