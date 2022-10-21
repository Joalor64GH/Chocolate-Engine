package;

import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import haxe.Exception;
import lime.system.System;
import flixel.system.debug.log.Log;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.util.FlxColor;
import haxe.Json;
import lime.utils.Assets;
import hscript.Interp;
import hscript.Parser;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Config
{
    public static function AllowInterpStuff(interp:Interp, ?me:Dynamic)
    {
        interp.variables.set("Math",Math);
        interp.variables.set("PlayState",PlayState);
        interp.variables.set("PauseSubState",PauseSubState);
        interp.variables.set("FlxEase",FlxEase);
        interp.variables.set("FlxTween",FlxTween);
        interp.variables.set("Note",Note);
        interp.variables.set("FlxG",FlxG);
        interp.variables.set("Paths",Paths);
        interp.variables.set("CoolUtil",CoolUtil);
        interp.variables.set("FlxSprite",FlxSprite);
        interp.variables.set("CurState",FlxG.state);
        interp.variables.set("Std",Std);
        interp.variables.set("FlxSound",FlxSound);
        interp.variables.set("FlxTimer",FlxTimer);
        interp.variables.set("ScriptUtils",ScriptUtils);
        interp.variables.set("this",me);

        //stupid
        interp.variables.set("BackgroundDancer",BackgroundDancer);
        interp.variables.set("BackgroundGirls",BackgroundGirls);
    }
}