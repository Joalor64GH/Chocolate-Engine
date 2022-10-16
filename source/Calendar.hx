package;

class Calendar
{
	public static var instance:Calendar;

	public var shortName:Bool = false;

	public function getDay()
	{
		var days:Array<String> = new Array<String>();
		if (shortName)
		{
			days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
		}
		else
		{
			days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
		}
		return days[Date.now().getDay()];
	}

	public function getMonth()
	{
		var months:Array<String> = new Array<String>();
		if (shortName)
		{
			months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
		}
		else
		{
			months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		}
		return months[Date.now().getMonth()];
	}
}