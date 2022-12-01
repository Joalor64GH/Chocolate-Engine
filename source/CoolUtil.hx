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
	public static var difficultyMap:Map<String, Array<String>> = [ // custom songs difficulties, (WIP!!)
		//'lol' => ['FINALE', 'EXTREME', 'HELL'], // idk man, just fell like doing it
		'default' => ['EASY', 'NORMAL', 'HARD']
	];

	public static var defaultDifficulty:String = 'NORMAL';

	static inline function tosong(s:String):String
		return Paths.formatToSongPath(s);

	public static function difficultyString():String
	{
		if(difficultyExists(PlayState.storyDifficulty, PlayState.SONG.song, false))
			return difficultyMap.get(tosong(PlayState.SONG.song))[PlayState.storyDifficulty].toUpperCase();

		if(difficultyArray[PlayState.storyDifficulty] != null)
			return difficultyArray[PlayState.storyDifficulty].toUpperCase();

		return defaultDifficulty.toUpperCase();
	}
	public static function difficultyFromInt(i:Int, songName:String = ''):String // USE THIS!!
	{
		if(difficultyMap.exists(tosong(songName)) && tosong(songName) != '')
			return difficultyMap.get(tosong(songName))[i].toUpperCase();

		if(difficultyExists(i, songName))
			return difficultyArray[i].toUpperCase();

		return defaultDifficulty.toUpperCase();
	}
	public static function difficultyExists(i:Int, songName:String = '', tryArray:Bool = true):Bool
	{
		if(difficultyMap.exists(tosong(songName))) return (difficultyMap.get(tosong(songName))[i] != null);
		if(tryArray) return (difficultyArray[i] != null);

		return false;
	}

	public static inline function browserLoad(url:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [url]);
		#else
		FlxG.openURL(url);
		#end
	}

	public static inline function getScore():Int
	{
		if(PlayState.instance != null)
			return PlayState.instance.songScore;
		return -1;
	}

	public static inline function blueBalls():Int
	{
		return PlayState.instance.deaths;
	}

	public static inline function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static inline function coolStringFile(path:String):Array<String>
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

	public static inline function numberArray(max:Int, min = 0):Array<Int>
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

	public static function createBG(x:Float = 0, y:Float = 0, path:String, scrollFactor:Float = 1, ?antialiasing:Bool = false, state:FlxState):FlxSprite
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
