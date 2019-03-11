package ssen.framework.widgets.input {
	import fl.text.TLFTextField;

	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.geom.Padding;
	import ssen.debug.ErrMsg;
	import ssen.framework.ss_internal;
	import ssen.framework.widgets.core.Widget;
	import ssen.framework.widgets.core.WidgetState;
	import ssen.styles.flour.FlourTextFormatFactory;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextFieldType;
	
	use namespace ss_internal;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextWidget extends Widget {
		private var _text : TLFTextField;
		private var _initText : Boolean;
		private var _editingMode : String;
		private var _disableTransform : ColorTransform;
		private var _runTransform : ColorTransform;
		private var _padding : Padding;
		private var _x : Number;
		private var _y : Number;
		private var _width : Number;
		private var _height : Number;

		override protected function wconstruct() : void {
			_text = new TLFTextField();
			_disableTransform = new ColorTransform();
			_runTransform = new ColorTransform();
		}

		protected function getFormat() : TextLayoutFormat {
			return FlourTextFormatFactory.getEmbedSansSerif(11, TextAlign.LEFT, VerticalAlign.TOP);
		}

		override protected function wsetting(config : Object) : void {
			if (!config is TextWidgetConfig) throw new Error(ErrMsg.typeUnMatch("TextWidgetConfig 가 필요"));
			// formats [run, disable]
			// text align, vertical align
			// size, color, bold
			// lookup, fontFamily, cff hinting
			// block progression
			// editing mode
			// input type - (all, number, password, alphabet, email) >> restrict, displayAsPassword
			// text padding
			// mouseWheelEnabled
			// multiline
			// wordWrap
			// init text
			// size
			var cfg : TextWidgetConfig = TextWidgetConfig(config);
			
			_x = 0;
			_y = 0;
			_width = cfg.width;
			_height = cfg.height;
			_padding = cfg.textPadding;
			align();
			
			
			if (cfg.text != "") {
				text = cfg.text;
				_initText = false;
			} else if (cfg.initText != "") {
				text = cfg.initText;
				_initText = true;
			} else {
				_initText = false;
			}
			_text.mouseWheelEnabled = cfg.mouseWheelEnabled;
			
			textFlow.hostFormat = cfg.format ? cfg.format : getFormat();
			_disableTransform.color = cfg.disableColor;
			_text.blockProgression = cfg.blockProgression;
			_editingMode = cfg.editingMode;
			_text.restrict = cfg.restrict;
			_text.displayAsPassword = cfg.displayAsPassword;
			_text.multiline = cfg.multiline;
			_text.wordWrap = cfg.wordWrap;
			
			// debug
			// _text.border = true;
		}

		private function align() : void {
			if (!_text || !_padding) return;
			_text.x = _x + _padding.left;
			_text.y = _y + _padding.top;
			_text.width = _width - _padding.leftAndRight;
			_text.height = _height - _padding.topAndBottom;
		}

		override protected function wregister(initializeState : String = "run") : void {
			textFlow.flowComposer.updateAllControllers();
			addToService();
			state = initializeState;
			
			_text.addEventListener(Event.SCROLL, scroll);
			_text.addEventListener(Event.CHANGE, change);
			_text.addEventListener(TextEvent.TEXT_INPUT, textInput);
			_text.addEventListener(TextEvent.LINK, link);
			_text.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			_text.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
		}

		override protected function wunsetting() : void {
			_text.restrict = null;
			_text.displayAsPassword = false;
			_initText = false;
			horizontalScrollValue = 0;
			verticalScrollValue = 0;
			text = "";
		}

		override protected function wdeconstruct() : void {
			_disableTransform = null;
			_runTransform = null;
			_text = null;
		}

		override public function set state(state : String) : void {
			if (state == WidgetState.PREVIEW) state = WidgetState.DISABLE;
			if (super.state == state) return;
			super.state = state;
			changeTextMode(_editingMode, state);
			switch (state) {
				case WidgetState.RUN :
					break;
				case WidgetState.DISABLE : 
					break;
			}
		}

		private function changeTextMode(editingMode : String, state : String) : void {
			if (state == WidgetState.DISABLE) {
				editingMode = EditingMode.READ_ONLY;
				_text.transform.colorTransform = _disableTransform;
			} else if (_text.transform.colorTransform) {
				_text.transform.colorTransform = _runTransform;
			}
			switch (editingMode) {
				case EditingMode.READ_ONLY :
					_text.type = TextFieldType.DYNAMIC;
					_text.selectable = false; 
					break;
				case EditingMode.READ_SELECT :
					_text.type = TextFieldType.DYNAMIC;
					_text.selectable = true; 
					break;
				case EditingMode.READ_WRITE :
					_text.type = TextFieldType.INPUT;
					_text.selectable = true; 
					break;
			}
		}

		protected function get textField() : TLFTextField {
			return _text;
		}

		override ss_internal function get display() : DisplayObject {
			return _text;
		}

		/* *********************************************************************
		 * runtime
		 ********************************************************************* */
		public function get textFlow() : TextFlow {
			return _text.textFlow;
		}

		public function get text() : String {
			return _text.text;
		}

		public function set text(text : String) : void {
			_text.text = text;
		}

		public function get horizontalScrollValue() : Number {
			return _text.scrollH;
		}

		public function set horizontalScrollValue(value : Number) : void {
			_text.scrollH = value;
		}

		public function get verticalScrollValue() : Number {
			return _text.scrollV;
		}

		public function set verticalScrollValue(value : Number) : void {
			_text.scrollV = value;
		}

		public function get horizontalScrollMaxValue() : Number {
			return _text.maxScrollH;
		}

		public function get verticalScrollMaxValue() : Number {
			return _text.maxScrollV;
		}

		public function get horizontalScrollMinValue() : Number {
			return 0;
		}

		public function get verticalScrollMinValue() : Number {
			return 1;
		}

		public function get horizontalScrollTotalValue() : Number {
			return _text.width + _text.maxScrollH;
		}

		public function get verticalScrollTotalValue() : Number {
			return _text.numLines;
		}

		public function get width() : Number {
			return _width;
		}

		public function set width(width : Number) : void {
			_width = width;
			align();
		}

		public function get height() : Number {
			return _height;
		}

		public function set height(height : Number) : void {
			_height = height;
			align();
		}

		public function get x() : Number {
			return _x;
		}

		public function set x(x : Number) : void {
			_x = x;
			align();
		}

		public function get y() : Number {
			return _y;
		}

		public function set y(y : Number) : void {
			_y = y;
			align();
		}

		/* *********************************************************************
		 * evnet 
		 ********************************************************************* */
		private function link(event : TextEvent) : void {
			dispatchEvent(event);
		}

		private function textInput(event : TextEvent) : void {
			dispatchEvent(event);
		}

		private function change(event : Event) : void {
			dispatchEvent(event);
		}

		private function scroll(event : Event) : void {
			dispatchEvent(event);
		}

		override protected function wderegister() : void {
			removeFromService();
		}

		private function focusOut(event : FocusEvent) : void {
			dispatchEvent(event);
		}

		private function focusIn(event : FocusEvent) : void {
			if (_initText) {
				_text.text = "";
				_initText = false;
			}
			dispatchEvent(event);
		}
	}
}
