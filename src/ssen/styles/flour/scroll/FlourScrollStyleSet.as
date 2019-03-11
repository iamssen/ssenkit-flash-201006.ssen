package ssen.styles.flour.scroll {
	import ssen.core.draw.material.IDrawMaterialSet;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourScrollStyleSet {
		private static var _thumbH : IDrawMaterialSet;
		private static var _thumbV : IDrawMaterialSet;
		private static var _trackH : IDrawMaterialSet;
		private static var _trackV : IDrawMaterialSet;
		private static var _trackX : IDrawMaterialSet;

		public static function get thumbH() : IDrawMaterialSet {
			if (_thumbH) return _thumbH;
			_thumbH = new ThumbH();
			return _thumbH;
		}

		public static function get thumbV() : IDrawMaterialSet {
			if (_thumbV) return _thumbV;
			_thumbV = new ThumbV();
			return _thumbV;
		}

		public static function get trackH() : IDrawMaterialSet {
			if (_trackH) return _trackH;
			_trackH = new TrackH();
			return _trackH;
		}

		public static function get trackV() : IDrawMaterialSet {
			if (_trackV) return _trackV;
			_trackV = new TrackV();
			return _trackV;
		}

		public static function get trackX() : IDrawMaterialSet {
			if (_trackX) return _trackX;
			_trackX = new TrackX();
			return _trackX;
		}		
	}
}

import ssen.core.draw.material.BitmapMaterial;
import ssen.core.draw.material.IDrawMaterialSet;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.geom.Rectangle;

class ThumbH implements IDrawMaterialSet {

	[Embed(source="thumb-h-run-default.png")]
	public static var runDefaultImage : Class;

	[Embed(source="thumb-h-run-action.png")]
	public static var runActionImage : Class;

	[Embed(source="thumb-h-disable-default.png")]
	public static var disableDefaultImage : Class;
	private var _run_default : BitmapData;
	private var _run_action : BitmapData;
	private var _disable_default : BitmapData;
	private var _material : BitmapMaterial;

	public function ThumbH() {
		_run_default = new runDefaultImage().bitmapData;
		_run_action = new runActionImage().bitmapData;
		_disable_default = new disableDefaultImage().bitmapData;
		_material = new BitmapMaterial(_run_default, false, new Rectangle(11, 0, 8, 17));
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_material.bitmap = _disable_default;
				break;
			default :
				switch (action) {
					case "action" : 
						_material.bitmap = _run_action;
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

class ThumbV implements IDrawMaterialSet {

	[Embed(source="thumb-v-run-default.png")]
	public static var runDefaultImage : Class;

	[Embed(source="thumb-v-run-action.png")]
	public static var runActionImage : Class;

	[Embed(source="thumb-v-disable-default.png")]
	public static var disableDefaultImage : Class;
	private var _run_default : BitmapData;
	private var _run_action : BitmapData;
	private var _disable_default : BitmapData;
	private var _material : BitmapMaterial;

	public function ThumbV() {
		_run_default = new runDefaultImage().bitmapData;
		_run_action = new runActionImage().bitmapData;
		_disable_default = new disableDefaultImage().bitmapData;
		_material = new BitmapMaterial(_run_default, false, new Rectangle(0, 10, 17, 8));
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_material.bitmap = _disable_default;
				break;
			default :
				switch (action) {
					case "action" : 
						_material.bitmap = _run_action;
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

class TrackV implements IDrawMaterialSet {

	[Embed(source="track-v-run-default.png")]
	public static var runDefaultImage : Class;

	[Embed(source="track-v-disable-default.png")]
	public static var disableDefaultImage : Class;
	private var _run_default : BitmapData;
	private var _disable_default : BitmapData;
	private var _material : BitmapMaterial;

	public function TrackV() {
		_run_default = new runDefaultImage().bitmapData;
		_disable_default = new disableDefaultImage().bitmapData;
		_material = new BitmapMaterial(_run_default);
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_material.bitmap = _disable_default;
				break;
			default : 
				_material.bitmap = _run_default;
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}

class TrackH implements IDrawMaterialSet {

	[Embed(source="track-h-run-default.png")]
	public static var runDefaultImage : Class;

	[Embed(source="track-h-disable-default.png")]
	public static var disableDefaultImage : Class;
	private var _run_default : BitmapData;
	private var _disable_default : BitmapData;
	private var _material : BitmapMaterial;

	public function TrackH() {
		_run_default = new runDefaultImage().bitmapData;
		_disable_default = new disableDefaultImage().bitmapData;
		_material = new BitmapMaterial(_run_default);
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_material.bitmap = _disable_default;
				break;
			default : 
				_material.bitmap = _run_default;
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}

class TrackX implements IDrawMaterialSet {

	[Embed(source="track-x-run-default.png")]
	public static var runDefaultImage : Class;

	[Embed(source="track-x-disable-default.png")]
	public static var disableDefaultImage : Class;
	private var _run_default : BitmapData;
	private var _disable_default : BitmapData;
	private var _material : BitmapMaterial;

	public function TrackX() {
		_run_default = new runDefaultImage().bitmapData;
		_disable_default = new disableDefaultImage().bitmapData;
		_material = new BitmapMaterial(_run_default);
	}

	public function draw(state : String, action : String, graphics : Graphics, x : Number, y : Number, width : Number, height : Number, path : GraphicsPath = null) : void {
		switch (state) {
			case "disable" :
				_material.bitmap = _disable_default;
				break;
			default : 
				_material.bitmap = _run_default;
				break;
		}
		_material.draw(graphics, x, y, width, height, path);
	}
}