package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

class BGSprite extends FlxSprite
{
	public var idleAnim:String = null;

	override public function new(image:String, x:Float = 0, y:Float = 0, scrollX:Float = 1, scrollY:Float = 1, animations:Array<String> = null,
			loopAnims:Bool = false, ?sprAntialiasing:Bool = false)
	{
		super(x, y);

		if (animations != null)
		{
			// im only using BGSprite for the week 7 stage only, so im adding its library here so it wont be a hassle preloading its assets in the chart editor.
			frames = Paths.getSparrowAtlas(image);
			for (anim in animations)
			{
				animation.addByPrefix(anim, anim, 24, loopAnims);
				animation.play(anim);
				if (idleAnim == null)
					idleAnim = anim;
			}
		}
		else
		{
			loadGraphic(Paths.image(image));
			active = false;
		}
		scrollFactor.set(scrollX, scrollY);
		antialiasing = sprAntialiasing;
	}

	public function dance()
	{
		if (idleAnim != null)
			animation.play(idleAnim);
	}
}
