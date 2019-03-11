package ssen.framework.widgets.input {
	import flashx.textLayout.container.TextContainerManager;
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.events.CompositionCompleteEvent;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.textLayout.events.TextLayoutEvent;

	import ssen.framework.widgets.core.IWidget;
	import ssen.framework.widgets.core.WidgetState;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.FocusEvent;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextControl extends TextContainerManager implements IWidget {
		private var _constructed : Boolean;
		private var _setted : Boolean;
		private var _registered : Boolean;
		private var _state : String;
		private var _service : DisplayObjectContainer;
		private var _index : int;
		private var _initText : Boolean;
		private var _drawAction : String;
		private var _input : TextInputOld;

		public function TextControl() {
			super(new Sprite());
		}

		final public function construct() : void {
			if (constructed) return;
			_constructed = true;
			wconstruct();
		}

		final public function setting(config : Object = null) : void {
			if (!constructed || setted) return;
			_setted = true;
			
			_input = config["input"];
			if (config["text"] != "") {
				text = config["text"];
			} else if (config["initText"] != "") {
				_initText = true;
				text = config["initText"];
			}
			
			wsetting(config);
		}

		final public function register(service : DisplayObjectContainer = null, index : int = -1, initializeState : String = "run") : void {
			if (!constructed || !setted || registered) return;
			_registered = true;
			_service = service;
			_index = index;
			
			addEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN, flowOperationBeginHandler);
			addEventListener(FlowOperationEvent.FLOW_OPERATION_COMPLETE, flowOperationCompleteHandler);
			addEventListener(FlowOperationEvent.FLOW_OPERATION_END, flowOperationEndHandler);
			addEventListener(TextLayoutEvent.SCROLL, scrollHandler);
			//addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, composition);
			_drawAction = "default";
			state = initializeState;
			
			wregister(initializeState);
		}

		private function composition(event : CompositionCompleteEvent) : void {
			removeEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, composition);
			composeToPosition();
		}

		final public function deregister() : void {
			if (!registered) return;
			_registered = false;
			
			removeEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN, flowOperationBeginHandler);
			removeEventListener(FlowOperationEvent.FLOW_OPERATION_COMPLETE, flowOperationCompleteHandler);
			removeEventListener(FlowOperationEvent.FLOW_OPERATION_END, flowOperationEndHandler);
			removeEventListener(TextLayoutEvent.SCROLL, scrollHandler);
			
			wderegister();
		}

		final public function unsetting() : void {
			if (registered || !setted) return;
			_setted = false;
			wunsetting();
		}

		final public function deconstruct() : void {
			if (registered || setted || !constructed) return;
			_constructed = false;
			wdeconstruct();
		}

		protected function wconstruct() : void {
		}

		protected function wsetting(config : Object) : void {
		}

		protected function wregister(initializeState : String = "run") : void {
		}

		protected function wderegister() : void {
		}

		protected function wunsetting() : void {
		}

		protected function wdeconstruct() : void {
		}

		final protected function addToService() : void {
			if (_index > -1) {
				_service.addChildAt(display, _index);
			} else {
				_service.addChild(display);
			}
		}

		final protected function removeFromService() : void {
			_service.removeChild(display);
			_service = null;
			_index = -1;
		}

		final public function get registered() : Boolean {
			return _registered;
		}

		final public function get setted() : Boolean {
			return _setted;
		}

		final public function get constructed() : Boolean {
			return _constructed;
		}

		public function get state() : String {
			return _state;
		}

		public function set state(state : String) : void {
			if (state == WidgetState.PREVIEW) state = WidgetState.DISABLE;
			if (_state == state) return;
			_state = state;
			
			switch (state) {
				case WidgetState.RUN : 
					container.mouseChildren = true;
					container.mouseEnabled = true;
					editingMode = EditingMode.READ_WRITE;
					break;
				case WidgetState.DISABLE :
					container.mouseChildren = false;
					container.mouseEnabled = false;
					editingMode = EditingMode.READ_SELECT;
					break;
			}
			draw();
		}

		public function get display() : DisplayObject {
			return container;
		}

		/* *********************************************************************
		 * 
		 ********************************************************************* */
		//		override public function getContentBounds() : Rectangle {
		//			if (getTextFlow().flowComposer) getTextFlow().flowComposer.composeToPosition();
		//			return super.getContentBounds();
		//		}
		protected function draw() : void {
			throw new Error("not implemented");
		}

		public function get drawState() : String {
			return state;
		}

		public function get drawAction() : String {
			return _drawAction;
		}

		public function get text() : String {
			throw new Error("not implemented");
		}

		public function set text(text : String) : void {
			throw new Error("not implemented");
		}

		public function get horizontalScrollEnabled() : Boolean {
			throw new Error("not implemented");
		}

		public function get verticalScrollEnabled() : Boolean {
			throw new Error("not implemented");
		}

		public function composeToPosition() : void {
			if (getTextFlow().flowComposer) {
				getTextFlow().flowComposer.composeToPosition();
				_input.composition();
			}
		}

		/* *********************************************************************
		 * event 
		 ********************************************************************* */
		protected function flowOperationEndHandler(event : FlowOperationEvent) : void {
		}

		protected function flowOperationCompleteHandler(event : FlowOperationEvent) : void {
			composeToPosition();
		}

		protected function flowOperationBeginHandler(event : FlowOperationEvent) : void {
		}

		private function scrollHandler(event : TextLayoutEvent) : void {
			_input.scroll();
		}

		override public function focusInHandler(event : FocusEvent) : void {
			super.focusInHandler(event);
			if (_initText) text = "";
			_drawAction = "edit";
			draw();
		}

		override public function focusOutHandler(event : FocusEvent) : void {
			super.focusOutHandler(event);
			_drawAction = "default";
			draw();
		}
	}
}
