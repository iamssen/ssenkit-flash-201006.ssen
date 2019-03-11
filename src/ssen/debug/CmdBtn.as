package ssen.debug {
	import flashx.textLayout.factory.StringTextLineFactory;

	import ssen.framework.widgets.core.SpriteWidget;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class CmdBtn extends SpriteWidget {
		private var _fac : StringTextLineFactory;

		public function CmdBtn() {
			construct();
			setting();
			
			_fac = new StringTextLineFactory();
		}

		override protected function wregister(initializeState : String = "run") : void {
			addToService();
		}
	}
}
