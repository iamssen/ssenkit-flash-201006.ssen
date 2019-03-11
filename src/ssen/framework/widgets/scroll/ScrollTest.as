package ssen.framework.widgets.scroll {
	import ssen.framework.service.FlourSimpleLauncher;
	import ssen.framework.widgets.core.IWidget;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ScrollTest extends FlourSimpleLauncher {
		override protected function getApplication() : IWidget {
			return new TestApp();
		}
	}
}

import ssen.core.DisplayX;
import ssen.debug.TestButtonGroup;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.scroll.Scroll;
import ssen.framework.widgets.scroll.ScrollConfig;
import ssen.framework.widgets.scroll.ScrollDirection;
import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;

import flash.events.Event;
import flash.text.TextField;

internal class TestApp extends SpriteWidget {
	private var _txt : TextField;
	private var _scrollV : Scroll;
	private var _scrollH : Scroll;

	override protected function wregister(initializeState : String = "run") : void {
		super.wregister();
		
		var text : String = "YYYYY\n";
		var f : int = 50;
		while (--f >= 0) {
			text += f + " :: abcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuXXX\n";
		}
		text += "XXXXXX";
			
		_txt = new TextField();
		_txt.multiline = true;
		_txt.border = true;
		_txt.text = text;
		_txt.width = 200;
		_txt.height = 300;
		_txt.addEventListener(Event.SCROLL, container);
		
		var tg : TestButtonGroup = new TestButtonGroup("set scroll pos", setScrollPos, "enable toggle", enabledToggle);
		DisplayX.addChildren(sprite, [tg, _txt]);
		DisplayX.nextPos(_txt, tg, true, 5, 30);
		
		var config : ScrollConfig = new ScrollConfig();
		//config.materialConfig(FlourScrollStyleSet.thumbV, FlourScrollStyleSet.trackV);
		//config.viewConfig(ScrollDirection.VERTICAL, 17, 300);
		config.materialConfig(FlourScrollBoxStyleSet.thumb, FlourScrollBoxStyleSet.track);
		config.viewConfig(ScrollDirection.VERTICAL, 5, 300);
		config.valueConfig(1, _txt.maxScrollV, _txt.numLines, _txt.scrollV);
			
		_scrollV = new Scroll();
		_scrollV.construct();
		_scrollV.setting(config);
		_scrollV.x = _txt.x + _txt.width;
		_scrollV.y = _txt.y;
		_scrollV.addEventListener(Event.SCROLL, scrollV);
		_scrollV.register(sprite, -1, WidgetState.DISABLE);
		
		//config.materialConfig(FlourScrollStyleSet.thumbH, FlourScrollStyleSet.trackH);
		//config.viewConfig(ScrollDirection.HORIZONTAL, 200, 17);
		config.viewConfig(ScrollDirection.HORIZONTAL, 200, 5);
		config.valueConfig(0, _txt.maxScrollH, _txt.maxScrollH + _txt.width, _txt.scrollH);
		
		_scrollH = new Scroll();
		_scrollH.construct();
		_scrollH.setting(config);
		_scrollH.x = _txt.x;
		_scrollH.y = _txt.y + _txt.height;
		_scrollH.addEventListener(Event.SCROLL, scrollH);
		_scrollH.register(sprite);
		
		config.clear();
		
		addToService();
	}

	private function scrollH(event : Event) : void {
		_txt.scrollH = _scrollH.scrollPosition;
	}

	private function enabledToggle() : void {
		_scrollV.state = _scrollV.state == WidgetState.RUN ? WidgetState.DISABLE : WidgetState.RUN;
	}

	private function setScrollPos() : void {
		_scrollV.scrollPosition = -20;
		_txt.scrollV = _scrollV.scrollPosition;
	}

	private function container(event : Event) : void {
//		if (_scrollH && _scrollV) {
//			_scrollH.scrollPosition = _txt.scrollH;
//			_scrollV.scrollPosition = _txt.scrollV;
//		}
	}

	private function scrollV(event : Event) : void {
		//trace(_scrollV.scrollPositionRatio, _scrollH.scrollPositionRatio);
		_txt.scrollV = _scrollV.scrollPosition;
	}
}
