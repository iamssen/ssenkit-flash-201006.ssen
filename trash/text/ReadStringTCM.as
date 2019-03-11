package ssen.framework.widgets.text {
	import ssen.framework.widgets.core.ITextFormatSet;
	import flashx.textLayout.container.TextContainerManager;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ReadStringTCM extends TextContainerManager {
		private var _formats : ITextFormatSet;
		private var _base : TextBase;

		public function ReadStringTCM(base : TextBase, formats : ITextFormatSet = null) {
			_base = base;
			_formats = formats ? formats : getFormats();
			super(_base.container);
		}

		private function getFormats() : ITextFormatSet {
			return null;
		}
	}
}
