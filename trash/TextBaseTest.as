package ssen.framework.text {
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.ITextExporter;
	import flashx.textLayout.conversion.ITextImporter;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.factory.TruncationOptions;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.DisplayX;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.engine.TextLine;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class TextBaseTest extends Sprite {
		private var _txt : StringTextBase;

		public function TextBaseTest() {
			_txt = new StringTextBase(200, 100);
			
			var format : TextLayoutFormat = new TextLayoutFormat();
			format.verticalAlign = VerticalAlign.MIDDLE;
			format.textAlign = TextAlign.CENTER;
			var config : Configuration = new Configuration();
			config.textFlowInitialFormat = format;
			
			var importer : ITextImporter = TextConverter.getImporter(TextConverter.PLAIN_TEXT_FORMAT, config);
			var flow : TextFlow = importer.importToFlow("이미지를 삽입합니다.\n이미지의 소스는 URI를 포함하는 문자열, URLRequest 객체, 포함된 에셋을 나타내는 클래스 객체 또는 DisplayObject 인스턴스일 수 있습니다.\n폭 및 높이 값은 픽셀 수, 퍼센트 또는 그래픽의 실제 크기가 사용된 경우 문자열 'auto'로 나타날 수 있습니다.\nFloat 클래스에 정의된 상수 중 하나로 float을 설정하여 이미지가 텍스트의 왼쪽 또는 오른쪽에 표시되어야 하는지 또는 텍스트와 함께 표시되어야 하는지 여부를 지정합니다.");
			//var flow : TextFlow = importer.importToFlow("이미지를 삽입합니다.");
			_txt.textFlow = flow;
			_txt.x = 10;
			_txt.y = 10;
			_txt.update();
			
			var exporter : ITextExporter = TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT);
			trace(exporter.export(_txt.textFlow, ConversionType.XML_TYPE));
			
			DisplayX.addChildren(this, [_txt]);
			
			var strfac : StringTextLineFactory = new StringTextLineFactory();
			strfac.truncationOptions = new TruncationOptions(" ", 1);
			strfac.compositionBounds = new Rectangle(250, 10, 200, 100);
			strfac.text = "이미지를 삽입합니다. 이미지의 소스는 URI를 포함하는 문자열, URLRequest 객체, 포함된 에셋을 나타내는 클래스 객체 또는 DisplayObject 인스턴스일 수 있습니다.\n폭 및 높이 값은 픽셀 수, 퍼센트 또는 그래픽의 실제 크기가 사용된 경우 문자열 'auto'로 나타날 수 있습니다.\nFloat 클래스에 정의된 상수 중 하나로 float을 설정하여 이미지가 텍스트의 왼쪽 또는 오른쪽에 표시되어야 하는지 또는 텍스트와 함께 표시되어야 하는지 여부를 지정합니다.";
			strfac.textFlowFormat = format;
			strfac.createTextLines(createdText);
		}

		private function createdText(line : TextLine) : void {
			addChild(line);
		}
	}
}
