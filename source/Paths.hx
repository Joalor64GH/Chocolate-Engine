package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import haxe.Json;

class Paths
{
	inline public static final SOUND_EXT = #if web "mp3" #else "ogg" #end;
	public static final VIDEO_EXTS = ['mp4', 'webm'];

	public static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static public function file(file:String)
	{
		var path = 'assets/$file';
		if (currentLevel != null && OpenFlAssets.exists('$currentLevel:$path'))
			return '$currentLevel:$path';

		return path;
	}

	inline static public function txt(key:String)
	{
		return file('data/$key.txt');
	}

	inline static public function xml(key:String)
	{
		return file('data/$key.xml');
	}

	inline static public function txtGlobal(key:String)
	{
		return file('$key.txt');
	}

	inline static public function xmlGlobal(key:String)
	{
		return file('$key.xml');
	}

	inline static public function json(key:String)
	{
		return file('data/$key.json');
	}

	inline static public function jsonGlobal(key:String)
	{
		return file('$key.json');
	}

	static public function sound(key:String)
	{
		return file('sounds/$key.$SOUND_EXT');
	}

	inline static public function soundRandom(key:String, min:Int, max:Int)
	{
		return sound(key + FlxG.random.int(min, max));
	}

	inline static public function video(key:String)
	{
		for (i in VIDEO_EXTS)
		{
			var path = 'assets/videos/$key.$i';

			trace(path);
			if (OpenFlAssets.exists(path))
				return path;
		}
		return 'assets/videos/$key.mp4';
	}

	inline static public function music(key:String)
	{
		return file('music/$key.$SOUND_EXT');
	}

	inline static public function voices(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String)
	{
		return file('images/$key.png');
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function locales(key:String)
	{
		return file('locales/$key/languageData.json');
	}

	inline static public function lua(key:String)
	{
		return file('scripts/$key.lua');
	}

	inline static public function luaGlobal(key:String)
	{
		return file('$key.lua');
	}

	inline static public function charJson(key:String)
	{
		return file('characters/$key.json');
	}

	inline static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), file('images/$key.xml'));
	}

	inline static public function getPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), file('images/$key.txt'));
	}
}

#if MODS_ALLOWED
class ModPaths
{
        static final currentLevel:String = Paths.currentLevel;

	static public function file(file:String, ?mod:String)
	{
		var path = "";
		if (mod != null)
			path = 'mods/$mod/$file';
		else
			path = 'mods/$file';
		if (OpenFlAssets.exists(path))
			return path;

		return 'mods';
	}

	private static final SOUND_EXT = Paths.SOUND_EXT;
	private static final VIDEO_EXTS = Paths.VIDEO_EXTS;

	inline static public function modIconImage(key:String, mod:String)
	{
		return file('$mod/_polymod_icon.png', mod);
	}

	inline static public function getModTxt(key:String, ?mod:String)
	{
		return file('data/$key.txt', mod);
	}

	inline static public function getModXml(key:String, mod:String)
	{
		return file('data/$key.xml', mod);
	}

	inline static public function getModGlobalTxt(key:String, ?mod:String)
	{
		return file('$key.txt', mod);
	}

	inline static public function getModGlobalXml(key:String, mod:String)
	{
		return file('$key.xml', mod);
	}

	inline static public function getModJson(key:String, mod:String)
	{
		return file('data/$key.json', mod);
	}

	inline static public function getModGlobalJson(key:String, mod:String)
	{
		return file('$key.json', mod);
	}

	static public function getModSound(key:String, mod:String)
	{
		return file('sounds/$key.$SOUND_EXT', mod);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?mod:String)
	{
		return getModSound(key + FlxG.random.int(min, max), mod);
	}

	inline static public function getModVideo(key:String, mod:String)
	{
		for (i in VIDEO_EXTS)
		{
			var path = 'mods/$mod/videos/$key.$i';

			trace(path);
			if (OpenFlAssets.exists(path))
				return path;
		}
		return 'mods/$mod/videos/$key.mp4';
	}

	inline static public function getModMusic(key:String, mod:String)
	{
		return file('music/$key.$SOUND_EXT', mod);
	}

	inline static public function getModVoices(song:String, mod:String)
	{
		return file('mods/$mod/songs/${song.toLowerCase()}/Voices.$SOUND_EXT', mod);
	}

	inline static public function getModInst(song:String, mod:String)
	{
		return file('mods/$mod/songs/${song.toLowerCase()}/Inst.$SOUND_EXT', mod);
	}

	inline static public function getModImage(key:String, mod:String)
	{
		return file('images/$key.png', mod);
	}

	inline static public function getModFont(key:String, mod:String)
	{
		return file('fonts/$key', mod);
	}

	inline static public function getModLua(key:String, mod:String)
	{
		return file('scripts/$key.lua', mod);
	}

	inline static public function getModGlobalLua(key:String, mod:String)
	{
		return file('$key.lua', mod);
	}

	inline static public function getModCharjson(key:String, mod:String)
	{
		return file('characters/$key.json', mod);
	}

	inline static public function getModLocales(key:String, mod:String)
	{
		return file('locales/$key/languageData.json', mod);
	}

	inline static public function checkMod(mod:String)
	{
		return openfl.utils.Assets.exists('mods/$mod/_polymod_meta.json'); // THIS IS MANDATORY
	}

	inline static public function checkPack(mod:String)
	{
		return openfl.utils.Assets.exists('mods/$mod/_polymod_pack.txt');
	}

	inline static public function getModSparrowAtlas(key:String, ?mod:String)
	{
		return flixel.graphics.frames.FlxAtlasFrames.fromSparrow(getModImage(key, mod), file('images/$key.xml', mod));
	}

	inline static public function getModPackerAtlas(key:String, ?mod:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(getModImage(key, mod), file('images/$key.txt', mod));
	}
}
#end
