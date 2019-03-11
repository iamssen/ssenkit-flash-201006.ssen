package ssen.framework.widgets.core {
	import flash.display.DisplayObjectContainer;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public interface IWidget {
		function construct() : void

		function deconstruct() : void

		function setting(config : Object = null) : void

		function unsetting() : void

		function register(service : DisplayObjectContainer = null, index : int = -1, initializeState : String = "run") : void

		function deregister() : void

		function get registered() : Boolean

		function get setted() : Boolean

		function get constructed() : Boolean

		function get state() : String

		function set state(state : String) : void
	}
}
