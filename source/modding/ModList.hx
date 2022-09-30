package modding;

#if MODS_ALLOWED
import polymod.Polymod;
import flixel.FlxG;

class ModList
{
	public static var modList:Map<String, Bool> = new Map<String, Bool>();

	public static var modMetadatas:Map<String, ModMetadata> = new Map();

	public static function setModEnabled(mod:String, enabled:Bool):Void
	{
		modList.set(mod, enabled);
		FlxG.save.data.modList = modList;
		FlxG.save.flush();
	}

	public static function getModEnabled(mod:String):Bool
	{
		if (!modList.exists(mod))
			setModEnabled(mod, false);

		return modList.get(mod);
	}

	public static function getActiveMods(modsToCheck:Array<String>):Array<String>
	{
		var activeMods:Array<String> = [];

		for (modName in modsToCheck)
		{
			if (getModEnabled(modName))
				activeMods.push(modName);
		}

		return activeMods;
	}

	public static function load():Void
	{
		if (FlxG.save.data.modList != null)
			modList = FlxG.save.data.modList;
	}
}
#end