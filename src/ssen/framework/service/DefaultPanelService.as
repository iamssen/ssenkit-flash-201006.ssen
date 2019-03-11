package ssen.framework.service {
	import net.kawa.tween.KTJob;
	import net.kawa.tween.KTween;
	import net.kawa.tween.easing.Quad;

	import ssen.framework.widgets.core.WidgetState;
	import ssen.framework.widgets.panels.IPanelObject;
	import ssen.framework.widgets.visual.DarkScreen;
	import ssen.framework.widgets.visual.IValueVisual;

	import de.polygonal.ds.DLL;
	import de.polygonal.ds.DLLNode;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DefaultPanelService extends Sprite implements IPanelService {
		private var _panels : DLL;
		private var _tw : KTJob;
		private var _screen : IValueVisual;

		public function DefaultPanelService() {
			_panels = new DLL();
			_screen = getDarkScreen();
			SS.frame.addEventListener(Event.RESIZE, stageResize);
		}

		private function stageResize(event : Event) : void {
			if (_panels.size() > 0) {
				var node : DLLNode = _panels.head();
				var panel : IPanelObject;
				while(node != null) {
					panel = IPanelObject(node.val);
					panel.rePositioning();
					node = node.next;
				}
			}
		}

		public function open(panel : IPanelObject, initializeState : String = "run") : void {
			if (_panels.size() <= 0) {
				bgShow(true);
				SS.frame.app.state = WidgetState.DISABLE;
			}
			
			if (panel.node) {
				if (panel.node != _panels.tail()) {
					fall();
					_panels.remove(panel.node);
					panel.node = _panels.insertAfter(_panels.tail(), panel);
					toTop(DisplayObject(panel));
				}
			} else {
				fall();
				panel.node = _panels.append(panel);
				panel.register(this, -1, initializeState);
				panel.addEventListener(Event.CLOSE, panelClose);
			}
		}

		public function closeAll() : void {
			if (_panels.size() > 0) {
				var node : DLLNode = _panels.head();
				var panel : IPanelObject;
				while(node != null) {
					panel = IPanelObject(node.val);
					panel.deregister();
					node = node.next;
				}
			}
			bgShow(false);
			SS.frame.app.state = WidgetState.RUN;
		}

		protected function getDarkScreen() : IValueVisual {
			return new DarkScreen;
		}

		private function panelClose(event : Event) : void {
			close(IPanelObject(event.target));
		}

		/** @private */
		public function get bg() : Number {
			return _screen.value;
		}

		public function set bg(bg : Number) : void {
			_screen.value = bg;
		}

		public function close(panel : IPanelObject) : void {
			if (panel.node) {
				_panels.remove(panel.node);
				panel.node = null;
				panel.deregister();
				
				if (_panels.size() > 0) {
					panel = IPanelObject(_panels.tail().val);
					panel.state = WidgetState.RUN;
					toTop(DisplayObject(panel));
				} else {
					bgShow(false);
					SS.frame.app.state = WidgetState.RUN;
				}
			}
		}

		private function bgShow(visible : Boolean) : void {
			if (visible && !_screen.registered) _screen.register(this);
			if (_tw && !_tw.finished) _tw.abort();
			if (visible) {
				_tw = KTween.to(this, 0.4, {bg:1}, Quad.easeOut);
			} else {
				_tw = KTween.to(this, 0.4, {bg:0}, Quad.easeOut, closeVisible);
			}
		}

		private function closeVisible() : void {
			if (_screen.registered) _screen.deregister();
		}		

		private function fall() : void {
			if (_panels.size() > 0) {
				var panel : IPanelObject = IPanelObject(_panels.tail().val);
				panel.state = WidgetState.DISABLE;
				toTop(DisplayObject(_screen));
			}
		}

		private function toTop(display : DisplayObject) : void {
			setChildIndex(display, numChildren - 1);
		}
	}
}
