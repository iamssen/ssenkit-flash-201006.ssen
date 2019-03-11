package ssen.framework.service {
	import ssen.framework.widgets.core.IWidget;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class DefaultFrameService extends EventDispatcher implements IFrameService {
		private var _stage : Stage;
		private var _sw : int;
		private var _sh : int;

		public function get stage() : Stage {
			return _stage;
		}

		public function set stage(stage : Stage) : void {
			if (_stage) return;
			_stage = stage;
			_stage.addEventListener(Event.RESIZE, stageResize);
		}

		private function stageResize(event : Event) : void {
			_sw = _stage.stageWidth;
			_sh = _stage.stageHeight;
			dispatchEvent(event);
		}

		private var _root : Sprite;
		private var _top : ITopService;
		private var _panel : IPanelService;
		private var _app : IWidget;

		public function get root() : Sprite {
			return _root;
		}

		public function set root(root : Sprite) : void {
			_root = root;
		}

		public function get top() : ITopService {
			return _top;
		}

		public function set top(top : ITopService) : void {
			_top = top;
		}

		public function get panel() : IPanelService {
			return _panel;
		}

		public function set panel(panel : IPanelService) : void {
			_panel = panel;
		}

		public function get sw() : int {
			return _sw;
		}

		public function get sh() : int {
			return _sh;
		}

		public function get app() : IWidget {
			return _app;
		}

		public function set app(app : IWidget) : void {
			_app = app;
		}
	}
}
