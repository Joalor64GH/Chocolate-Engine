var halloweenBG;

var lightningStrikeBeat = 0;
var lightningOffset = 8;

function createBG()
{
	var hallowTex = Paths.getSparrowAtlas('stages/spooky/halloween_bg');

	halloweenBG = new FlxSprite(-200, -75);
	halloweenBG.frames = hallowTex;
	halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
	halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
	halloweenBG.animation.play('idle');
	halloweenBG.antialiasing = true;
	CurState.add(halloweenBG);
	
	CurState.add(CurState.gf);
	
	CurState.add(CurState.dad);

	CurState.add(CurState.boyfriend);

}

function beatHit()
{
	if (FlxG.random.bool(10) && CurState.curBeat > lightningStrikeBeat + lightningOffset)
	{
		lightningStrikeShit();
	}
}

function lightningStrikeShit()
{
	FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
	halloweenBG.animation.play('lightning');

	lightningStrikeBeat = CurState.curBeat;
	lightningOffset = FlxG.random.int(8, 24);

	CurState.boyfriend.playAnim('scared', true);
	CurState.gf.playAnim('scared', true);
}