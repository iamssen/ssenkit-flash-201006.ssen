package ssen.debug {
	/**
	 * @author ssen (i@ssen.name)
	 */
	public function objstr(msg : String, obj : Object) : void {
		var arr : Vector.<String> = new Vector.<String>();
		for (var key : String in obj) {
			arr.push(key + ":" + obj[key]);
		}
		trace("#" + msg + " {" + arr.join(", ") + "}");
	}
}
