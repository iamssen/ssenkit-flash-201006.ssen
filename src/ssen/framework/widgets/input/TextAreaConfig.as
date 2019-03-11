package ssen.framework.widgets.input {
	import flashx.textLayout.formats.ITextLayoutFormat;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextAreaConfig {
		public var width : int;
		public var height : int;

		public function TextAreaConfig(width : int = 100, height : int = 100) {
			initConfig(width, height);
		}

		public function initConfig(width : int, height : int) : void {
			this.width = width;
			this.height = height;
		}

		public var text : String = "";
		public var initText : String = "";
		public var mouseWheelEnabled : Boolean = true;
		public var wordWrap : Boolean = true;

		public function textConfig(text : String = "", initText : String = "", wordWrap : Boolean = true, mouseWheelEnabled : Boolean = true) : void {
			this.text = text;
			this.initText = initText;
			this.wordWrap = wordWrap;
			this.mouseWheelEnabled = mouseWheelEnabled;
		}

		public var editingMode : String = "readWrite";
		public var type : String = "all";

		public function editConfig(editingMode : String, type : String = "all") : void {
			this.editingMode = editingMode;
			this.type = type;
		}

		public var textFormat : ITextLayoutFormat;
		public var disableColor : uint;

		public function formatConfig(textFormat : ITextLayoutFormat, disableColor : uint) : void {
			this.textFormat = textFormat;
			this.disableColor = disableColor;
		}
	}
}
