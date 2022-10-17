package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
	public var texture(default, set):Dynamic = null;

	public function new(x:Float, y:Float, noteData:Int = 0)
	{
		super(x, y);

		texture = Paths.getSparrowAtlas('UI/default/noteSplashes');

		setupNoteSplash(x, y, noteData);
	}

	private function reloadAssets():Void
	{
		frames = texture;
		animation.addByPrefix('note1-1', 'note impact 1  blue', 24, false);
		animation.addByPrefix('note2-1', 'note impact 1 green', 24, false);
		animation.addByPrefix('note0-1', 'note impact 1 purple', 24, false);
		animation.addByPrefix('note3-1', 'note impact 1 red', 24, false);
		animation.addByPrefix('note1-2', 'note impact 2 blue', 24, false);
		animation.addByPrefix('note2-2', 'note impact 2 green', 24, false);
		animation.addByPrefix('note0-2', 'note impact 2 purple', 24, false);
		animation.addByPrefix('note3-2', 'note impact 2 red', 24, false);
	}

	public function setupNoteSplash(x:Float, y:Float, noteData:Int = 0)
	{
		setPosition(x, y);

		offset.set(width * 0.3, height * 0.3);
		alpha = 0.6;

		animation.play('note' + noteData + '-' + FlxG.random.int(1, 2), true);

		if (animation.curAnim != null)
			animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	override public function update(elapsed:Float)
	{
		if (animation.curAnim != null && animation.curAnim.finished)
			kill();

		super.update(elapsed);
	}

	private function set_texture(value:Dynamic):Dynamic
	{
		if (texture != value)
		{
			texture = value;
			reloadAssets();
		}

		return value;
	}
}