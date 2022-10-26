package modding;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.Json;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenflAssets;

class ModPaths {
    static final currentLevel:String = Paths.currentLevel;

    private static final SOUND_EXT = Paths.SOUND_EXT;

    inline static public function modIconImage(key:String, mod:String){
		return getPath('$mod/_polymod_icon.png', IMAGE, mod);
    }

    inline static public function appendTxt(key:String, ?mod:String){
        return getPath('_append/data/$key.txt',TEXT,mod);
    }

    inline static public function getModTxt(key:String, ?mod:String){
        return getPath('data/$key.txt',TEXT,mod);
    }

    inline static public function getModXml(key:String, mod:String )
    {
        return getPath('data/$key.xml', TEXT,mod);
    }

    inline static public function getModJson(key:String, mod:String){
            return getPath('data/$key.json',TEXT,mod);
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
		trace('mods/$mod/videos/$key.mp4');
		return getPath('videos/$key.mp4', BINARY, mod);
	}

    inline static public function getModWebm(key:String, mod:String)
	{
		trace('mods/$mod/videos/$key.webm');
		return getPath('videos/$key.webm', BINARY, mod);
	}

        inline static public function getModMusic(key:String, mod:String)
	{
		return getPath('music/$key.$SOUND_EXT',MUSIC, mod);
	}

        inline static public function getModVoices(song:String, mod:String)
	{
		trace('Loading VOICES');
		var loadingSong:Bool = true;
		if(loadingSong) {
			trace('Done Loading VOICES!');
			return 'mods/$mod/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';}
		else {
			trace('ERROR Loading INST :c');
			return 'songs:assets/songs/bopeebo/Voices.$SOUND_EXT';}
	}

        inline static public function getModInst(song:String, mod:String)
	{
		trace('Loading INST');
		var loadingSong:Bool = true;
		if(loadingSong) {
			trace('Done Loading INST!');
			return 'mods/$mod/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';}
		else {
			trace('ERROR Loading INST :c');
			return 'songs:assets/songs/bopeebo/Inst.$SOUND_EXT';}
	}
    
        inline static public function getModImage(key:String, mod:String){
		return getPath('images/$key.png', IMAGE, mod);
	}

        inline static public function getModFont(key:String,mod:String)
	{
        return getPath('fonts/$key',BINARY,mod);
	}

    inline static public function getModScripts(key:String, mod:String){
        return getPath('scripts/$key.hx', TEXT,mod);
    }

    inline static public function getModSongScripts(key:String, mod:String){
        return getPath('data/$key.hx', TEXT,mod);
    }

    inline static public function getModStageScripts(key:String, mod:String){
        return getPath('stages/$key.hx', TEXT,mod);
    }

    inline static public function getModCharjson(key:String, mod:String){
        return getPath('characters/$key.json', TEXT,mod);
    }

    inline static public function getModLocales(key:String, mod:String)
    {
        return getPath('locales/$key/languageData.json', TEXT,mod);
    }

    inline static public function getModCutscenes(key:String, mod:String)
    {
        return getPath('cutscenes/$key.json', TEXT,mod);
    }

    static public function getPath(file:String, type:AssetType, ?mod:String)
    {
        var path = "";
        if(mod != null)
            path = 'mods/$mod/$file';
        else
            path = 'mods/$file';
        if(OpenflAssets.exists(path,type))
            return path;

        return 'mods';
    }

    static public function checkMod(mod:String){
        return openfl.utils.Assets.exists('mods/$mod/_polymod_meta.json');
    }

    inline static public function getSparrowAtlas(key:String, ?mod:String)
    {
        return flixel.graphics.frames.FlxAtlasFrames.fromSparrow(getModImage(key, mod), getPath('images/$key.xml', TEXT, mod));
    }

    inline static public function getPackerAtlas(key:String, ?mod:String)
    {
        return FlxAtlasFrames.fromSpriteSheetPacker(getModImage(key, mod), getPath('images/$key.txt', TEXT, mod));
    }
}