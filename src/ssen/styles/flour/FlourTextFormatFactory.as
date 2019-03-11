package ssen.styles.flour {
	import flashx.textLayout.formats.TextLayoutFormat;

	import flash.system.Capabilities;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourTextFormatFactory {
		private static var _systemSansSerif : String;
		private static var _isWindows : Boolean;
		private static var _osFind : Boolean;

		public static function getSystemSansSerif(size : int, align : String = "left", valign : String = "top", color : uint = 0x6c6c6c, bold : Boolean = false) : TextLayoutFormat {
			var format : TextLayoutFormat = new TextLayoutFormat();
			format.color = color;
			format.fontSize = size;
			format.fontLookup = FontLookup.DEVICE;
			format.cffHinting = windows() ? CFFHinting.NONE : CFFHinting.HORIZONTAL_STEM;
			format.fontFamily = getSystemFont();
			if (!windows() && size < 12) bold = true;
			format.fontWeight = bold ? FontWeight.BOLD : FontWeight.NORMAL;
			format.textAlign = align;
			format.verticalAlign = valign;
			return format;
		}

		public static function getEmbedSansSerif(size : int, align : String = "left", valign : String = "top", color : uint = 0x6c6c6c, bold : Boolean = false) : TextLayoutFormat {
			var format : TextLayoutFormat = new TextLayoutFormat();
			format.color = color;
			format.fontSize = size;
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.cffHinting = CFFHinting.HORIZONTAL_STEM;
			format.fontFamily = "나눔고딕OTF";
			if (size < 11) bold = true;
			format.fontWeight = bold ? FontWeight.BOLD : FontWeight.NORMAL;
			format.textAlign = align;
			format.verticalAlign = valign;
			return format;
		}

		public static function getSystemFont() : String {
			if (_systemSansSerif) return _systemSansSerif;
			_systemSansSerif = windows() ? "돋움, Verdana, _sans" : "나눔고딕, AppleGothic, Verdana, _sans";
			return _systemSansSerif;
		}

		public static function windows() : Boolean {
			if (_osFind) return _isWindows;
			var reg : RegExp = /Windows/g;
			_isWindows = reg.test(Capabilities.os);
			_osFind = true;
			return _isWindows;
		}

		public static function fontCFFCheck(fontName : String) : String {
			if (windows()) {
				switch (fontName) {
					case "돋움" :
					case "굴림" :
					case "Arial" :
					case "Verdana" :
						return CFFHinting.NONE;
						break;
				}
			}
			return CFFHinting.HORIZONTAL_STEM;
		}
	}
}
