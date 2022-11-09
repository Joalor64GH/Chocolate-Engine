package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

#if polymod
import polymod.backends.PolymodAssets;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;

	private var iconArray:Array<HealthIcon> = [];

	/*private var playbackRate(default, set):Float = 1;

	function set_playbackRate(v:Float):Float
	{
		if (FlxG.sound.music.playing){
			FlxG.sound.music.pitch = v;
		}

		if (v < 1)
			return 1;
		else if (v > 3)
			return 3;
		else
			return v;
	}*/

	private var playbackRateText:FlxText;

	override function create()
	{
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		if (Assets.exists(Paths.txt('freeplaySonglist')))
		{
			initSonglist = Assets.getText(Paths.txt('freeplaySonglist')).trim().split('\n');

			for (i in 0...initSonglist.length)
			{
				initSonglist[i] = initSonglist[i].trim();
			}
		}

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
		}

		// I'm gonna temporarily comment this out since it's causing freeplay to crash
		/*#if MODS_ALLOWED
			try {
				var modSonglist = CoolUtil.coolTextFile(modding.ModPaths.appendTxt('_append/data/freeplaySonglist'));

				if (Assets.exists(modding.ModPaths.appendTxt('_append/data/freeplaySonglist')))
				{
					modSonglist = Assets.getText(modding.ModPaths.appendTxt('_append/data/freeplaySonglist')).trim().split('\n');

					for (i in 0...modSonglist.length)
					{
						modSonglist[i] = modSonglist[i].trim();
					}
				}

				for (i in 0...modSonglist.length)
				{
					var data:Array<String> = modSonglist[i].split(':');
					songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
				}
			} catch (e:Dynamic){
				throw e;
			}
			#end */

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);

		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		playbackRateText = new FlxText(scoreText.x, scoreText.y + 56, 0, "", 24);
		playbackRateText.font = scoreText.font;
		add(playbackRateText);

		add(scoreText);

		changeSelection();
		changeDiff();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);

		if (controls.LEFT_P && FlxG.keys.pressed.CONTROL)
			changePlaybackRate(-1);
		if (controls.RIGHT_P && FlxG.keys.pressed.CONTROL)
			changePlaybackRate(1);

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		playbackRateText.text = 'Playback Rate: ' + Conductor.playbackRate;

		if (accepted)
		{
			var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);

			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			PlayState.storyWeek = songs[curSelected].week;
			trace('CUR WEEK' + PlayState.storyWeek);
			LoadingState.loadAndSwitchState(new PlayState());
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficultyArray.length - 1;
		if (curDifficulty >= CoolUtil.difficultyArray.length)
			curDifficulty = 0;

		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);

		diffText.text = CoolUtil.difficultyArray[curDifficulty].toUpperCase();
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);

		#if PRELOAD_ALL
		FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
		FlxG.sound.music.pitch = Conductor.playbackRate;
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
	}

	function changePlaybackRate(value:Float) {
		if (value < 1) 
			return CoolUtil.setPlaybackRate(1);
		else if (value > 3)
			return CoolUtil.setPlaybackRate(3);
		else if (Math.isNaN(value))
			return CoolUtil.setPlaybackRate(1);
		else
			return CoolUtil.setPlaybackRate(value);
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
