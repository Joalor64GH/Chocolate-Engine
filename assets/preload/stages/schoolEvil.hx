function createBG()
{
	var posX = 400;
	var posY = 200;

	var bg:FlxSprite = new FlxSprite(posX, posY);
	bg.frames = Paths.getSparrowAtlas('stages/schoolEvil/animatedEvilSchool');
	bg.animation.addByPrefix('idle', 'background 2', 24);
	bg.animation.play('idle');
	bg.scrollFactor.set(0.8, 0.9);
	bg.scale.set(6, 6);
	CurState.add(bg);
	
	CurState.boyfriend.x += 200;
	CurState.boyfriend.y += 220;
	CurState.gf.x += 180;
	CurState.gf.y += 300;
	
	CurState.add(CurState.gf);
	CurState.add(CurState.dad);
	CurState.add(CurState.boyfriend);
}