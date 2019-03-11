package ssen.framework.widgets.input {
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.formats.ITextLayoutFormat;

	import ssen.core.geom.Padding;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextWidgetConfig {
		public function TextWidgetConfig(width : int = 100, height : int = 100, text : String = "", initText : String = "", mouseWheelEnabled : Boolean = false) {
			initConfig(width, height, text, initText, mouseWheelEnabled);
		}

		public var mouseWheelEnabled : Boolean = false;
		public var text : String = "";
		public var initText : String = "";
		public var width : int = 100;
		public var height : int = 100;

		public function initConfig(width : int = 100, height : int = 100, text : String = "", initText : String = "", mouseWheelEnabled : Boolean = false) : void {
			this.width = width;
			this.height = height;
			this.text = text;
			this.initText = initText;
			this.mouseWheelEnabled = mouseWheelEnabled;
		}

		public var format : ITextLayoutFormat = null;
		public var blockProgression : String = "tb";
		public var textPadding : Padding = null;
		public var disableColor : uint = 0xcccccc;

		public function styleConfig(format : ITextLayoutFormat = null, disableColor : uint = 0xcccccc, textPadding : Padding = null, blockProgression : String = "tb") : void {
			this.format = format;
			this.disableColor = disableColor;
			this.textPadding = textPadding;
			this.blockProgression = blockProgression;
		}

		public var editingMode : String = "readWrite";
		public var restrict : String;
		public var displayAsPassword : Boolean = false;

		public function editingConfig(editingMode : String = "readWrite", type : String = "all") : void {
			this.editingMode = editingMode;
			if (editingMode == EditingMode.READ_WRITE) {
				switch (type) {
					case InputType.NUMBER :
						restrict = "0-9 - .";
						displayAsPassword = false;
						break;
					case InputType.PASSWORD : 
						restrict = " -~";
						displayAsPassword = true;
						break;
					case InputType.ALPHABET : 
						restrict = " -~";
						displayAsPassword = false;
						break;
					case InputType.EMAIL :
						restrict = "@-Z a-z 0-9 . _ -";
						displayAsPassword = false; 
						break;
					default : 
						restrict = null;
						displayAsPassword = false;
						break;
				}
			}
		}

		public var multiline : Boolean = false;
		public var wordWrap : Boolean = false;

		public function multilineConfig(multiline : Boolean = true, wordWrap : Boolean = true) : void {
			this.multiline = multiline;
			this.wordWrap = wordWrap;
		}
	}
}
