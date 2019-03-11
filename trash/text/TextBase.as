package ssen.framework.widgets.text {
	import ssen.framework.widgets.core.ITextFormatSet;
	import flashx.textLayout.container.TextContainerManager;
	import flashx.textLayout.events.TextLayoutEvent;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.draw.PathMaker;
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.core.geom.Padding;
	import ssen.framework.text.FlourTextFormats;
	import ssen.framework.text.TextFormatSet;
	import ssen.framework.widgets.core.SpriteWidget;

	import flash.display.GraphicsPath;
	import flash.display.Sprite;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextBase extends SpriteWidget {
		private var _container : Sprite;
		private var _manager : TextContainerManager;
		private var _material : IDrawMaterialSet;
		private var _width : Number;
		private var _height : Number;
		private var _padding : Padding;
		private var _formats : ITextFormatSet;
		private static var _defaultTextFormats : TextFormatSet;
		private var _tlf : Boolean;

		override protected function wsetting(config : Object) : void {
			if (!config) throw new Error("text config is null");
			_container = new Sprite();
			sprite.addChild(_container);
			
			_tlf = config["tlf"];
			_material = config["material"] ? config["material"] : getMaterial();
			_formats = config["textFormats"] ? config["textFormats"] : getFormats();
			_manager = config["manager"] ? config["manager"] : getManager();
			_width = config["width"];
			_height = config["height"];
			_padding = config["padding"];
		}

		private function getManager() : TextContainerManager {
			return null;
		}

		private function getFormats() : ITextFormatSet {
			if (_defaultTextFormats) return _defaultTextFormats;
			var size : int = 10;
			var formats : TextFormatSet = new TextFormatSet();
			formats.set("default", FlourTextFormats.getEmbedSansSerif(size, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x3f3f3f));
			formats.set("edit", FlourTextFormats.getEmbedSansSerif(size, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x22222f));
			formats.set("disable", FlourTextFormats.getEmbedSansSerif(size, TextAlign.CENTER, VerticalAlign.MIDDLE, 0x9d9d9d));
			_defaultTextFormats = formats;
			return _defaultTextFormats;
		}

		private function getMaterial() : IDrawMaterialSet {
			return null;
		}

		override protected function wregister(initializeState : String) : void {
			_manager.addEventListener(TextLayoutEvent.SCROLL, scroll);
		}

		private function scroll(event : TextLayoutEvent) : void {
		}

		public function get horizontalScrollPosition() : Number {
			return _manager.horizontalScrollPosition;
		}

		public function get verticalScrollPosition() : Number {
			return _manager.verticalScrollPosition;
		}

		override protected function wderegister() : void {
		}

		override protected function wunsetting() : void {
			sprite.removeChild(_container);
			_container = null;
			_material = null;
			_manager = null;
		}

		override public function set state(state : String) : void {
			super.state = state;
			// TODO
		}

		public function update() : void {
			var x : Number;
			var y : Number;
			var w : Number;
			var h : Number;
			
			if (_padding) {
				x = _padding.left;
				y = _padding.top;
				w = _width - _padding.leftAndRight;
				h = _height - _padding.topAndBottom;
			} else {
				x = 0;
				y = 0;
				w = _width;
				h = _height;
			}
			
			_container.x = x;
			_container.y = y;
			_manager.compositionWidth = w;
			_manager.compositionHeight = h;
			
			if (_material) {
				graphics.clear();
				var path : GraphicsPath = new GraphicsPath();
				PathMaker.rect(path, 0, 0, width, height);
				_material.draw(state, graphics, 0, 0, width, height, path);
			}
			
			_manager.updateContainer();
		}

		public function get width() : Number {
			return _width;
		}

		public function get height() : Number {
			return _height;
		}

		public function set width(width : Number) : void {
			_width = width;
		}

		public function set height(height : Number) : void {
			_height = height;
		}

		public function get container() : Sprite {
			return _container;
		}
	}
}
