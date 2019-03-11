package ssen.styles.flour.scroll {
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.core.geom.Padding;
	import ssen.styles.flour.FlourTextFormatFactory;
	import ssen.styles.flour.boxes.FlourWhiteBoxMaterial;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourScrollBoxStyleSet {
		private static var _thumbH : IDrawMaterialSet;
		private static var _trackH : IDrawMaterialSet;
		private static var _textFormat : ITextLayoutFormat;
		private static var _textPadding : Padding;
		private static var _textScroll : IDrawMaterialSet;

		public static function get thumb() : IDrawMaterialSet {
			if (_thumbH) return _thumbH;
			_thumbH = new Thumb();
			return _thumbH;
		}

		public static function get track() : IDrawMaterialSet {
			if (_trackH) return _trackH;
			_trackH = new Track();
			return _trackH;
		}

		public static function get box() : IDrawMaterialSet {
			return FlourWhiteBoxMaterial.box;
		}

		public static function get textFormat() : ITextLayoutFormat {
			if (_textFormat) return _textFormat;
			_textFormat = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0x868686);
			return _textFormat;
		}

		public static function get textDisableColor() : uint {
			return 0xadadad;
		}

		public static function get textPadding() : Padding {
			if (_textPadding) return _textPadding;
			_textPadding = new Padding(10, 5, 10, 5);
			return _textPadding;
		}

		public static function get textScroll() : IDrawMaterialSet {
			if (_textScroll) return _textScroll;
			_textScroll = new TextScroll();
			return _textScroll;
		}
	}
}

import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.draw.material.SolidMaterial;

import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;

class TextScroll implements IDrawMaterialSet {
	private var _run_default : GraphicsSolidFill;
	private var _disable_default : GraphicsSolidFill;
	private var _material : SolidMaterial;

	public function TextScroll() {
		_run_default = new GraphicsSolidFill(0xb5b5b5, 0.17);
		_disable_default = new GraphicsSolidFill(0xb5b5b5, 0.09);
		_material = new SolidMaterial(_run_default);
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_material.fill = _disable_default;
				break;
			default : 
				_material.fill = _run_default;
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}

class Thumb implements IDrawMaterialSet {
	private var _run_default : uint;
	private var _run_action : uint;
	private var _disable_default : uint;
	private var _material : SolidMaterial;
	private var _fill : GraphicsSolidFill;

	public function Thumb() {
		_run_default = 0xb3b3b3;
		_run_action = 0x969696;
		_disable_default = 0xcecece;
		_fill = new GraphicsSolidFill(_run_default);
		_material = new SolidMaterial(_fill);
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_fill.color = _disable_default;
				break;
			default :
				switch (action) {
					case "action" : 
						_fill.color = _run_action;
						break;
					default : 
						_fill.color = _run_default;
						break;
				}
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}

class Track implements IDrawMaterialSet {
	private var _run_default : uint;
	private var _disable_default : uint;
	private var _material : SolidMaterial;
	private var _fill : GraphicsSolidFill;

	public function Track() {
		_run_default = 0xd8d8d8;
		_disable_default = 0xe0e0e0;
		_fill = new GraphicsSolidFill(_run_default);
		_material = new SolidMaterial(_fill);
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_fill.color = _disable_default;
				break;
			default : 
				_fill.color = _run_default;
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}
