package;

import openfl.utils.Assets;
import haxe.Json;

typedef SwagStage =
{
	var zoom:Float;
	var gf:Array<Float>;
	var dad:Array<Float>;
	var boyfriend:Array<Float>;
	var camFollowDad:Array<Float>;
	var camFollowBoyfriend:Array<Float>;
}

class Stage
{
	public static function loadJson(stage:String):SwagStage
		return parseJson(Paths.json('stages/' + stage + '/data'));

	public static function parseJson(path:String):SwagStage
	{
		var rawJson:String = '';

		if (Assets.exists(path))
			rawJson = Assets.getText(path);

		return Json.parse(rawJson);
	}
}