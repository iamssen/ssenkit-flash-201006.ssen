package ssen.framework.widgets.btns {
	import ssen.framework.service.FlourSimpleLauncher;
	import ssen.framework.widgets.core.IWidget;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BtnTest extends FlourSimpleLauncher {
		override protected function getApplication() : IWidget {
			return new TestApp();
		}
	}
}

import ssen.core.DisplayX;
import ssen.core.MathX;
import ssen.debug.TestButtonGroup;
import ssen.debug.objstr;
import ssen.framework.widgets.btns.Btn;
import ssen.framework.widgets.btns.BtnConfig;
import ssen.framework.widgets.btns.ClickBtnInteraction;
import ssen.framework.widgets.btns.LableBtn;
import ssen.framework.widgets.btns.events.ClickEvent;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.selection.ISelectionItem;
import ssen.framework.widgets.selection.SelectionBtnInteraction;
import ssen.framework.widgets.selection.SelectionGroup;
import ssen.framework.widgets.selection.events.SelectionEvent;
import ssen.framework.widgets.togglers.ToggleBtnInteraction;
import ssen.framework.widgets.togglers.events.ToggleEvent;

internal class TestApp extends SpriteWidget {
	private var btn0 : Btn;
	private var btn1 : Btn;
	private var group : SelectionGroup;

	override protected function wregister(initializeState : String = "run") : void {
		var tb : TestButtonGroup = new TestButtonGroup("open alert", openAlert);
		tb.x = 10;
		tb.y = 10;
		sprite.addChild(tb);
		
		var config : BtnConfig = new BtnConfig();
		config.interaction = ClickBtnInteraction.get();
		config.clickConfig(200, true, 1000);
		btn0 = new Btn();
		btn0.construct();
		btn0.setting(config);
		btn0.register(sprite);
		btn0.addEventListener(ClickEvent.CLICK, click);
		btn0.addEventListener(ClickEvent.DOUBLE_CLICK, dbclick);
		btn0.addEventListener(ClickEvent.LONG_DOWN, longDown);
		
		
		config.interaction = ToggleBtnInteraction.get();
		config.toggleConfig(true);
		btn1 = new Btn();
		btn1.construct();
		btn1.setting(config);
		btn1.register(sprite);
		btn1.addEventListener(ToggleEvent.TOGGLE, toggle);
		
		trace(btn0.width, btn0.height, btn1.width, btn1.height);
		
		DisplayX.align([btn0, btn1], 10, 100);
		
		var f : int = -1;
		var sel : Btn;
		var sels : Array = [];
		group = new SelectionGroup(true);
		group.addEventListener(SelectionEvent.SELECTION, selection);
		while(++f < 8) {
			config.interaction = SelectionBtnInteraction.get();
			config.lableConfig("button" + f + "가나다라마바사아자차카타파하");
			config.selectionConfig(group, MathX.rand(0, 1) > 0 ? true : false, {value:"test" + f});
			sel = MathX.rand(0, 1) > 0 ? new LableBtn() : new Btn();
			sel.construct();
			sel.setting(config);
			sel.register(sprite);
			group.addItem(sel);
			sels.push(sel);
		}
		
		config.clear();
		
		DisplayX.align(sels, 10, 200);
		
		addToService();
	}

	private function longDown(event : ClickEvent) : void {
		trace(event);
	}

	private function dbclick(event : ClickEvent) : void {
		trace(event);
	}

	private function click(event : ClickEvent) : void {
		trace(event);
		btn1.state = btn1.state == WidgetState.DISABLE ? WidgetState.RUN : WidgetState.DISABLE;
		//btn1.toggle = !btn1.toggle;
//		btn1.setting(BtnConfig.getToggleSetting(false));
//		trace(btn1.toggle);
	}

	private function selection(event : SelectionEvent) : void {
		var list : Vector.<ISelectionItem> = event.selectionGroup.selectedItems();
		var f : int = -1;
		while(++f < list.length) {
			objstr(String(f), list[f].value);
		}
	}

	private function toggle(event : ToggleEvent) : void {
		trace(event);
	}

	private function openAlert() : void {
		trace("hello world");
	}
}
