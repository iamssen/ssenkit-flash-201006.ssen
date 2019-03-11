package test {
	import fl.text.TLFTextField;

	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.DisplayX;
	import ssen.core.net.LoadOrder;

	import de.polygonal.ds.ArrayedQueue;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.text.TextFieldType;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;

	/**
	 * @author ssen(i@ssen.name)
	 */
	[SWF(backgroundColor="#555555", frameRate="31", width="550", height="480")]

	public class TLFTest extends SSenIndex {
		override public function completeOrders() : void {
			var font : Font;
			var f : int = -1;
			var fonts : Array = Font.enumerateFonts();
			while(++f < fonts.length) {
				font = fonts[f];
				trace(font.fontName, "style", font.fontStyle, font.fontType);
			}
			
			var tf : TLFTextField = new TLFTextField();
			addChild(tf);
			tf.x = 10;
			tf.y = 10;
			tf.width = 200;
			tf.height = 100;
			tf.text = "가나다라마바사아자";
			tf.type = TextFieldType.INPUT;
			tf.verticalAlign = VerticalAlign.MIDDLE;
			tf.border = true;
			
			var format : TextLayoutFormat = new TextLayoutFormat();
			format.textIndent = 8;
			format.color = 0xffffff;
			format.fontFamily = "나눔고딕OTF, 나눔고딕OTF ExtraBold";
			format.fontSize = 10;
			format.fontWeight = FontWeight.BOLD;
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			trace(format.fontLookup, format.fontFamily);
	 
			var flow : TextFlow = tf.textFlow;
			flow.hostFormat = format;
			flow.flowComposer.updateAllControllers();
			
			var bmd : BitmapData = new BitmapData(300, 100, true, 0x00ffffff);
			bmd.draw(tf);
			var bitmap : Bitmap = new Bitmap(bmd);
			bitmap.y = 150;
			DisplayX.addChildren(this, [bitmap]);
		}

		override protected function initOrders() : ArrayedQueue {
			var or : ArrayedQueue = new ArrayedQueue(2);
			or.enqueue(LoadOrder.get("fonts", new URLRequest("fonts.swf"), LoadOrder.SWF));
			return or;
		}

		override public function recive(order : LoadOrder) : void {
			if (order.id == "fonts") {
				var app : ApplicationDomain = Sprite(order.data).loaderInfo.applicationDomain;
				Font.registerFont(Class(app.getDefinition("ssen.fonts.NanumGR")));
				Font.registerFont(Class(app.getDefinition("ssen.fonts.NanumGB")));
				Font.registerFont(Class(app.getDefinition("ssen.fonts.NanumGEB")));
			}
			
			LoadOrder.put(order);
		}

		override public function reciveFail(order : LoadOrder) : void {
			trace(order.errorMessage);
		}
	}
}
