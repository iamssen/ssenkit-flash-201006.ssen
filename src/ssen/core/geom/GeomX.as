package ssen.core.geom {
	import flash.geom.Rectangle;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class GeomX {
		public static const TOP : String = "top";
		public static const MIDDLE : String = "middle";
		public static const BOTTOM : String = "bottom";
		public static const LEFT : String = "left";
		public static const RIGHT : String = "right";
		public static const CENTER : String = "center";

		public static function ratioTransform(rect : Rectangle, stageWidth : Number, stageHeight : Number) : void {
			var width : Number = rect.width;
			var height : Number = rect.height;
			// rect 를 조건에 맞게 변형시켜준다.
			if (height / width > stageHeight / stageWidth) {
				rect.width = (stageHeight / height) * width;
				rect.height = stageHeight;
				rect.x = (stageWidth >> 1) - (rect.width >> 1);
				rect.y = 0;
			} else {
				rect.width = stageWidth;
				rect.height = (stageWidth / width) * height;
				rect.x = 0;
				rect.y = (stageHeight >> 1) - (rect.height >> 1);
			}
		}
	}
}
