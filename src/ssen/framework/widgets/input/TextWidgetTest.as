package ssen.framework.widgets.input {
	import ssen.framework.service.FlourSimpleLauncher;
	import ssen.framework.widgets.core.IWidget;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextWidgetTest extends FlourSimpleLauncher {
		override protected function getApplication() : IWidget {
			return new TestApp();
		}
	}
}

import flashx.textLayout.edit.EditingMode;

import ssen.core.draw.material.IDrawMaterialSet;
import ssen.core.geom.Padding;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.core.WidgetState;
import ssen.framework.widgets.input.TextArea;
import ssen.framework.widgets.input.TextAreaConfig;
import ssen.framework.widgets.input.TextWidget;
import ssen.framework.widgets.input.TextWidgetConfig;
import ssen.framework.widgets.scroll.ScrollConfig;
import ssen.framework.widgets.scroll.ScrollDirection;
import ssen.styles.flour.scroll.FlourScrollBoxStyleSet;
import ssen.styles.flour.scroll.FlourScrollStyleSet;

import flash.events.Event;
import flash.events.TextEvent;

class TestApp extends SpriteWidget {
	private var txt : TextWidget;
	private var area : TextArea;
	private var area2 : TextArea2;

	override protected function wregister(initializeState : String = "run") : void {
		var config : TextWidgetConfig = new TextWidgetConfig(200, 100, "가나다라마바사");
		config.editingConfig(EditingMode.READ_WRITE);
		config.multilineConfig(true, true);
		txt = new TextWidget();
		txt.construct();
		txt.setting(config);
		txt.x = 10;
		txt.y = 10;
		txt.register(sprite);
		
		txt.addEventListener(Event.SCROLL, scroll);
		txt.addEventListener(Event.CHANGE, change);
		txt.addEventListener(TextEvent.TEXT_INPUT, textInput);
		txt.addEventListener(TextEvent.LINK, link);
		
		var cfg : TextAreaConfig = new TextAreaConfig(200, 100);
		cfg.textConfig("", "test init text", false, true);
		
		area = new TextArea();
		area.construct();
		area.setting(cfg);
		area.x = 220;
		area.y = 10;
		area.register(sprite, -1, WidgetState.RUN);
		
		cfg.initConfig(200, 200);
		area2 = new TextArea2();
		area2.construct();
		area2.setting(cfg);
		area2.x = 10;
		area2.y = 120;
		area2.register(sprite);
		
		addToService();
	}

	private function link(event : TextEvent) : void {
		trace(event);
	}

	private function textInput(event : TextEvent) : void {
		trace(event);
	}

	private function change(event : Event) : void {
		trace(event);
	}

	private function scroll(event : Event) : void {
		trace(txt.horizontalScrollValue, txt.verticalScrollValue);
	}
}

class TextArea2 extends TextArea {
	/* *********************************************************************
	 * abstract 
	 ********************************************************************* */
	override protected function getPadding() : Padding {
		return new Padding(1, 1, 1, 1);
	}

	override protected function getScrollHConfig() : ScrollConfig {
		var config : ScrollConfig = new ScrollConfig();
		config.materialConfig(FlourScrollStyleSet.thumbH, FlourScrollStyleSet.trackH);
		config.viewConfig(ScrollDirection.HORIZONTAL, 100, 17);
		return config;
	}

	override protected function getScrollVConfig() : ScrollConfig {
		var config : ScrollConfig = new ScrollConfig();
		config.materialConfig(FlourScrollStyleSet.thumbV, FlourScrollStyleSet.trackV);
		config.viewConfig(ScrollDirection.VERTICAL, 17, 100);
		return config;
	}

	override protected function getScrollX() : IDrawMaterialSet {
		return FlourScrollStyleSet.trackX;
	}

	override protected function getMaterial() : IDrawMaterialSet {
		return FlourScrollBoxStyleSet.box;
	}

	override protected function getTextWidgetConfig() : TextWidgetConfig {
		var config : TextWidgetConfig = new TextWidgetConfig();
		config.styleConfig(FlourScrollBoxStyleSet.textFormat, FlourScrollBoxStyleSet.textDisableColor, FlourScrollBoxStyleSet.textPadding);
		config.multiline = true;
		return config;
	}
}