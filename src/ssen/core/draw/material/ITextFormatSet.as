package ssen.core.draw.material {
	import flashx.textLayout.formats.ITextLayoutFormat;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface ITextFormatSet {
		function getFormat(state : String, action : String) : ITextLayoutFormat
	}
}
