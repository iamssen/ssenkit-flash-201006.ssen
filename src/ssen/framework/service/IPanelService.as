package ssen.framework.service {
	import ssen.framework.widgets.panels.IPanelObject;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IPanelService {
		function open(panel : IPanelObject, initializeState : String = "run") : void

		function close(panel : IPanelObject) : void

		function closeAll() : void
	}
}
