package ssen.debug {
	/**
	 * @author ssen(i@ssen.name)
	 */
	public function tostr(msg : String, props : Object) : String {
		var prop : String = "";
		for (var k : String in props) {
			prop += (prop === "") ? "{ " : ", ";
			prop += k + ":" + props[k];
		}
		prop += " }";
		return "#" + msg + " " + prop;
	}
}
