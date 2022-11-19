package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
	public var notedata:Int = 0;
	public var animationCount:Int = 24;

	public function new(x:Float, y:Float, Notedata:Int = 0, AnimCount:Int = 24)
	{
		notedata = Notedata;
		animationCount = AnimCount;
		super(x, y);
		frames = Paths.getSparrowAtlas('noteSplashes');
		animation.addByPrefix('note1-0', 'note impact 1  blue', animationCount, false);
		animation.addByPrefix('note2-0', 'note impact 1 green', animationCount, false);
		animation.addByPrefix('note0-0', 'note impact 1 purple', animationCount, false);
		animation.addByPrefix('note3-0', 'note impact 1 red', animationCount, false);
		animation.addByPrefix('note1-1', 'note impact 2 blue', animationCount, false);
		animation.addByPrefix('note2-1', 'note impact 2 green', animationCount, false);
		animation.addByPrefix('note0-1', 'note impact 2 purple', animationCount, false);
		animation.addByPrefix('note3-1', 'note impact 2 red', animationCount, false);
		antialiasing = true;
		setupNoteSplash(x, y, Notedata);
	}

	public function setupNoteSplash(x:Float, y:Float, Notedata:Int = 0, ?int:Int)
	{
		setPosition(x, y);
		alpha = 0.6;
		var da:Null<Int> = int == null ? FlxG.random.int(0, 1) : int;
		animation.play('note' + Notedata + '-' + da, true);
		// animation.curAnim.frameRate += FlxG.random.int(-2, 2);
		updateHitbox();
		offset.set(width * 0.3, height * 0.3);
	}

	override public function update(elapsed:Float)
	{
		if (animation.curAnim.finished)
			kill();
		super.update(elapsed);
	}
}
