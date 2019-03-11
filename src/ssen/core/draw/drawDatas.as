package ssen.core.draw {
	import flash.display.Graphics;
	/**
	 * @author ssen(i@ssen.name)
	 */
	public function drawDatas(graphics : Graphics, datas : Array) : void {
		var f : int = -1;
		var data : IDrawData;
		while(++f < datas.length) {
			data = datas[f];
			data.draw(graphics);
		}
	}
}
