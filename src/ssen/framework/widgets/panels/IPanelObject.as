package ssen.framework.widgets.panels {
	import ssen.framework.widgets.core.IWidget;

	import de.polygonal.ds.DLLNode;

	import flash.events.IEventDispatcher;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IPanelObject extends IWidget, IEventDispatcher {
		function get node() : DLLNode

		function set node(node : DLLNode) : void

		function rePositioning() : void
	}
}
