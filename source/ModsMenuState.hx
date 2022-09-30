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

import flixel.FlxState;
import sys.FileSystem; // this is only for desktop so...
import polymod.Polymod.Framework;
import polymod.Polymod.PolymodError;
import flixel.FlxG;
import Controls;

class ModsMenuState extends FlxState
{
    var curSelected:Int = 0;
    #if polymod
    var NoMods:String = "No mods are installed.";
    #else
    var NoMods:String = "Polymod is not installed or not enabled.";
    #end

    var modDirectory:Array<String> = [];
    var mods = sys.FileSystem.readDirectory("mods");

    for (mod in mods){
        if (sys.FileSystem.isDirectory("mods/" + mod))
        {
            modDirectory.push(mod);
        }
        trace('Mods loaded:' + mod);
    }

    override public function create()
    {
        var placeholder:FlxText = new FlxText(0,0,FlxG.width,'Unfinished.',24);
        add(placeholder);
        super.create();
    }

    override public function update(elapsed:Float){
        super.update(elapsed);
        if (controls.BACK){
            FlxG.switchState(new MainMenuState());
            FlxG.sound.play(Paths.sound('cancelMenu'));
        }
    }
}