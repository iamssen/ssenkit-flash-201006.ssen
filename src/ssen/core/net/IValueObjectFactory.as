package ssen.core.net {
	import flash.net.URLStream;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public interface IValueObjectFactory {
		function convert(stream : URLStream, respond : Function) : void
	}
}
