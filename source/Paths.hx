package;

#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var VIDEO_EXT = "mp4";
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, type:AssetType, library:Null<String>)
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

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	static public function video(key:String)
	{
		#if MODS_ALLOWED
		var file:String = modVideo(key);
		if (FileSystem.exists(file))
		{
			return file;
		}
		else
			return 'assets/videos/$key.$VIDEO_EXT';
		#else
		return 'assets/videos/$key.$VIDEO_EXT';
		#end
	}

	inline static public function music(key:String, ?library:String):Dynamic
	{
		var file:Sound = addCustomSound('music', key);
		return file;
	}

	inline static public function voices(song:String):Any
	{
		#if MODS_ALLOWED
		var file:Sound = returnSongFile(modsSongs(song.toLowerCase().replace(' ', '-') + '/Voices'));
		if (file != null)
		{
			return file;
		}
		#end

		return 'songs:assets/songs/${song.toLowerCase().replace(' ', '-')}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String):Any
	{
		#if MODS_ALLOWED
		var file:Sound = returnSongFile(modsSongs(song.toLowerCase().replace(' ', '-') + '/Inst'));
		if (file != null)
		{
			return file;
		}
		#end

		return 'songs:assets/songs/${song.toLowerCase().replace(' ', '-')}/Inst.$SOUND_EXT';
	}

	inline static private function returnSongFile(file:String):Sound
	{
		#if MODS_ALLOWED
		if (FileSystem.exists(file))
		{
			if (!customSoundsLoaded.exists(file))
			{
				customSoundsLoaded.set(file, Sound.fromFile(file));
			}
			return customSoundsLoaded.get(file);
		}
		#end
		return null;
	}

	inline static public function image(key:String, ?library:String):Dynamic
	{
		#if MODS
		var imageToReturn:FlxGraphic = addCustomGraphic(key);
		if (imageToReturn != null)
			return imageToReturn;
		#end

		return getPath('images/$key.png', IMAGE);
	}

	inline static public function font(key:String)
	{
		#if MODS_ALLOWED
		var file:String = modsFont(key);
		if (FileSystem.exists(file))
		{
			return file;
		}
		#end
		return 'assets/fonts/$key';
	}

	inline static public function modTxt(key:String)
	{
		return modFolder('$key.txt');
	}

	inline static public function mods(key:String = '')
	{
		return 'mods/' + key;
	}

	inline static public function modsSongs(key:String)
	{
		return modFolder('songs/' + key + '.' + SOUND_EXT);
	}

	inline static public function modSong(key:String)
	{
		return modFolder(key + '.json');
	}

	inline static public function modsJson(key:String)
	{
		return modFolder('data/' + key + '.json');
	}

	inline static public function modImage(key:String)
	{
		return modFolder('stages/' + key + '.png');
	}

	inline static public function modIcon(key:String)
	{
		return modFolder('images/' + key + '.png');
	}

	inline static public function modsXml(key:String)
	{
		return modFolder('images/' + key + '.xml');
	}

	inline static public function modVideo(key:String)
	{
		return modFolder('videos/' + key + '.' + VIDEO_EXT);
	}

	inline static public function modsFont(key:String)
	{
		return modFolder('fonts/' + key);
	}

	inline static public function modsImages(key:String)
	{
		return modFolder('images/' + key + '.png');
	}

	inline static public function modsPng(key:String)
	{
		return modFolder(key + '.png');
	}


	inline static public function video(key:String, ?library:String)
	{
		trace('assets/videos/$key.mp4');
		return getPath('videos/$key.mp4', BINARY, library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
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

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
