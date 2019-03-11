package ssen.core {

	/**
	 * @author ssen(i@ssen.name)
	 */
	public class DateX {
		public static function EPOCH_TIME() : Number {
			return new Date.time / 1000;
		}

		public static function EPOCH_TIME2Date(epoch : Number, date : Date = null) : Date {
			if (!date) date = new Date;
			date.time = epoch * 1000;
			return date;
		}
	}
}
