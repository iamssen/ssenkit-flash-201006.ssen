package ssen.framework.widgets.btns {
	import flashx.textLayout.compose.TextLineRecycler;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.factory.TruncationOptions;

	import ssen.core.draw.material.ITextFormatSet;
	import ssen.core.geom.Padding;
	import ssen.styles.flour.btn.FlourBtnStyleSet;

	import flash.geom.Rectangle;
	import flash.text.engine.TextLine;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class LableBtn extends Btn {
		private var _text : String;
		private var _formats : ITextFormatSet;
		private var _padding : Padding;
		private static var _fac : StringTextLineFactory;
		private var _line : TextLine;

		protected function getFormats() : ITextFormatSet {
			return FlourBtnStyleSet.formats;	
		}

		protected function getPadding() : Padding {
			return new Padding(0, 0, 10, 10);
		}

		/* *********************************************************************
		 * widget 
		 ********************************************************************* */
		override protected function wconstruct() : void {
			super.wconstruct();
			if (!_fac) {
				_fac = new StringTextLineFactory();
				_fac.truncationOptions = new TruncationOptions("", 1);
			}
		}

		override protected function wsetting(config : Object) : void {
			var cfg : BtnConfig = BtnConfig(config);
			_text = cfg.lableText;
			_formats = cfg.lableTextFormats ? cfg.lableTextFormats : getFormats();
			_padding = cfg.lableTextPadding ? cfg.lableTextPadding : getPadding();
			
			super.wsetting(config);
		}

		override protected function wderegister() : void {
			removeTextLine();
			super.wderegister();
		}

		override protected function wunsetting() : void {
			_formats = null;
			_padding = null;
		}

		/* *********************************************************************
		 * text 
		 ********************************************************************* */
		public function get text() : String {
			return _text;
		}

		public function set text(text : String) : void {
			_text = text;
			setInvalid("text", true);
		}

		/* *********************************************************************
		 * rendering 
		 ********************************************************************* */
		override protected function rendering() : void {
			if (getInvalid("size") || getInvalid("draw") || getInvalid("text")) createTextLine(drawState, drawAction);
			super.rendering();
		}

		private function createTextLine(state : String, action : String) : void {
			removeTextLine();
			_fac.text = _text;
			_fac.textFlowFormat = _formats.getFormat(state, action);
			_fac.compositionBounds = new Rectangle(_padding.left, _padding.top, width - _padding.leftAndRight, height - _padding.topAndBottom);
			_fac.createTextLines(createdTextLine);
		}

		private function createdTextLine(line : TextLine) : void {
			_line = line;
			sprite.addChild(line);
		}

		private function removeTextLine() : void {
			if (_line) {
				sprite.removeChild(_line);
				TextLineRecycler.addLineForReuse(_line);
				_line = null;
			}
		}
	}
}
