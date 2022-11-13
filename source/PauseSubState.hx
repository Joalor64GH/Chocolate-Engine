package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = ['Resume', 'Restart Song', 'Options', 'Exit to freeplay', 'Exit to main menu'];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;

	var levelInfo:FlxText;
	var levelDifficulty:FlxText;
	var curScore:FlxText;
	var deaths:FlxText;

	var difficultyChoices:Array<String> = ['EASY', 'NORMAL', 'HARD', 'BACK'];

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		levelInfo = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		levelDifficulty = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		curScore = new FlxText(20, levelDifficulty.y + 32, 0, "", 32);
		curScore.text += "SCORE: " + CoolUtil.getScore();
		curScore.scrollFactor.set();
		curScore.setFormat(Paths.font('vcr.ttf'), 32);
		curScore.updateHitbox();
		add(curScore);

		deaths = new FlxText(20, curScore.y + 32, 0, "", 32);
		deaths.text += "Blue balled: " + CoolUtil.blueBalls();
		deaths.scrollFactor.set();
		deaths.setFormat(Paths.font('vcr.ttf'), 32);
		deaths.updateHitbox();
		add(deaths);

		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;
		curScore.alpha = 0;
		deaths.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		curScore.x = FlxG.width - (curScore.width + 20);
		deaths.x = FlxG.width - (deaths.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(curScore, {alpha: 1, y: curScore.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
		FlxTween.tween(deaths, {alpha: 1, y: deaths.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.9});

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

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

		if (accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Resume":
					close();
				case "Restart Song":
					FlxG.resetState();
				case "Options":
					FlxG.switchState(new OptionsMenu());
				case "Exit to freeplay":
					FlxG.switchState(new FreeplayState());
				case "Exit to menu":
					if (PlayState.isStoryMode)
						FlxG.switchState(new StoryMenuState());
					else
						FlxG.switchState(new MainMenuState());
			}
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
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
}
