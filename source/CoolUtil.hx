package;

import flixel.FlxG;
import lime.utils.Assets;

#if MODS_ALLOWED
import polymod.backends.PolymodAssets;
#end

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function getScore():Int
	{
		return PlayState.songScore;
	}

	public static function blueBalls():Int
	{
		return PlayState.deaths;
	}

    public static function browserLoad(url:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [url]);
		#else
		FlxG.openURL(url);
		#end
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function evenCoolerTextFile(path:String):Array<String>
	{
		#if MODS_ALLOWED
		var daList:Array<String> = sys.io.File.getContent(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
		#else
		return [];
		#end
	}

	#if MODS_ALLOWED
	public static function coolTextFilePolymod(path:String):Array<String>
	{
		var daList:Array<String> = PolymodAssets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}
	#end

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
}
