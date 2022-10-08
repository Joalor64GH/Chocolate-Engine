package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;
// import openfl.utils.Assets as OpenFLAssets;

#if sys
import sys.io.File;
import sys.FileSystem;
import polymod.backends.PolymodAssets;
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
	var validScore:Bool;

	var cutscene:String;
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
		var rawJson:String = "";

		#if sys
		rawJson = PolymodAssets.getText(Paths.json(folder.toLowerCase() + jsonInput.toLowerCase())).trim();
		#else
		rawJson = Assets.getText(Paths.json(folder.toLowerCase() + jsonInput.toLowerCase())).trim();
		#end

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}
		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
