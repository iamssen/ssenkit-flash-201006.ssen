package ssen.core.net {
	import de.polygonal.ds.SLL;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.net.URLRequest;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class LoaderTest extends Sprite implements ILoaderConsumer {
		private var prov : LoadProvider;
		private var orders : SLL;
		private var _allow : Function;
		namespace atom = "http://www.w3.org/2005/Atom";
		use namespace atom;

		public function LoaderTest() {
			orders = new SLL;
			orders.append(LoadOrder.get("ascii1", new URLRequest("http://search.twitter.com/search.atom?q=http://ssen.name?d=1083"), new StringObjectFactory()));
			orders.append(LoadOrder.get("ascii2", new URLRequest("http://search.twitter.com/search.atom?q=@ssen"), new StringObjectFactory()));
			orders.append(LoadOrder.get("bitmap1", new URLRequest("asset/profile.png"), new BitmapObjectFactory()));
			orders.append(LoadOrder.get("swf1", new URLRequest("DSArray2Test.swf"), new SWFObjectFactory()));
			orders.append(LoadOrder.get("swf2", new URLRequest("DSArray2Test2.swf"), new SWFObjectFactory()));
			prov = new LoadProvider;
			prov.enqueue(this);
			prov.play();
		}

		public function recive(data : LoadOrder) : void {
			switch (data.id) {
				case "ascii1" : 
				case "ascii2" :
					trace(data.data);
					var entries : XMLList = new XML(data.data).entry;
	
					var f : int = -1;
					while(++f < entries.length()) {
						trace(entries[f].title, decodeURIComponent(entries[f].content));
					}
					break;
				case "bitmap1" :
					var bitmap : BitmapData = BitmapData(data.data);
					graphics.beginBitmapFill(bitmap);
					graphics.drawRect(0, 0, bitmap.width, bitmap.height);
					graphics.endFill(); 
					break;
				default :
					addChild(DisplayObject(data.data)); 
					break;
			}
			LoadOrder.put(data);
		}

		public function reciveFail(error : LoadOrder) : void {
			trace(error.errorMessage, error.httpStatus);
			LoadOrder.put(error);
		}

		public function allow(order : LoadOrder) : void {
			trace(order.errorMessage, "업로드에 대한 승인을 요청함");
			_allow = order.allow;
		}

		public function progress(progress : Number) : void {
			trace("progress", progress);
		}

		public function get order() : LoadOrder {
			return LoadOrder(orders.removeHead());
		}

		public function get hasNextOrder() : Boolean {
			return orders.size() > 0;
		}

		public function completeOrders() : void {
			trace("complete orders");
		}
	}
}
