package ssen.framework.widgets.visual {
	import ssen.framework.widgets.core.IWidget;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IValueVisual extends IWidget {
		function get value() : Number

		function set value(value : Number) : void
	}
}
