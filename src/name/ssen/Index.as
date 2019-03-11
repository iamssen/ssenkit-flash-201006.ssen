package name.ssen {
	import flash.display.Sprite;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class Index extends Sprite {
		private var _init : SiteInitializer;

		public function Index() {
			_init = new SiteInitializer(this);
		}
	}
}
