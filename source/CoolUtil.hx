package;

import flixel.FlxG;
import lime.utils.Assets;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
#if MODS_ALLOWED
import polymod.backends.PolymodAssets;
import sys.FileSystem;
import sys.io.File;
#end
#if sys
import sys.io.File;
import sys.FileSystem;
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
		else if(difficultyArray[PlayState.storyDifficulty] != null)
			return difficultyArray[PlayState.storyDifficulty].toUpperCase();

		return defaultDifficulty.toUpperCase();
	}

	public static function difficultyFromInt(i:Int, songName:String = ''):String // USE THIS!!
	{
		if(difficultyMap.exists(tosong(songName)) && tosong(songName) != '')
			return difficultyMap.get(tosong(songName))[i].toUpperCase();
		else if(difficultyExists(i, songName))
			return difficultyArray[i].toUpperCase();

		return defaultDifficulty.toUpperCase();
	}

	public static function difficultyExists(i:Int, songName:String = '', tryArray:Bool = true):Bool
	{
		if(difficultyMap.exists(tosong(songName))) 
			return (difficultyMap.get(tosong(songName))[i] != null);
		else if(tryArray) 
			return (difficultyArray[i] != null);

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
		return PlayState.instance.deaths;

	inline public static function coolTextFile(path:String):Array<String>
		return FileAssets.exists(path) ? [for (i in Assets.getText(path).trim().split('\n')) i.trim()] : [];

	public static inline function coolStringFile(path:String):Array<String>
		return [for (i in path.trim().split('\n')) i];

	// this is actual source code from VS Null https://gamebanana.com/wips/70592
	// or was
	public static inline function coolerTextFile(path:String, daString:String = ''):String
	{
		#if sys
		if (FileSystem.exists(path))
			daString = File.getContent(path).trim();
		#else
		if (Assets.exists(path))
			daString = Assets.getText(path).trim();
		#end

		return daString;
	}

	public static inline function numberArray(max:Int, min = 0):Array<Int>
		return [for (i in min...max) i];

	inline public static function camLerpShit(ratio:Float)
	{
		return FlxG.elapsed / (1 / 60) * ratio;
	}

	inline public static function createBG(x:Float = 0, y:Float = 0, path:String, scrollFactor:Float = 1, ?antialiasing:Bool = false, state:FlxState):FlxSprite
	{
		var bg:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.image(path));
		bg.scrollFactor.set(scrollFactor, scrollFactor);
		bg.antialiasing = antialiasing;
		state.add(bg);
		return bg;
	}

	inline public static function sortNotes(theOrder:Int, obj1:Note, obj2:Note):Int
		return FlxSort.byValues(theOrder, obj1.strumTime, obj2.strumTime);
}
