package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import openfl.utils.Assets;
#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var gfVersion:String;
	var validScore:Bool;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var bpm:Int;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var formattedFolder:String = Paths.formatToSongPath(folder);
		var formattedSong:String = Paths.formatToSongPath(jsonInput);

		var daSong:String = Paths.formatToSongPath(formattedFolder + '/' + formattedSong);

		// TODO: make this work with polymod
		if (!Assets.exists(daSong))
		{
			return null;
		}
		var rawJson = Assets.getText(Paths.json(formattedFolder.toLowerCase() + '/' + formattedSong.toLowerCase())).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}
		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		var tempSong = cast swagShit.song; // unsafe cast

		swagShit.validScore = true;

		if (swagShit.gfVersion == null) {
			// old Psych engine charts support
			if (tempSong.player3 != null) {
				swagShit.gfVersion = tempSong.player3;
			}
			// Leather engine charts support
			if (tempSong.gf != null) {
				swagShit.gfVersion = tempSong.gf;
			}
		}

		if (swagShit != null)
			return swagShit;
		else
			return null;
	}
}
