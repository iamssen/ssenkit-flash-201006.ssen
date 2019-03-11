package ssen.core.net {
	import ssen.core.MathX;

	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;

	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class MultiFileVariables {
		private var _charSet : String;
		private var _ref : FileReference;
		private var _fieldName : String;
		private var _collection : DataCollection;

		public function MultiFileVariables(charSet : String = "utf-8") {
			_charSet = charSet;
			_ref = new FileReference();
			_ref.addEventListener(Event.SELECT, fileSelect);
			_ref.addEventListener(Event.COMPLETE, fileLoaded);
			_collection = new DataCollection();
		}

		/* *********************************************************************
		 * add types
		 ********************************************************************* */
		public function jpg(fieldName : String, bitmapData : BitmapData, fileName : String = "image.jpg", quality : Number = 50.0) : void {
			var encoder : JPEGEncoder = new JPEGEncoder(quality);
			add(fieldName, encoder.encode(bitmapData), fileName);
		}

		public function png(fieldName : String, bitmapData : BitmapData, fileName : String = "image.png") : void {
			var encoder : PNGEncoder = new PNGEncoder();
			add(fieldName, encoder.encode(bitmapData), fileName);
		}

		public function variable(fieldName : String, value : String) : void {
			var d : Data = new Data();
			d.fieldName = fieldName;
			d.data = value;
			d.type = "var";
			_collection.append(d);
		}

		/* *********************************************************************
		 * file ref
		 ********************************************************************* */
		public function browse(fieldName : String, typeFilter : Array) : void {
			_fieldName = fieldName;
			_ref.browse(typeFilter);
		}

		private function fileSelect(event : Event) : void {
			_ref.load();
		}

		private function fileLoaded(event : Event) : void {
			trace("file loaded");
			add(_fieldName, _ref.data, _ref.name);
		}

		/* *********************************************************************
		 * add and remove
		 ********************************************************************* */
		private function add(fieldName : String, data : ByteArray, fileName : String) : void {
			var d : Data = new Data();
			d.fieldName = fieldName;
			d.data = data;
			d.fileName = fileName;
			d.type = "bytes";
			_collection.append(d);
		}

		public function remove(fieldName : String) : void {
			_collection.remove(fieldName);
		}

		/* *********************************************************************
		 * request flush
		 ********************************************************************* */
		public function flush(request : URLRequest) : void {
			var dic : Dictionary = _collection.dic();
			var content : ByteArray = new ByteArray();
			var boundary : String = getRandomBoundary();
			for each (var data : Data in dic) {
				if (data.type == "var") {
					content.writeUTFBytes('-----------------------------' + boundary + '\r\n');
					content.writeUTFBytes('Content-Disposition: form-data; name="' + data.fieldName + '"\r\n\r\n');
					
					content.writeMultiByte(String(data.data), _charSet);
					content.writeUTFBytes("\r\n");
				} else {
					content.writeUTFBytes('-----------------------------' + boundary + '\r\n');
					content.writeUTFBytes('Content-Disposition: form-data; name="' + data.fieldName + '"; filename="' + data.fileName + '"\r\n');
					content.writeUTFBytes('Content-Type: application/octet-stream\r\n\r\n');
					
					content.writeBytes(ByteArray(data.data), 0, ByteArray(data.data).bytesAvailable);
					content.writeUTFBytes("\r\n");
				}
			}
			content.writeUTFBytes('-----------------------------' + boundary + '\r\nContent-Disposition: form-data; name="Upload"\r\n\r\nSubmit Query\r\n-----------------------------' + boundary + '--\r\n');
			
			request.data = content;
			request.method = URLRequestMethod.POST;
			request.contentType = "multipart/form-data; boundary=---------------------------" + boundary;
		}

		public function deconstruct() : void {
			_ref.removeEventListener(Event.SELECT, fileSelect);
		}

		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function getRandomBoundary() : String {
			var boundary : String = "";
			var f : int = 12;
			while (--f >= 0) {
				boundary += MathX.rand(0, 14).toString(16);
			}
			return boundary;
		}
	}
}

import flash.utils.Dictionary;

internal class DataCollection {
	private var _dic : Dictionary;

	public function DataCollection() {
		_dic = new Dictionary();
	}

	public function append(data : Data) : void {
		_dic[data.fieldName] = data;
	}

	public function remove(fieldName : String) : void {
		delete _dic[fieldName];
	}

	public function deconstruct() : void {
		_dic = null;
	}

	public function dic() : Dictionary {
		return _dic;
	}
}

internal class Data {
	public var fieldName : String;
	public var type : String;
	public var data : Object;
	public var fileName : String;
}
