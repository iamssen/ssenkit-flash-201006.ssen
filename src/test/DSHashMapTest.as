package test {
	import de.polygonal.ds.HashMap;

	import flash.display.Sprite;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class DSHashMapTest extends Sprite {
		public function DSHashMapTest() {
			var hash : HashMap = new HashMap();
			hash.set("width", 153);
			//hash.set("width", 253);
			hash.clear();
			trace(hash.size(), hash.get("width"));
		}
	}
}
