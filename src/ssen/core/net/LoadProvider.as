package ssen.core.net {
	import de.polygonal.ds.ArrayedQueue;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLStream;

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class LoadProvider {
		private var _loader : Loader;
		private var _stream : URLStream;
		private var _order : LoadOrder;
		private var _consumer : ILoaderConsumer;
		private var _run : Boolean;
		private var _pause : Boolean;
		private var _queue : ArrayedQueue;

		public function LoadProvider(size : int = 8) {
			_queue = new ArrayedQueue(size);
			_loader = new Loader;
			_stream = new URLStream;
			_stream.addEventListener(Event.COMPLETE, complete);
			_stream.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);
			_stream.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			_stream.addEventListener(ProgressEvent.PROGRESS, progress);
		}

		private function progress(event : ProgressEvent) : void {
			_consumer.progress(event.bytesLoaded / event.bytesTotal);
		}

		private function ioError(event : IOErrorEvent) : void {
			_order.errorMessage = event.text;
			_consumer.reciveFail(_order);
			
			afterSend();
		}

		private function httpStatus(event : HTTPStatusEvent) : void {
			_order.httpStatus = event.status;
		}

		private function complete(event : Event) : void {
			_order.factory.convert(_stream, converted);
		}

		private function converted(data : Object) : void {
			_order.data = data;
			send();
		}

		private function send() : void {
			_consumer.recive(_order);
			
			afterSend();
		}

		private function afterSend() : void {
			if (next()) {
				load();
			} else {
				_run = false;
				_order = null;
				if (_stream.connected) _stream.close();
				_consumer.completeOrders();
				_consumer = null;
			}
		}

		public function enqueue(consumer : ILoaderConsumer) : void {
			_queue.enqueue(consumer);
		}

		public function cancel() : void {
			pause();
			_order = null;
			_consumer = null;
			_queue.clear();
		}

		public function pause() : void {
			if (_run && !_pause) {
				_pause = true;
				if (_stream.connected) _stream.close();
			}
		}

		public function play() : void {
			if (_pause) {
				load();
				_pause = false;
			} else {
				_run = true;
				if (next()) load();
			}
		}

		private function next() : Boolean {
			if (_consumer && _consumer.hasNextOrder) {
				_order = _consumer.order;
				return true;
			} else if (_queue.size() > 0) {
				_consumer = ILoaderConsumer(_queue.dequeue());
				_order = _consumer.order;
				return true;
			}
			return false;
		}

		private function load() : void {
			try {
				_stream.load(_order.req);
			} catch (error : SecurityError) {
				_order.errorMessage = error.message;
				_order.allow = loadAllow;
				_consumer.allow(_order);
			}
		}

		private function loadAllow() : void {
			_stream.load(_order.req);
		}
	}
}
