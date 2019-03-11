package ssen.core.net {
	import flash.net.URLStream;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class StringObjectFactory implements IValueObjectFactory {
		private var _charSet : String;

		public function StringObjectFactory(charSet : String = "utf-8") {
			_charSet = charSet;
		}

		public function convert(stream : URLStream, respond : Function) : void {
			respond(stream.readMultiByte(stream.bytesAvailable, _charSet));
		}
	}
}
