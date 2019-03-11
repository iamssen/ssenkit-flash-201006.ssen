package ssen.framework.text {
	import flashx.textLayout.container.TextContainerManager;
	import flashx.textLayout.elements.TextFlow;

	import ssen.core.draw.PathMaker;
	import ssen.core.draw.material.IDrawMaterial;
	import ssen.core.geom.Padding;

	import flash.display.GraphicsPath;
	import flash.display.Sprite;

	/**
	 * TODO 멀티라인 스크롤 텍스트, 입력 텍스트의 베이스로 쓰인다... 단문형태는 StringTextLineFactory 를 사용한다.
	 * 서식 텍스트는 고려하지 않는다.
	 * @author ssen(i@ssen.name)
	 */
	public class StringTextBase extends Sprite {
		private var _container : Sprite;
		private var _manager : TextContainerManager;
		private var _material : IDrawMaterial;
		private var _padding : Padding;
		private var _width : Number;
		private var _height : Number;

		public function StringTextBase(width : Number, height : Number, material : IDrawMaterial = null, padding : Padding = null, textFlow : TextFlow = null) {
			_container = new Sprite();
			addChild(_container);
			
			_manager = new TextContainerManager(_container);
			if (textFlow) _manager.setTextFlow(textFlow);
			
			_width = width;
			_height = height;
			
			_material = material;
			_padding = padding;
			
			update();
		}

		public function update() : void {
			var x : Number;
			var y : Number;
			var w : Number;
			var h : Number;
			
			if (_padding) {
				x = _padding.left;
				y = _padding.top;
				w = _width - _padding.leftAndRight;
				h = _height - _padding.topAndBottom;
			} else {
				x = 0;
				y = 0;
				w = _width;
				h = _height;
			}
			
			_container.x = x;
			_container.y = y;
			_manager.compositionWidth = w;
			_manager.compositionHeight = h;
			
			if (_material) {
				var path : GraphicsPath = new GraphicsPath();
				PathMaker.rect(path, 0, 0, width, height);
				_material.draw(graphics, 0, 0, width, height, path);
			}
			
			_manager.updateContainer();
		}

		public function get textFlow() : TextFlow {
			return _manager.getTextFlow();
		}

		public function set textFlow(flow : TextFlow) : void {
			_manager.setTextFlow(flow);
		}

		public function get material() : IDrawMaterial {
			return _material;
		}

		public function set material(material : IDrawMaterial) : void {
			_material = material;
		}

		public function get padding() : Padding {
			return _padding;
		}

		public function set padding(padding : Padding) : void {
			_padding = padding;
		}

		override public function get width() : Number {
			return _width;
		}

		override public function set width(width : Number) : void {
			_width = width;
		}

		override public function get height() : Number {
			return _height;
		}

		override public function set height(height : Number) : void {
			_height = height;
		}
	}
}
