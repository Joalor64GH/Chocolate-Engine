package scripting;

// it keeps crashing the game :shrug:
// maybe because there's literally nothing here
import flixel.FlxG;
import PlayState;

class HornyScript extends PlayState
{
	public function onCreate()
	{
		super.onCreate();
	}

	public function onUpdate(elasped:Float)
	{
		elapsed = FlxG.elapsed;
		super.onUpdate(elasped);
	}

	public function onNoteHit()
	{
		super.onNoteHit();
	}

	public function onNoteMiss()
	{
		super.onNoteMiss();
	}

	public function onPlayerDeath()
	{
		super.onPlayerDeath();
	}
}
