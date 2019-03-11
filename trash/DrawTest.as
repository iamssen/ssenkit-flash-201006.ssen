package test {
	

	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DrawTest extends Sprite {
		public function DrawTest() {
			trace(getQualifiedClassName(new Donut));
		}
	}
}
