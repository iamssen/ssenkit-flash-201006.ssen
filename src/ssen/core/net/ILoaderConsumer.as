package ssen.core.net {

	/**
	 * @author ssen(i@ssen.name)
	 */
	public interface ILoaderConsumer {
		function get order() : LoadOrder

		function get hasNextOrder() : Boolean

		function recive(order : LoadOrder) : void

		function reciveFail(order : LoadOrder) : void

		function allow(order : LoadOrder) : void

		function progress(progress : Number) : void

		function completeOrders() : void
	}
}
