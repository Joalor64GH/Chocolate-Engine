package;

import lime.app.Application;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class LoadingScreen extends MusicBeatState {

    var loadingBG:FlxSprite;
    var rotatingColor:FlxColor = FlxColor.fromRGB(255, 192, 192);
    var hue:Float = 0;
    public override function new() {
        super();
    }
    public override function create() {
        super.create();
        loadingBG = new FlxSprite(0, 0).loadGraphic(Paths.image("loadingscreen"));
        loadingBG.velocity.set(-410 / 4, -390 / 4);
        add(loadingBG);

        trace(Application.current.window); // need it for DwmSetWindowAttribute

        @:privateAccess
        var handle = Application.current.window.__backend.handle;
        windows.DwmAPI.DwmSetWindowAttribute(handle, 20, 1, 32);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        loadingBG.x = loadingBG.x % -410;
        loadingBG.y = loadingBG.y % -390;
        rotatingColor.hue = hue = (hue + (elapsed * 130 / 2)) % 360;
        loadingBG.color = rotatingColor;
    }
}
 6  
source/DwmAPI.hx
@@ -0,0 +1,6 @@
package windows;

@:include("dwmapi.h")
extern class DwmAPI {
    public static function DwmSetWindowAttribute(handle:Dynamic, attr:Int, attrValue:Int, attrSize:Int):Bool;
}