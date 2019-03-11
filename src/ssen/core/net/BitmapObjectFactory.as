package ssen.core.net {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLStream;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class BitmapObjectFactory implements IValueObjectFactory {
		private var _loader : Loader;
		private var _context : LoaderContext;
		private var _respond : Function;

		public function BitmapObjectFactory(context : LoaderContext = null, uc : UnloadCollection = null) {
			_loader = new Loader();
			_context = context;
			if (uc) uc.add(_loader);
		}

		public function convert(stream : URLStream, respond : Function) : void {
			var bytes : ByteArray = new ByteArray();
			stream.readBytes(bytes);
			_respond = respond;
			_loader.loadBytes(bytes, _context);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
		}

		private function complete(event : Event) : void {
			_respond(Bitmap(_loader.content).bitmapData);
			_respond = null;
			_context = null;
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, complete);
		}
	}
}
