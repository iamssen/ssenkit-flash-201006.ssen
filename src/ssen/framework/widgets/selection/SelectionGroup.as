package ssen.framework.widgets.selection {
	import ssen.framework.widgets.selection.events.SelectionEvent;

	import flash.events.EventDispatcher;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SelectionGroup extends EventDispatcher {

		private var _single : ISelectionItem;
		private var _multi : Boolean;
		private var _items : Vector.<ISelectionItem>;

		public function SelectionGroup(multiSelection : Boolean = false) {
			_items = new Vector.<ISelectionItem>();
			_multi = multiSelection;
		}

		public function addItem(item : ISelectionItem) : void {
			_items.push(item);
			if (!_multi && item.selection) {
				if (_single) _single.selection = false;
				_single = item;
			}
		}

		public function get multiSelection() : Boolean {
			return _multi;
		}

		public function set multiSelection(multi : Boolean) : void {
			_multi = multi;
			_single = null;
			var f : int = -1;
			while(++f < _items.length) {
				_items[f].selection = false;
			}
		}

		public function selectedItems() : Vector.<ISelectionItem> {
			var list : Vector.<ISelectionItem> = new Vector.<ISelectionItem>();
			var f : int = -1;
			while(++f < _items.length) {
				if (_items[f].selection) {
					list.push(_items[f]);
					if (!_multi) return list;
				}
			}
			return list;
		}

		public function selection(item : ISelectionItem, selection : Boolean) : void {
			if (!_multi && selection) {
				if (_single) _single.selection = false;
				item.selection = true;
				_single = item;
			} else if (item == _single && !selection) {
				item.selection = false;
				_single = null;
			} else {
				item.selection = selection;
			}
			
			dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION, this));
		}
	}
}
