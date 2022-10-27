package;

@:include("dwmapi.h")
extern class DwmAPI {
    public static function DwmSetWindowAttribute(handle:Dynamic, attr:Int, attrValue:Int, attrSize:Int):Bool;
}