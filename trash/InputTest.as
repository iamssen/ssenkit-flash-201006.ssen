package ssen.framework.widgets.input {
	import ssen.framework.service.FlourSimpleLauncher;
	import ssen.framework.widgets.core.IWidget;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class InputTest extends FlourSimpleLauncher {
		override protected function getApplication() : IWidget {
			return new TestApp();
		}
	}
}

import flashx.textLayout.container.TextContainerManager;
import flashx.textLayout.edit.EditingMode;
import flashx.textLayout.formats.TextAlign;
import flashx.textLayout.formats.VerticalAlign;

import ssen.framework.text.FlourTextFormats;
import ssen.framework.widgets.core.SpriteWidget;
import ssen.framework.widgets.input.TextInputOld;

import flash.display.Sprite;

internal class TestApp extends SpriteWidget {
	private var input : TextInputOld;
	private var manager : TextContainerManager;

	override protected function wregister(initializeState : String = "run") : void {
		var txt : String = "AAAAAAA";
		var f : int = -1;
		while(++f < 50) {
			txt += "\n" + f + " :: abcdefghijklmnabcdefghijklmnabcdefghijklmnabcdefghijklmnabcdefghijklmnXXXX";
		}
		txt += "\nBBBBBBB";
		
		input = new TextInputOld();
		input.construct();
		input.setting({width:200, height:100, text:txt});
		input.display.x = 10;
		input.display.y = 10;
		input.register(sprite);
		
		manager = new TextContainerManager(new Sprite());
		manager.container.x = 220;
		manager.container.y = 10;
		manager.compositionWidth = 200;
		manager.compositionHeight = 100;
		manager.editingMode = EditingMode.READ_WRITE;
		manager.hostFormat = FlourTextFormats.getEmbedSansSerif(10, TextAlign.LEFT, VerticalAlign.TOP, 0x3f3f3f);
		sprite.addChild(manager.container);
		manager.updateContainer();
		
		addToService();
	}
}