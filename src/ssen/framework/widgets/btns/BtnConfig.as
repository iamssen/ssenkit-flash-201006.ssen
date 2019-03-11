package ssen.framework.widgets.btns {
	import ssen.core.draw.material.IDrawMaterialSet;
	import ssen.core.draw.material.ITextFormatSet;
	import ssen.core.geom.Padding;
	import ssen.framework.widgets.selection.SelectionGroup;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BtnConfig {
		public var width : int;
		public var height : int;
		public var material : IDrawMaterialSet;
		public var interaction : BtnInteraction;

		public function BtnConfig(width : int = 100, height : int = 30, material : IDrawMaterialSet = null, interaction : BtnInteraction = null) {
			this.width = width;
			this.height = height;
			this.material = material;
			this.interaction = interaction;
		}

		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		public function clear() : void {
			material = null;
			interaction = null;
			lableTextFormats = null;
			lableTextPadding = null;
			selectionGroup = null;
			selectionValue = null;
		}

		/* *********************************************************************
		 * lable 
		 ********************************************************************* */
		public var lableText : String = "button";
		public var lableTextFormats : ITextFormatSet;
		public var lableTextPadding : Padding;

		public function lableConfig(text : String = "button", textFormats : ITextFormatSet = null, textPadding : Padding = null) : void {
			lableText = text;
			lableTextFormats = textFormats;
			lableTextPadding = textPadding;
		}

		/* *********************************************************************
		 * advanced click 
		 ********************************************************************* */
		public var doubleClickTime : int = 200;
		public var longDownEnable : Boolean = false;
		public var longDownTime : int = 4000;

		public function clickConfig(doubleClickTime : int = 200, longDownEnable : Boolean = false, longDownTime : int = 4000) : void {
			this.doubleClickTime = doubleClickTime;
			this.longDownEnable = longDownEnable;
			this.longDownTime = longDownTime;
		}

		/* *********************************************************************
		 * selection 
		 ********************************************************************* */
		public var selection : Boolean = false;
		public var selectionGroup : SelectionGroup;
		public var selectionValue : Object;

		public function selectionConfig(group : SelectionGroup, selection : Boolean = false, value : Object = null) : void {
			this.selectionGroup = group;
			this.selection = selection;
			this.selectionValue = value;
		}

		/* *********************************************************************
		 * toggle 
		 ********************************************************************* */
		public var toggle : Boolean;

		public function toggleConfig(toggle : Boolean = false) : void {
			this.toggle = toggle;
		}
	}
}
