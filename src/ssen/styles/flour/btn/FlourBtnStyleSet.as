package ssen.styles.flour.btn {
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.core.draw.material.ITextFormatSet;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourBtnStyleSet {
		private static var _material : IDrawMaterialSet;
		private static var _formats : TextFormatSet;

		public static function get material() : IDrawMaterialSet {
			if (_material) return _material;
			_material = new Material();
			return _material;
		}

		public static function get formats() : ITextFormatSet {
			if (_formats) return _formats;
			_formats = new TextFormatSet();
			return _formats;
		}
	}
}

import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.TextLayoutFormat;
import flashx.textLayout.formats.VerticalAlign;

import ssen.core.draw.material.BitmapMaterial;
import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.draw.material.ITextFormatSet;
import ssen.styles.flour.FlourTextFormatFactory;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.geom.Rectangle;

class Material implements IDrawMaterialSet {

	[Embed(source="run-default.png")]
	public static var runDefaultImage : Class;

	[Embed(source="run-over.png")]
	public static var runOverImage : Class;

	[Embed(source="run-down.png")]
	public static var runDownImage : Class;

	[Embed(source="selected-default.png")]
	public static var selectedDefaultImage : Class;

	[Embed(source="selected-over.png")]
	public static var selectedOverImage : Class;

	[Embed(source="selected-down.png")]
	public static var selectedDownImage : Class;

	[Embed(source="disable-default.png")]
	public static var disableDefaultImage : Class;
	private var _run_default : BitmapData;
	private var _run_over : BitmapData;
	private var _run_down : BitmapData;
	private var _selected_default : BitmapData;
	private var _selected_over : BitmapData;
	private var _selected_down : BitmapData;
	private var _disable_default : BitmapData;
	private var _material : BitmapMaterial;

	public function Material() {
		_run_default = new runDefaultImage().bitmapData;
		_run_over = new runOverImage().bitmapData;
		_run_down = new runDownImage().bitmapData;
		_selected_default = new selectedDefaultImage().bitmapData;
		_selected_over = new selectedOverImage().bitmapData;
		_selected_down = new selectedDownImage().bitmapData;
		_disable_default = new disableDefaultImage().bitmapData;
		
		_material = new BitmapMaterial(_run_default, false, new Rectangle(6, 6, 38, 37));
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "selected" :
				switch (action) {
					case "over" : 
						_material.bitmap = _selected_over;
						break;
					case "down" : 
						_material.bitmap = _selected_down;
						break;
					default : 
						_material.bitmap = _selected_default;
						break;
				}
				break;
			case "disable" :
				_material.bitmap = _disable_default;
				break;
			default :
				switch (action) {
					case "over" : 
						_material.bitmap = _run_over;
						break;
					case "down" : 
						_material.bitmap = _run_down;
						break;
					default : 
						_material.bitmap = _run_default;
						break;
				}
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}

class TextFormatSet implements ITextFormatSet {
	private var _default : TextLayoutFormat;
	private var _over : TextLayoutFormat;
	private var _down : TextLayoutFormat;
	private var _selected : TextLayoutFormat;
	private var _disable : TextLayoutFormat;

	public function TextFormatSet() {
		_default = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x3f3f3f);
		_over = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x372404);
		_down = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x372404);
		_selected = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x22222f);
		_disable = FlourTextFormatFactory.getEmbedSansSerif(10, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x9d9d9d);
	}

	public function getFormat(state : String, action : String) : ITextLayoutFormat {
		switch (state) {
			case "selected" : 
				return _selected; 
				break;
			case "disable" : 
				return _disable; 
				break;
			default :
				switch (action) {
					case "over" : 
						return _over; 
						break;
					case "down" : 
						return _down; 
						break;
					default : 
						return _default; 
						break; 
				}
				break;
		}
	}
}
