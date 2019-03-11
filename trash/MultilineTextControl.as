package ssen.framework.widgets.input {
	import ssen.core.draw.material.ITextFormatSet;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class MultilineTextControl extends TextControl {
		private var _formats : ITextFormatSet;

		override protected function wsetting(config : Object) : void {
			_formats = config["formats"] ? config["formats"] : getFormats();
		}

		protected function getFormats() : ITextFormatSet {
			return DefaultTextFormat.formats;
		}

		override protected function wregister(initializeState : String = "run") : void {
			addToService();
		}

		override protected function wderegister() : void {
			removeFromService();
		}

		override protected function wunsetting() : void {
			_formats = null;
		}

		override protected function draw() : void {
			hostFormat = _formats.getFormat(drawState, drawAction);
			updateContainer();
		}

		override public function get text() : String {
			return getText();
		}

		override public function set text(text : String) : void {
			setText(text);
			updateContainer();
			composeToPosition();
		}

		override public function get horizontalScrollEnabled() : Boolean {
			return true;
		}

		override public function get verticalScrollEnabled() : Boolean {
			return true;
		}
	}
}

import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.LineBreak;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

import ssen.core.draw.material.ITextFormatSet;
import ssen.framework.text.FlourTextFormats;

internal class DefaultTextFormat implements ITextFormatSet {
	private static var _formats : DefaultTextFormat;
	private var _default : TextLayoutFormat;
	private var _edit : TextLayoutFormat;
	private var _disable : TextLayoutFormat;

	public static function get formats() : DefaultTextFormat {
		if (_formats) return _formats;
		_formats = new DefaultTextFormat();
		return _formats;
	}

	public function DefaultTextFormat() {
		_default = FlourTextFormats.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0x3f3f3f, false, LineBreak.EXPLICIT);
		_edit = FlourTextFormats.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0x22222f, false, LineBreak.EXPLICIT);
		_disable = FlourTextFormats.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0x9d9d9d, false, LineBreak.EXPLICIT);
	}

	public function getFormat(state : String, action : String) : ITextLayoutFormat {
		switch (state) {
			case "disable" : 
				return _disable; 
				break;
			default :
				switch (action) {
					case "edit" : 
						return _edit; 
						break;
					default : 
						return _default; 
						break; 
				}
				break;
		}
	}
}