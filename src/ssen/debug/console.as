package ssen.debug {
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author ssen(i@ssen.name)
	 */
	public function console(cl : Object, ...strs : Array) : void {
		if (Capabilities.isDebugger) {
			ExternalInterface.call("console.log", getQualifiedClassName(cl) + " :: " + strs.join(","));
		}
		trace(strs.join(", "));
	}
}
