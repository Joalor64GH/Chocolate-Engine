package;

import flixel.FlxG;
import lime.utils.Assets;
import flixel.FlxSprite;
import flixel.FlxState;
#if MODS_ALLOWED
import polymod.backends.PolymodAssets;
import sys.FileSystem;
import sys.io.File;
#end
import flixel.util.FlxSort;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', 'NORMAL', 'HARD'];

	public static var defaultDifficulty:String = 'NORMAL';

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static function browserLoad(url:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [url]);
		#else
		FlxG.openURL(url);
		#end
	}

	public static inline function getScore():Int
	{
		return PlayState.instance.songScore;
	}

	public static inline function blueBalls():Int
	{
		return PlayState.instance.deaths;
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

	public static function coolStringFile(path:String):Array<String>
	{
		var daList:Array<String> = path.trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	// this is actual source code from VS Null https://gamebanana.com/wips/70592
	public static inline function coolerTextFile(path:String, daString:String = ''):String
	{
		#if MODS_ALLOWED
		if (FileSystem.exists(path))
			daString = File.getContent(path).trim();
		#else
		if (Assets.exists(path))
			daString = Assets.getText(path).trim();
		#end

		return daString;
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

	public static function numberArray(max:Int, min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static function camLerpShit(ratio:Float)
	{
		return FlxG.elapsed / (1 / 60) * ratio;
	}

	public static function createBG(x:Float, y:Float, path:String, scrollFactor:Float = 1, ?antialiasing:Bool = false, state:FlxState):FlxSprite
	{
		var bg:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.image(path));
		bg.scrollFactor.set(scrollFactor, scrollFactor);
		bg.active = false;
		bg.antialiasing = antialiasing;
		state.add(bg);
		if (bg != null)
			return bg;
		else
			return null;
	}

	inline public static function sortNotes(theOrder:Int, obj1:Note, obj2:Note):Int
	{
		return FlxSort.byValues(theOrder, obj1.strumTime, obj2.strumTime);
	}
}
