#if hscript

package;

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup.FlxTypedGroup;


class ScriptUtils
{
    public static function createTypedGroup():FlxTypedGroup<Dynamic>
    {
        return new FlxTypedGroup<Dynamic>();
    }
}


#end