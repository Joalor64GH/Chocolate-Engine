#if hscript

package;

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.addons.transition.FlxTransitionableState;

class Script //give every script its own interpreter so no variable conflicts!!!!
{
    public static var functionBlacklist:Map<ScriptType,Array<String>> = [
        ScriptType.Basic => [],
        ScriptType.Stage => []
    ];

    public var hscriptInterp:Interp = new Interp();
    public var hscriptCurScript:Expr;
    public var type:ScriptType = ScriptType.Basic;

    public function new(parser:Parser, script:String, ?tp:ScriptType = ScriptType.Basic)
    {
        try 
        {
            hscriptCurScript = parser.parseString(script);
        }
        catch(e)
        {
            FlxTransitionableState.skipNextTransIn = true;
		    FlxTransitionableState.skipNextTransOut = true;
            FlxG.switchState(new ErrorScene(e.message));
        }
        Config.AllowInterpStuff(hscriptInterp);
        hscriptInterp.errorHandler = Script.ErrorHandler;
        hscriptInterp.execute(hscriptCurScript);
        type = tp;
    }

    public static function ErrorHandler(e:hscript.Error)
    {
        var errorstring:String = "";
        #if hscriptPos
        errorstring = e.toString();
        #else
            errorstring = "Error Type:" + e.getName();
        #end
        FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
        FlxG.switchState(new ErrorScene(errorstring));
    }

    public function CallFunction(funcName:String, ?args:Array<Dynamic>):Dynamic
    {
        if (hscriptInterp.variables.get(funcName) == null)
        {
            return null;
        }
        var output:Dynamic = null;
        try
        {
            output = Reflect.callMethod(null,hscriptInterp.variables.get(funcName),args);//hscriptInterp.variables.get(funcName)(args);
        }
        catch(e)
        {
            FlxTransitionableState.skipNextTransIn = true;
            FlxTransitionableState.skipNextTransOut = true;
            FlxG.switchState(new ErrorScene(e.message));
        }
        return output;
    }

}

enum ScriptType
{
    Basic; Stage;
}

#end