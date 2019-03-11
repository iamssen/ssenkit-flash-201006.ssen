package ssen.framework.service {
	import flashx.textLayout.compose.TextLineRecycler;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.DisplayX;
	import ssen.core.net.FontObjectFactory;
	import ssen.core.net.ILoaderConsumer;
	import ssen.core.net.LoadOrder;
	import ssen.core.net.LoadProvider;
	import ssen.styles.flour.FlourTextFormatFactory;
	import ssen.framework.widgets.core.IWidget;

	import de.polygonal.ds.ArrayedQueue;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.engine.TextLine;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourSimpleLauncher extends Sprite implements ILoaderConsumer {
		private var _list : ArrayedQueue;
		private var _prov : LoadProvider;
		private var _wating : Boolean;
		private var _lines : Vector.<TextLine>;

		public function FlourSimpleLauncher(wating : Boolean = false) {
			_wating = wating;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (_wating) {
				_lines = new Vector.<TextLine>();
				createMessage();
			} else {
				start();
			}
		}

		protected function createMessage() : void {
			var fac : StringTextLineFactory = new StringTextLineFactory();
			fac.textFlowFormat = FlourTextFormatFactory.getSystemSansSerif(11, TextAlign.CENTER, VerticalAlign.MIDDLE);
			fac.compositionBounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			fac.text = "click to start";
			fac.createTextLines(createdMessage);
			
			stage.addEventListener(MouseEvent.CLICK, start);
		}

		private function createdMessage(line : TextLine) : void {
			addChild(line);
			_lines.push(line);
		}

		private function start(event : MouseEvent = null) : void {
			if (event) {
				stage.removeEventListener(MouseEvent.CLICK, start);
				var f : int = _lines.length;
				var line : TextLine;
				while (--f >= 0) {
					line = _lines[f];
					removeChild(line);
					TextLineRecycler.addLineForReuse(line);
				}
				_lines = null;
			}
			_list = getResourceList();
			if (_list) {
				_prov = new LoadProvider();
				_prov.enqueue(this);
				_prov.play();
			} else {
				createServices();
			}
		}

		/* *********************************************************************
		 * abstract method
		 ********************************************************************* */
		protected function getResourceList() : ArrayedQueue {
			var list : ArrayedQueue = new ArrayedQueue(2);
			list.enqueue(LoadOrder.get("fonts", new URLRequest("fonts.swf"), new FontObjectFactory(["ssen.fonts.NanumGR", "ssen.fonts.NanumGB"])));
			return list;
		}

		public function recive(order : LoadOrder) : void {
		}

		public function reciveFail(order : LoadOrder) : void {
			trace("simple luncher recive fail", order.errorMessage);
		}

		public function allow(order : LoadOrder) : void {
			trace("simple luncher allow", order.errorMessage);
		}

		public function progress(progress : Number) : void {
			trace("simple luncher progress", progress);
		}

		public final function completeOrders() : void {
			_list.clear();
			_list = null;
			_prov = null;
			createServices();
		}

		private function createServices() : void {
			SS.frame = new DefaultFrameService();
			SS.frame.stage = stage;
			SS.frame.root = this;
			SS.frame.panel = new DefaultPanelService();
			SS.frame.top = new DefaultTopService();
			SS.frame.app = getApplication();
			
			DisplayX.addChildren(this, [SS.frame.panel, SS.frame.top]);
			
			SS.frame.app.construct();
			SS.frame.app.setting();
			SS.frame.app.register(this, 1);
		}		

		public final function get order() : LoadOrder {
			return LoadOrder(_list.dequeue());
		}

		public final function get hasNextOrder() : Boolean {
			return _list.size() > 0;
		}

		protected function getApplication() : IWidget {
			return null;
		}
	}
}

import flash.display.Sprite;

internal class BottomSprite extends Sprite {
	public function BottomSprite() {
	}
}