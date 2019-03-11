package ssen.framework.widgets.selection {

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface ISelectionItem {
		function get selection() : Boolean

		function set selection(selection : Boolean) : void

		function get value() : Object
	}
}
