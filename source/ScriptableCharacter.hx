package;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;

using StringTools;

class ScriptableCharacter extends Character
{
    public var script:Script;

    public override function animationExists(animationToCheck:String):Bool 
    {
        return script.CallFunction("animationExists",[animationToCheck]);
    }

    public override function canChangetoAnim(AnimToChange:String):Bool 
    {
        return script.CallFunction("canChangetoAnim",[AnimToChange]);
    }

    public override function getGraphicMidpoint(?point:FlxPoint):FlxPoint 
    {
        return script.CallFunction("getGraphicMidpoint",[point]);
    }

    public override function dance() 
    {
        script.CallFunction("dance");
    }

    public function new(x:Float, y:Float, ?character:String = "bf", ?isActPlayer:Bool = false)
    {
        super(x,y,character,isActPlayer);

        var characterscriptpath:String = Paths.charScript;

        script = new Script(Main.hscriptParser,characterscriptpath,Script.ScriptType.Character);

        Config.AllowInterpStuff(script.hscriptInterp,this);

        script.CallFunction("new",[x,y,character,isActPlayer]);
    }

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);

        script.CallFunction("update",[elapsed]);
    }

    public override function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Bool 
    {
        return script.CallFunction("animationExists",[AnimName,Force,Reversed,Frame]);
    }

}