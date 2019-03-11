package ssen.framework.widgets.input {
	import ssen.core.draw.PathMaker;
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.core.geom.Padding;
	import ssen.framework.widgets.core.InvalidSpriteWidget;
	import ssen.framework.widgets.core.WidgetState;
	import ssen.framework.widgets.scroll.Scroll;
	import ssen.framework.widgets.scroll.ScrollConfig;
	import ssen.framework.widgets.scroll.ScrollDirection;
	import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

	import flash.display.GraphicsPath;
	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextArea extends InvalidSpriteWidget {
		private var _horizontalEnabled : Boolean;
		private var _width : Number;
		private var _height : Number;
		private var _evt : Boolean;
		private var _text : TextWidget;
		private var _material : IDrawMaterialSet;
		private var _scrollV : Scroll;
		private var _scrollH : Scroll;
		private var _padding : Padding;
		private var _xMaterial : IDrawMaterialSet;

		override protected function wconstruct() : void {
			super.wconstruct();
			_text = new TextWidget();
			_text.construct();
			_scrollV = new Scroll();
			_scrollV.construct();
			_scrollH = new Scroll();
			_scrollH.construct();
		}

		override protected function wsetting(config : Object) : void {
			_padding = getPadding();
			_material = getMaterial();
			_xMaterial = getScrollX();
			var cfg : TextAreaConfig = TextAreaConfig(config);
			var svcfg : ScrollConfig = getScrollVConfig();
			var shcfg : ScrollConfig = getScrollHConfig();
			var tcfg : TextWidgetConfig = getTextWidgetConfig();
			
			tcfg.width = cfg.width - _padding.leftAndRight - svcfg.width;
			tcfg.height = cfg.height - _padding.topAndBottom - (cfg.wordWrap ? shcfg.height : 0);
			tcfg.text = cfg.text;
			tcfg.initText = cfg.initText;
			tcfg.mouseWheelEnabled = cfg.mouseWheelEnabled;
			tcfg.wordWrap = cfg.wordWrap;
			tcfg.editingConfig(cfg.editingMode, cfg.type);
			if (cfg.textFormat) {
				tcfg.format = cfg.textFormat;
				tcfg.disableColor = cfg.disableColor;
			}
			
			_width = cfg.width;
			_height = cfg.height;
			
			_horizontalEnabled = !cfg.wordWrap;
			
			svcfg.height = tcfg.height;
			shcfg.width = tcfg.width;
			
			_text.setting(tcfg);
			_scrollV.setting(svcfg);
			_scrollH.setting(shcfg);
		}

		override protected function wregister(initializeState : String = "run") : void {
			_text.register(sprite, -1, initializeState);
			_scrollV.register(sprite, -1, initializeState);
			if (_horizontalEnabled) _scrollH.register(sprite, -1, initializeState);
			
			state = initializeState;
			
			setInvalid("size", true);
			setInvalid("draw", true);
			
			textChange();
			textScroll();
			
			_text.addEventListener(Event.SCROLL, textScroll);
			_text.addEventListener(Event.CHANGE, textChange);
			eventOn();
			
			addToService();
		}

		override protected function wderegister() : void {
			_text.removeEventListener(Event.SCROLL, textScroll);
			_text.removeEventListener(Event.CHANGE, textChange);
			eventOff();
			
			_text.deregister();
			_scrollV.deregister();
			if (_horizontalEnabled) _scrollH.deregister();
			
			graphics.clear();
			
			removeFromService();
		}

		override protected function wunsetting() : void {
			_padding = null;
			_material = null;
			_xMaterial = null;
			
			_text.unsetting();
			_scrollV.unsetting();
			_scrollH.unsetting();
		}

		override protected function wdeconstruct() : void {
			super.wdeconstruct();
			_text.deconstruct();
			_text = null;
			_scrollH.deconstruct();
			_scrollH = null;
			_scrollV.deconstruct();
			_scrollV = null;
		}

		override public function set state(state : String) : void {
			if (state == WidgetState.PREVIEW) state = WidgetState.DISABLE;
			if (super.state == state) return;
			super.state = state;
			
			switch (state) {
				case WidgetState.RUN : 
					break;
				case WidgetState.DISABLE : 
					break;
			}
		}

		/* *********************************************************************
		 * event 
		 ********************************************************************* */
		private function textChange(event : Event = null) : void {
			_scrollV.resetScrollInfo(_text.verticalScrollMinValue, _text.verticalScrollMaxValue, _text.verticalScrollTotalValue);
			_scrollV.scrollPosition = _text.verticalScrollValue;
			if (_horizontalEnabled) {
				_scrollH.resetScrollInfo(_text.horizontalScrollMinValue, _text.horizontalScrollMaxValue, _text.horizontalScrollTotalValue);
				_scrollH.scrollPosition = _text.horizontalScrollValue;
			}
		}

		private function eventOn() : void {
			if (_evt) return;
			_evt = true;
			_scrollV.addEventListener(Event.SCROLL, scrollV);
			if (_horizontalEnabled) _scrollH.addEventListener(Event.SCROLL, scrollH);
		}

		private function eventOff() : void {
			if (!_evt) return;
			_evt = false;
			_scrollV.removeEventListener(Event.SCROLL, scrollV);
			if (_horizontalEnabled) _scrollH.removeEventListener(Event.SCROLL, scrollH);
		}

		private function scrollH(event : Event) : void {
			_text.horizontalScrollValue = _scrollH.scrollPosition;
		}

		private function scrollV(event : Event) : void {
			_text.verticalScrollValue = Math.ceil(_scrollV.scrollPosition);
		}

		private function textScroll(event : Event = null) : void {
			_scrollV.scrollPosition = _text.verticalScrollValue;
			if (_horizontalEnabled) _scrollH.scrollPosition = _text.horizontalScrollValue;
		}

		/* *********************************************************************
		 * rendering 
		 ********************************************************************* */
		override protected function rendering() : void {
			if (getInvalid("size")) {
				_text.x = _padding.left;
				_text.y = _padding.top;
				_text.width = _width - _padding.leftAndRight - _scrollV.width;
				_text.height = _height - _padding.topAndBottom - (_horizontalEnabled ? _scrollH.height : 0);
				_scrollV.x = _width - _padding.right - _scrollV.width;
				_scrollV.y = _padding.top;
				_scrollV.height = _text.height;
				if (_horizontalEnabled) {
					_scrollH.x = _padding.left;
					_scrollH.y = _height - _padding.bottom - _scrollH.height;
					_scrollH.width = _text.width;
				}
			}
			
			if (getInvalid("size") || getInvalid("draw")) {
				graphics.clear();
				var path : GraphicsPath = new GraphicsPath();
				PathMaker.rect(path, 0, 0, width, height);
				_material.draw(state, "default", graphics, 0, 0, width, height);
				if (_horizontalEnabled) {
					PathMaker.rect(path, _scrollV.x, _scrollH.y, _scrollV.width, _scrollH.height);
					_xMaterial.draw(state, "default", graphics, _scrollV.x, _scrollH.y, _scrollV.width, _scrollH.height, path);
					//_xMaterial.draw(state, "default", graphics, 50, 50, _scrollV.width, _scrollH.height, path);
				}
			}
			
			super.rendering();
		}

		/* *********************************************************************
		 * runtime 
		 ********************************************************************* */
		override public function get width() : Number {
			return _width;
		}

		public function set width(width : Number) : void {
			_width = width;
			setInvalid("size", true);
		}

		override public function get height() : Number {
			return _height;
		}

		public function set height(height : Number) : void {
			_height = height;
			setInvalid("size", true);
		}

		/* *********************************************************************
		 * abstract 
		 ********************************************************************* */
		protected function getPadding() : Padding {
			return new Padding(1, 1, 1, 1);
		}

		protected function getScrollHConfig() : ScrollConfig {
			var config : ScrollConfig = new ScrollConfig();
			config.materialConfig(FlourScrollBoxStyleSet.thumb, FlourScrollBoxStyleSet.track);
			config.viewConfig(ScrollDirection.HORIZONTAL, 100, 5);
			return config;
		}

		protected function getScrollVConfig() : ScrollConfig {
			var config : ScrollConfig = new ScrollConfig();
			config.materialConfig(FlourScrollBoxStyleSet.thumb, FlourScrollBoxStyleSet.track);
			config.viewConfig(ScrollDirection.VERTICAL, 5, 100);
			return config;
		}

		protected function getScrollX() : IDrawMaterialSet {
			return FlourScrollBoxStyleSet.track;
		}

		protected function getMaterial() : IDrawMaterialSet {
			return FlourScrollBoxStyleSet.box;
		}

		protected function getTextWidgetConfig() : TextWidgetConfig {
			var config : TextWidgetConfig = new TextWidgetConfig();
			config.styleConfig(FlourScrollBoxStyleSet.textFormat, FlourScrollBoxStyleSet.textDisableColor, FlourScrollBoxStyleSet.textPadding);
			config.multiline = true;
			return config;
		}
	}
}
