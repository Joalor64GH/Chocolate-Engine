/*
 * Apache License, Version 2.0
 *
 * Copyright (c) 2022 MemeHoovy
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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

// are we seriously gonna fucking use psych engine code?
// y'all need to learn how to code smh
// sorry, I was & am pretty grumpy when writing this
class FunkinLua
{
    #if LUA_EXTENSION
    public var lua:State = null;
    #end

    #if hscript
	public var hscript:HScript;
	#end

    // screw it, I'm tired of being useless and doing nothing
    public function new(){
        lua = LuaL.newstate();
		LuaL.openlibs(lua);
		Lua.init_callbacks(lua);
    }

    inline public function stop(){
        #if LUA_EXTENSION
        Lua.close(lua);
        lua = null;
        #else
        return;
        #end
    }
}

#if hscript
class HScript 
{
    public var parser:Parser;
    public var interp:Interp;

    public function new(){
        parser = new Parser();
        interp = new Interp();
    }

    inline public function setVar(name:String, value:Dynamic):Void {
        return interp.variables.set(name, value);
    }

    inline public function getVar(name:String):Dynamic {
        return interp.variables.get(name);
    }

    inline public function exists(name:String){
        return interp.variables.exists(name);
    }

    // IT'S NOT WORKINGGGGGGGGGGGGGGGGGGGGGGGGGGGG
    /*public function call(function:String, ?parameters:Array<Dynamic>):Dynamic {
		var pissCum:Dynamic = executeFunc(func, parameters, this);
		if (pissCum == null)
			return 0;
		return pissCum;
    }*/

    //Credit: nebulazorua
    public function executeFunc(func:String, ?parameters:Array<Dynamic>, ?theObject:Any, ?extraVars:Map<String,Dynamic>):Dynamic
	{
		if (extraVars == null)
			extraVars=[];
		if (exists(func))
		{
			var daFunc = getVar(func);
			if (Reflect.isFunction(daFunc))
			{
				var returnVal:Any = null;
				var defaultShit:Map<String,Dynamic>=[];
				for (key in extraVars.keys()){
					defaultShit.set(key, getVar(key));
					setVar(key, extraVars.get(key));
				}
				try
				{
					returnVal = Reflect.callMethod(theObject, daFunc, parameters);
				}
				catch (e:haxe.Exception)
				{
                    #if sys
					Sys.println(e.message);
                    #else
                    // haxe.Log.trace(e.message, e.stack);
                    lime.utils.Log.println(e.message);
                    #end
				}
				for (key in defaultShit.keys())
				{
					setVar(key, defaultShit.get(key));
				}
				return returnVal;
			}
		}
		return null;
	}
}
#end