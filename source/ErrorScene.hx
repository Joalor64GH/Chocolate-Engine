package;

import Controls.Control;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.Lib;
import flixel.FlxState;

class ErrorScene extends FlxState
{
    public var DisplayText:FlxText;

	public function new(str:String)
	{
        super();
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        DisplayText = new FlxText(0, 0, FlxG.width, "Error!\n" + str + "\nPress enter to continue.", 32);
        DisplayText.setFormat(Paths.font("vcr.ttf"), 54, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);

        add(DisplayText);

        FlxG.sound.playMusic(Paths.music('freakyMenu'), 1);
	}

    public override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new MainMenuState());
        }
    }

}