package;

import openfl.text.TextField;
import openfl.text.TextFormat;

class DateTime extends TextField
{
	var minutes:String;
	var hours:String;
	var calendar:Calendar = Calendar.instance;
	var curDate:Date = Date.now();

	public override function new(x:Float = 0, y:Float = 0, color:Int = 0xFFFFFF)
	{
		this.x = x;
		this.y = y;
		super();
		mouseEnabled = false;
		selectable = false;
		defaultTextFormat = new TextFormat("_sans", 12, Std.parseInt(Std.string(color)));
	}

	private override function __update(transformOnly:Bool, updateChildren:Bool)
	{
		super.__update(transformOnly, updateChildren);

		minutes = '0' + Std.string(curDate.getMinutes());
		if (curDate.getMinutes() >= 10)
		{
			minutes = Std.string(curDate.getMinutes());
		}
		hours = '0' + Std.string(curDate.getHours());
		if (curDate.getHours() >= 10)
		{
			hours = Std.string(curDate.getHours());
		}
		var time:String = curDate.getHours() <= 11 ? 'AM' : 'PM';
		text = 'Time: ' + hours + ':' + minutes + ' ' + time + '\nDate: ' + calendar.getMonth() + ' ' + curDate.getDate() + ', ' + curDate.getFullYear() 
			+ '\nDay: ' + calendar.getDay();
	}
}