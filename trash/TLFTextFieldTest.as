package ssen.framework.widgets.input {
	import fl.text.TLFTextField;

	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.CompositionCompleteEvent;
	import flashx.textLayout.events.TextLayoutEvent;
	import flashx.textLayout.tlf_internal;
	import flashx.undo.UndoManager;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	
	use namespace tlf_internal;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TLFTextFieldTest extends Sprite {
		private var txt : TLFTextField;
		private var tcm : TCM;
		private var _cache : Rectangle;
		private var tf : TextFlow;
		private var um : UndoManager;
		private var em : EditManager;
		private var tc : ContainerController;
		private var _cache2 : Rectangle;
		private var rs1 : RectShape;
		private var rs3 : RectShape;
		private var rs2 : RectShape;
		private var tlx : TLFTextField;
		private var rs11 : RectShape;

		public function TLFTextFieldTest() {
			txt = new TLFTextField();
			txt.multiline = true;
			///txt.wordWrap = true;
			txt.type = TextFieldType.INPUT;
			txt.x = 10;
			txt.y = 10;
			txt.width = 200;
			txt.height = 100;
			txt.border = true;
			addChild(txt);
			
			txt.addEventListener(Event.SCROLL, scroll);
			
			tcm = new TCM(new Sprite());
			tcm.container.x = 220;
			tcm.container.y = 10;
			tcm.compositionWidth = 200;
			tcm.compositionHeight = 100;
			tcm.editingMode = EditingMode.READ_WRITE;
			tcm.updateContainer();
			
			rs1 = new RectShape();
			rs1.x = 220;
			rs1.y = 10;
			
			rs11 = new RectShape();
			rs11.x = 220;
			rs11.y = 10;
			
			addChild(rs1);
			addChild(rs11);
			addChild(tcm.container);
			
			tcm.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE, tcmCompositionComplete);
			tcm.addEventListener(TextLayoutEvent.SCROLL, tcmScroll);
			
			//define TextFlow
			tf = new TextFlow();
            
			//define elements to contain text
			var p : ParagraphElement = new ParagraphElement();
			var s : SpanElement = new SpanElement();
			s.text = "This is sample text for the EditManager example.";
            
			//add these elements to the TextFlow
			p.addChild(s);
			tf.addChild(p);    
            
			//compose TextFlow to display
			tc = new ContainerController(new Sprite(), 200, 100);
			tc.container.x = 10;
			tc.container.y = 120;
			tf.flowComposer.addController(tc);
			tf.flowComposer.updateAllControllers();
			
            
			//define TextFlow manager objects
			um = new UndoManager();
			em = new EditManager(um);
			tf.interactionManager = em;
			
			tf.addEventListener(TextLayoutEvent.SCROLL, tfScroll);
			
			rs2 = new RectShape();
			rs2.x = 10;
			rs2.y = 120;
			
			rs3 = new RectShape();
			rs3.x = 10;
			rs3.y = 120;
			
			addChild(rs2);
			addChild(rs3);
			addChild(tc.container);
			
			tlx = new TLFTextField();
			tlx.x = 220;
			tlx.y = 120;
			tlx.border = true;
			tlx.width = 200;
			tlx.height = 100;
			tlx.type = TextFieldType.INPUT;
			
			addChild(tlx);
			
			tlx.addEventListener(Event.SCROLL, tlxScroll);
		}

		private function tcmCompositionComplete(event : CompositionCompleteEvent) : void {
			//tcm.getTextFlow().flowComposer.composeToPosition();
			var bounds : Rectangle = tcm.getContentBounds();
			rs11.drawRect(bounds);
			trace("tcm case1", bounds);
		}

		private function tlxScroll(event : Event) : void {
			trace("tlx scroll", tlx.maxScrollH, tlx.maxScrollV);
		}

		private function tfScroll(event : TextLayoutEvent) : void {
			tf.flowComposer.composeToPosition();
			var bounds : Rectangle = tc.getContentBounds();
			if (_cache2 && _cache2.width == bounds.width && _cache2.height == bounds.height) {
				trace("tc", tc.horizontalScrollPosition, tc.verticalScrollPosition, "same bounds");
			} else {
				trace("tc", tc.horizontalScrollPosition, tc.verticalScrollPosition, bounds);
			}
			rs2.drawRect(bounds);
			rs3.drawRect(new Rectangle(tc.contentTop, tc.contentLeft, tc.contentWidth, tc.contentHeight));
			_cache2 = bounds;
		}

		private function tcmScroll(event : TextLayoutEvent) : void {
			tcm.getTextFlow().flowComposer.composeToPosition();
			var bounds : Rectangle = tcm.getContentBounds();
			if (_cache && _cache.width == bounds.width && _cache.height == bounds.height) {
				trace("tcm", tcm.horizontalScrollPosition, tcm.verticalScrollPosition, "same bounds");
			} else {
				trace("tcm", tcm.horizontalScrollPosition, tcm.verticalScrollPosition, bounds);
			}
			rs1.drawRect(bounds);
			_cache = bounds;
		}

		private function scroll(event : Event) : void {
			trace("h", txt.maxScrollH, txt.scrollH, txt.scrollRect);
			trace("v", txt.maxScrollV, txt.scrollV, txt.bottomScrollV);
		}
	}
}

import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.events.FlowOperationEvent;

import ssen.core.MathX;

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;

class RectShape extends Shape {
	private var color : uint;

	public function RectShape() {
		color = MathX.rand(0x000000, 0xffffff);
	}

	public function drawRect(rect : Rectangle) : void {
		graphics.clear();
		graphics.lineStyle(1, 0xeeeeee);
		graphics.beginFill(color, 0.1);
		graphics.drawRect(rect.left, rect.top, rect.width, rect.height);
		graphics.endFill();
	}
}

class TCM extends TextContainerManager {
	public function TCM(container:Sprite) {
		super(container);
		
		addEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN, flowBegin);
		addEventListener(FlowOperationEvent.FLOW_OPERATION_COMPLETE, flowComplete);
		addEventListener(FlowOperationEvent.FLOW_OPERATION_END, flowEnd);
	}

	private function flowEnd(event : FlowOperationEvent) : void {
		trace("end");
	}

	private function flowComplete(event : FlowOperationEvent) : void {
		trace("complete");
		getTextFlow().flowComposer.composeToPosition();
	}

	private function flowBegin(event : FlowOperationEvent) : void {
		trace("begin");
	}

	override public function updateContainer() : void {
		trace("aaa");
		super.updateContainer();
	}

	override public function compose() : void {
		trace("bbb");
		super.compose();
	}
}