package;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class NoteSplash extends FlxSprite
{
	public function new(?fromNote:Int = 0, x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('UI/default/noteSplashes');

		animation.addByPrefix('note1-0', 'note impact 1  blue', 24, false);
		animation.addByPrefix('note2-0', 'note impact 1 green', 24, false);
		animation.addByPrefix('note0-0', 'note impact 1 purple', 24, false);
		animation.addByPrefix('note3-0', 'note impact 1 red', 24, false);
		animation.addByPrefix('note1-1', 'note impact 2 blue', 24, false);
		animation.addByPrefix('note2-1', 'note impact 2 green', 24, false);
		animation.addByPrefix('note0-1', 'note impact 2 purple', 24, false);
		animation.addByPrefix('note3-1', 'note impact 2 red', 24, false);

		if (!PlayState.curStage.startsWith('school'))
		{
			antialiasing = true;
		}

		setupNoteSplash(x, y, fromNote);
	}

	public function setupNoteSplash(x:Float, y:Float, noteData:Int = 0)
	{
		setPosition(x, y);
		alpha = 0.6;

		if (animation.curAnim != null) {
			animation.play("note" + noteData + "-" + FlxG.random.int(0, 1), true);
			animation.finishCallback = function(name) kill();
	
			animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
		}
		updateHitbox();

		offset.set(width * 0.3, height * 0.3);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}