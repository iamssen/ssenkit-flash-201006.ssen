package ssen.framework.widgets.scroll {
	import net.kawa.tween.KTJob;
	import net.kawa.tween.KTween;
	import net.kawa.tween.easing.Quad;

	import ssen.core.draw.PathMaker;
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.debug.ErrMsg;
	import ssen.framework.widgets.core.InvalidSpriteWidget;
	import ssen.framework.widgets.core.WidgetState;
	import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

	import flash.display.GraphicsPath;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Scroll extends InvalidSpriteWidget {
		// value
		private var _maxValue : Number;
		private var _minValue : Number;
		private var _totalValue : Number;
		private var _value : Number;
		// converted
		private var _view : Number;
		private var _total : Number;
		private var _now : Number;
		// view
		private var _trackSize : Number;
		private var _thumbSize : Number;
		private var _thumbPos : Number;
		private var _thumbMaxPos : Number;
		private var _thumbEnable : Boolean;
		// init
		private var _direction : Boolean;
		// event
		private var _downStagePos : Number;
		private var _downThumbPos : Number;
		// setting
		private var _trackMode : Boolean;
		private var _trackHide : Boolean;
		private var _trackSkinFlag : String;
		private var _thumbSkinFlag : String;
		private var _thumbPosEnd : Number;
		private var _max : Number;
		private var _width : Number;
		private var _height : Number;
		private var _thumbMaterial : IDrawMaterialSet;
		private var _trackMaterial : IDrawMaterialSet;
		private var _tween : KTJob;
		private var _evtWating : Boolean;
		private var _evtScroll : Boolean;
		private var _path : GraphicsPath;

		private function getTrackMaterial() : IDrawMaterialSet {
			return FlourScrollBoxStyleSet.track;
		}

		private function getThumbMaterial() : IDrawMaterialSet {
			return FlourScrollBoxStyleSet.thumb;
		}

		override protected function wconstruct() : void {
			super.wconstruct();
			sprite.mouseChildren = false;
		}

		override protected function wsetting(config : Object) : void {
			if (!config is ScrollConfig) throw new Error(ErrMsg.typeUnMatch("ScrollConfig 가 필요함"));
			var cfg : ScrollConfig = ScrollConfig(config);
			_thumbMaterial = cfg.thumbMaterial ? cfg.thumbMaterial : getThumbMaterial();
			_trackMaterial = cfg.trackMaterial ? cfg.trackMaterial : getTrackMaterial();
			_width = cfg.width;
			_height = cfg.height;
			_direction = cfg.direction;
			_trackMode = cfg.trackMode;
			_trackHide = cfg.trackHide;
			_minValue = cfg.min;
			_maxValue = cfg.max;
			_totalValue = cfg.total;
			_value = cfg.pos;
			setInvalid("size", true);
			setInvalid("scroll", true);
		}

		override protected function wregister(initializeState : String = "run") : void {
			addToService();
			_path = new GraphicsPath();
			state = initializeState;
		}

		override protected function wderegister() : void {
			if (_evtScroll) scrollEventOff();
			if (_evtWating) watingEventOff();
			_path = null;
			removeFromService();
		}

		override protected function wunsetting() : void {
			_thumbMaterial = null;
			_trackMaterial = null;
			unsetInvalidate();
		}

		override public function set state(state : String) : void {
			if (state == WidgetState.PREVIEW) state = WidgetState.DISABLE;
			if (super.state == state) return;
			super.state = state;
			switch (state) {
				case WidgetState.RUN : 
					if (_evtScroll) scrollEventOff();
					if (!_evtWating) watingEventOn();
					sprite.buttonMode = true;
					sprite.mouseEnabled = true;
					break;
				case WidgetState.DISABLE :
					if (_evtScroll) scrollEventOff();
					if (_evtWating) watingEventOff();
					sprite.buttonMode = false;
					sprite.mouseEnabled = false;
					break;
			}
			setInvalid("state", true);
		}

		/* *********************************************************************
		 * event 
		 ********************************************************************* */
		private function watingEventOn() : void {
			_evtWating = true;
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			sprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}

		private function watingEventOff() : void {
			_evtWating = false;
			sprite.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			sprite.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}

		private function scrollEventOn() : void {
			_evtScroll = true;
			sprite.stage.addEventListener(MouseEvent.MOUSE_MOVE, scroll);
			sprite.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		private function scrollEventOff() : void {
			_evtScroll = false;
			sprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, scroll);
			sprite.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		private function mouseOut(event : MouseEvent) : void {
			thumbSkinChange("default");
			trackSkinChange("default");
		}

		private function mouseDown(event : MouseEvent) : void {
			var downPos : Number;
			var stagePos : Number;
			if (_direction) {
				downPos = event.localX;
				stagePos = event.stageX;
			} else {
				downPos = event.localY;
				stagePos = event.stageY;
			}
			if (calculate()) {
				watingEventOff();
				if (downPos > _thumbPos && downPos < _thumbPosEnd) {
					_downStagePos = stagePos;
					_downThumbPos = _thumbPos;
					scrollEventOn();
				} else {
					var ratio : Number;
					var max : Number = (_trackSize - _thumbSize);
					if (downPos < _thumbPos) {
						ratio = _trackMode ? (downPos - 10) / max : (_thumbPos - (_thumbSize >> 1)) / max;
					} else {
						ratio = _trackMode ? (downPos - 10) / max : (_thumbPos + (_thumbSize >> 1)) / max;
					}
					if (ratio < 0) ratio = 0;
					if (ratio > 1) ratio = 1;
					_tween = KTween.to(this, 0.3, {scrollPositionRatio:ratio}, Quad.easeOut);
					_tween.addEventListener(Event.CHANGE, tweenUpdate);
					_tween.addEventListener(Event.COMPLETE, tweenComplete);
				}
				
				thumbSkinChange("action");
				trackSkinChange("action");
			}
		}

		private function scroll(event : MouseEvent) : void {
			var stagePos : Number = _direction ? event.stageX : event.stageY;
			var t : Number = stagePos - _downStagePos;
			var pos : Number = _downThumbPos + t;
			if (pos < 0) pos = 0;
			if (pos > _thumbMaxPos) pos = _thumbMaxPos;
			scrollPositionRatio = pos / _thumbMaxPos;
			dispatchEvent(new Event(Event.SCROLL));
			event.updateAfterEvent();
		}

		private function tweenComplete(event : Event) : void {
			_tween.removeEventListener(Event.CHANGE, tweenUpdate);
			_tween.removeEventListener(Event.COMPLETE, tweenComplete);
			
			thumbSkinChange("default");
			trackSkinChange("default");
			
			watingEventOn();
		}

		private function tweenUpdate(event : Event) : void {
			dispatchEvent(new Event(Event.SCROLL));
		}

		private function mouseUp(event : MouseEvent) : void {
			scrollEventOff();
			watingEventOn();
			
			thumbSkinChange("default");
			trackSkinChange("default");
		}

		private function thumbSkinChange(flag : String) : void {
			if (flag != _thumbSkinFlag) {
				_thumbSkinFlag = flag;
				setInvalid("action", true);
			}
		}

		private function trackSkinChange(flag : String) : void {
			if (flag != _trackSkinFlag) {
				_trackSkinFlag = flag;
				setInvalid("action", true);
			}
		}

		/* *********************************************************************
		 * original properties
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

		/** scroll 의 방향 */
		public function get direction() : Boolean {
			return _direction;
		}

		/** scroll 될 수 있는 최대값 */
		public function get maxScrollPosition() : Number {
			return _maxValue;
		}

		/** scroll 될 수 있는 최소값 */ 
		public function get minScrollPosition() : Number {
			return _minValue;
		}

		/** 내용물의 최대값 */
		public function get pageSize() : Number {
			return _totalValue;
		}

		/** scroll 위치 */
		public function get scrollPosition() : Number {
			return _value;
		}

		public function set scrollPosition(scrollPosition : Number) : void {
			if (_evtScroll) return;
			if (scrollPosition < _minValue) scrollPosition = _minValue;
			if (scrollPosition > _maxValue) scrollPosition = _maxValue;
			_value = scrollPosition;
			setInvalid("scroll", true);
		}

		public function resetScrollSize(width : Number, height : Number) : void {
			_width = width;
			_height = height;
			setInvalid("size", true);
		}

		public function resetScrollInfo(min : Number, max : Number, total : Number) : void {
			_minValue = min;
			_maxValue = max;
			_totalValue = total;
			setInvalid("scroll", true);
		}

		/* *********************************************************************
		 * expansive properties 
		 ********************************************************************* */
		/** (ratio) scroll 위치 */
		public function get scrollPositionRatio() : Number {
			return calculate() ? _now / _max : 0;
		}

		public function set scrollPositionRatio(ratio : Number) : void {
			if (ratio < 0) ratio = 0;
			if (ratio > 1) ratio = 1;
			_value = (ratio * _max) + _minValue;
			setInvalid("scroll", true);
		}

		/** (ratio) 전체 대비 컨텐츠의 비율 - 스크롤썸의 크기 비율 */
		public function get scrollSightRatio() : Number {
			return calculate() ? _now / _total : 0;
		}

		public function get scrollEnable() : Boolean {
			return false;
		}

		/* *********************************************************************
		 * calculate 
		 ********************************************************************* */
		private function calculate() : Boolean {
			// converted value
			_total = _totalValue - _minValue;
			_view = _totalValue - _maxValue;
			_now = _value - _minValue;
			_max = _total - _view;
			// enable check
			_thumbEnable = _total > _view;
			if (!_thumbEnable) return false;
			// pixel
			_trackSize = _direction ? _width : _height;
			_thumbSize = (_view / _total) * _trackSize;
			_thumbMaxPos = _trackSize - _thumbSize;
			_thumbPos = (_now / _max) * _thumbMaxPos;
			_thumbPosEnd = _thumbPos + _thumbSize;
			return true;
		}

		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		override protected function rendering() : void {
			calculate();
			graphics.clear();
			
			if (_thumbEnable || !_trackHide) drawTrack();
			if (_thumbEnable) drawThumb();
			
			super.rendering();
		}

		/* *********************************************************************
		 * draw 
		 ********************************************************************* */
		private function drawTrack() : void {
			var path : GraphicsPath = new GraphicsPath();
			PathMaker.rect(path, 0, 0, width, height);
			_trackMaterial.draw(state, _trackSkinFlag, graphics, 0, 0, width, height, path);
		}

		private function drawThumb() : void {
			var x : Number;
			var y : Number;
			var w : Number;
			var h : Number;
			if (_direction) {
				x = _thumbPos;
				y = 0;
				w = _thumbSize;
				h = height;
			} else {
				x = 0;
				y = _thumbPos;
				w = width;
				h = _thumbSize;
			}
			var path : GraphicsPath = new GraphicsPath();
			PathMaker.rect(path, x, y, w, h);
			_thumbMaterial.draw(state, _thumbSkinFlag, graphics, x, y, w, h, path);
		}
	}
}