package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import haxe.Json;

using StringTools;

class Paths
{
	inline public static final SOUND_EXT = #if web "mp3" #else "ogg" #end;
	public static final VIDEO_EXTS = ['mp4', 'webm'];
	inline public static final SCRIPT_EXT = "lua";

	public static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, ?type:AssetType, library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, ?type:AssetType, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function video(key:String, ?library:String)
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

	inline static public function music(key:String, ?library:String, type:AssetType = MUSIC)
	{
		return getPath('music/$key.$SOUND_EXT', type, library);
	}

	inline static public function voices(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function locales(key:String, ?library:String)
	{
		return getPath('locales/$key/languageData.json', TEXT, library);
	}

	inline static public function cutscene(key:String, ?library:String, type:AssetType = TEXT)
	{
		return getPath('cutscenes/$key.json', type, library);
	}

	inline static public function lua(key:String, ?library:String)
	{
		return getPath('$key.SCRIPT_EXT', TEXT, library);
	}

	inline static public function charJson(key:String, ?library:String)
	{
		return getPath('characters/$key.json', TEXT, library);
	}
	
	inline static public function formatToSongPath(path:String) {
		var invalidChars = ~/[~&\\;:<>#]/;
		var hideChars = ~/[.,'"%?!]/;

		var path = invalidChars.split(path.replace(' ', '-')).join("-");
		return hideChars.split(path).join("").toLowerCase();
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}

#if MODS_ALLOWED
class ModPaths
{
	static final currentLevel:String = Paths.currentLevel;

	private static final SOUND_EXT = Paths.SOUND_EXT;
	private static final VIDEO_EXTS = Paths.VIDEO_EXTS;
	private static final SCRIPT_EXT = Paths.SCRIPT_EXT;

	inline static public function modIconImage(key:String, mod:String)
	{
		return getPath('$mod/_polymod_icon.png', IMAGE, mod);
	}

	inline static public function getModTxt(key:String, ?mod:String)
	{
		return getPath('$key.txt', TEXT, mod);
	}

	inline static public function getModXml(key:String, mod:String)
	{
		return getPath('data/$key.xml', TEXT, mod);
	}

	inline static public function getModJson(key:String, mod:String)
	{
		return getPath('data/$key.json', TEXT, mod);
	}

	static public function getModSound(key:String, mod:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, mod);
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
		return getPath('music/$key.$SOUND_EXT', MUSIC, mod);
	}

	inline static public function getModVoices(song:String, mod:String)
	{
		trace('Loading VOICES');
		var loadingSong:Bool = true;
		if (loadingSong)
		{
			trace('Done Loading VOICES!');
			return 'mods/$mod/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
		}
		else
		{
			trace('ERROR Loading INST :c');
			return 'songs:assets/songs/bopeebo/Voices.$SOUND_EXT';
		}
	}

	inline static public function getModInst(song:String, mod:String)
	{
		trace('Loading INST');
		var loadingSong:Bool = true;
		if (loadingSong)
		{
			trace('Done Loading INST!');
			return 'mods/$mod/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
		}
		else
		{
			trace('ERROR Loading INST :c');
			return 'songs:assets/songs/bopeebo/Inst.$SOUND_EXT';
		}
	}

	inline static public function getModImage(key:String, mod:String)
	{
		return getPath('images/$key.png', IMAGE, mod);
	}

	inline static public function getModFont(key:String, mod:String)
	{
		return getPath('fonts/$key', BINARY, mod);
	}

	inline static public function getModLua(key:String, mod:String)
	{
		return getPath('$key.SCRIPT_EXT', TEXT, mod);
	}

	inline static public function getModCharjson(key:String, mod:String)
	{
		return getPath('characters/$key.json', TEXT, mod);
	}

	inline static public function getModLocales(key:String, mod:String)
	{
		return getPath('locales/$key/languageData.json', TEXT, mod);
	}

	inline static public function getModCutscenes(key:String, mod:String)
	{
		return getPath('cutscenes/$key.json', TEXT, mod);
	}

	static public function getPath(file:String, type:AssetType, ?mod:String)
	{
		var path = "";
		if (mod != null)
			path = 'mods/$mod/$file';
		else
			path = 'mods/$file';
		if (OpenFlAssets.exists(path, type))
			return path;

		return 'mods';
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
		return flixel.graphics.frames.FlxAtlasFrames.fromSparrow(getModImage(key, mod), getPath('images/$key.xml', TEXT, mod));
	}

	inline static public function getModPackerAtlas(key:String, ?mod:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(getModImage(key, mod), getPath('images/$key.txt', TEXT, mod));
	}
}
#end