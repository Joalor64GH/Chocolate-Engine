package;

/**
	@author BeastlyGhost
	@see `https://github.com/BeastlyGhost/FNF-Funkin-Feather`
**/
#if MODULE_ALLOWED
class ChocoModule extends LLua
{
	public function new(file:String, ?preset:Bool = true)
	{
		super(file, preset);
		traces = false;
	}

	override public function preset():Void
	{
		super.preset();

		// here we set up the built-in imports
		// these should work on *any* script;

		// CLASSES (HAXE)
		set('Type', Type);
		set('Math', Math);
		set('Std', Std);
		set('Date', Date);

		// CLASSES (FLIXEL);
		set('FlxG', flixel.FlxG);
		set('FlxBasic', flixel.FlxBasic);
		set('FlxObject', flixel.FlxObject);
		set('FlxSprite', flixel.FlxSprite);
		set('FlxSound', flixel.system.FlxSound);
		set('FlxSort', flixel.util.FlxSort);
		set('FlxStringUtil', flixel.util.FlxStringUtil);
		set('FlxState', flixel.FlxState);
		set('FlxSubState', flixel.FlxSubState);
		set('FlxText', flixel.text.FlxText);
		set('FlxTimer', flixel.util.FlxTimer);
		set('FlxTween', flixel.tweens.FlxTween);
		set('FlxEase', flixel.tweens.FlxEase);
		set('FlxTrail', flixel.addons.effects.FlxTrail);

		// CLASSES (FUNKIN);
		set('Alphabet', Alphabet);
		set('Character', Character);
		set('Conductor', Conductor);
		set('HealthIcon', HealthIcon);
		set('BabyArrow', PlayState.babyArrow);
		set('Note', Note);
		set('PlayState', PlayState);
		set('Paths', Paths);

		// CLASSES (CHOCOLATE);
		set('Main', Main);
		set('OptionsMenu', OptionsMenu);
		set('Controls', Controls);

		#if windows
		set('platform', 'windows');
		#elseif linux
		set('platform', 'linux');
		#elseif mac
		set('platform', 'mac');
		#elseif android
		set('platform', 'android');
		#elseif html5
		set('platform', 'html5');
		#elseif flash
		set('platform', 'flash');
		#else
		set('platform', 'unknown');
		#end
	}

	public static function initArray(moduleArray:Array<ChocoModule>):Array<ChocoModule>
	{
		// set up the modules folder
		var dirs:Array<Array<String>> = [
			Paths.module('libs'),
			Paths.module('libs/${PlayState.song.name.toLowerCase()}')
		];

		var pushedModules:Array<String> = [];

		for (directory in dirs)
		{
			// it's 2am rn i'm dying give me a break
			var tempExts = ['.lua'];

			for (script in directory)
			{
				for (ext in tempExts)
				{
					if (directory != null && directory.length > 0)
					{
						if (!pushedModules.contains(script) && script != null && script.endsWith(ext))
						{
							moduleArray.push(new ChocoModule(script));
							// trace('new module loaded: ' + script);
							pushedModules.push(script);
						}
					}
				}
			}
		}

		if (moduleArray != null)
		{
			for (i in moduleArray)
				i.call('scriptCreate', []);
		}

		return moduleArray;
	}
}
#end