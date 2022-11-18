package states;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;

class DonateScreenState extends MusicBeatState
{
	var blurb:Array<String> = [
		"your contributions help us",
		"develop the funkiest engine",
		"on this side of the internet",
		"",
		"support the cause",
		"and sub to me on yt"
	];

	override function create()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null){
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('givealittlebitback'), 1, false);
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/menuBG'));
		bg.color = 0xFF4E4E; // this was supposed to be red but it came out orange. oh well
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		var menuItem:FlxSprite = new FlxSprite(0, 520);
		menuItem.frames = tex;
		menuItem.animation.addByPrefix('selected', "donate white", 24);
		menuItem.animation.play('selected');
		menuItem.updateHitbox();
		menuItem.screenCenter(X);
		add(menuItem);
		menuItem.antialiasing = true;

		var textGroup:FlxTypedGroup<Alphabet> = new FlxTypedGroup<Alphabet>();
		add(textGroup);
		for (i in 0...blurb.length)
		{
			var money:Alphabet = new Alphabet(0, 0, blurb[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 120;
			textGroup.add(money);
		}

		#if html5
		var someText:FlxText = new FlxText(0, 684, 0, "(opens my itch.io page in a new tab)");
		#else
		var someText:FlxText = new FlxText(0, 684, 0, "(opens my itch.io page in a browser window)");
		#end
		someText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		someText.updateHitbox();
		someText.screenCenter(X);
		add(someText);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.switchState(new MainMenuState());
		}

		if (controls.ACCEPT)
		{
			CoolUtil.browserLoad(Assets.getText(Paths.txt('donate_button_link')));
		}

		super.update(elapsed);
	}
}
