package ssen.framework.service {
	import ssen.framework.widgets.core.IWidget;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IFrameService extends IEventDispatcher {
		function get stage() : Stage

		function set stage(stage : Stage) : void

		function get root() : Sprite

		function set root(root : Sprite) : void

		function get top() : ITopService

		function set top(top : ITopService) : void

		function get panel() : IPanelService

		function set panel(panel : IPanelService) : void

		function get sw() : int

		function get sh() : int

		function get app() : IWidget

		function set app(app : IWidget) : void
	}
}
