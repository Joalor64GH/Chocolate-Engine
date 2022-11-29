package;

#if LUA_EXTENSION
import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;
#end

import flixel.FlxG;
import flixel.addons.effects.FlxTrail;
import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.filters.BitmapFilter;
import openfl.display.BitmapData;
import openfl.utils.Assets;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import flixel.addons.transition.FlxTransitionableState;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
import Type.ValueType;
import Controls;
import flixel.addons.display.FlxRuntimeShader;

#if hscript
import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
#end

#if desktop
import Discord;
#end

using StringTools;

class FunkinLua
{
    // very wip
    /*https://github.com/Gidk-g/extra-engine/blob/main/source/FunkinLua.hx*/
}