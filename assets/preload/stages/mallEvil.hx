function createBG()
{
	var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('backgrounds/mallEvil/evilBG'));
	bg.antialiasing = true;
	bg.scrollFactor.set(0.2, 0.2);
	bg.active = false;
	bg.setGraphicSize(Std.int(bg.width * 0.8));
	bg.updateHitbox();
	CurState.add(bg);

	var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('backgrounds/mallEvil/evilTree'));
	evilTree.antialiasing = true;
	evilTree.scrollFactor.set(0.2, 0.2);
	CurState.add(evilTree);

	var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("backgrounds/mallEvil/evilSnow"));
	evilSnow.antialiasing = true;
	CurState.add(evilSnow);
	
	CurState.boyfriend.x += 320;
	CurState.dad.y -= 80;
	
	CurState.add(CurState.gf);
	CurState.add(CurState.dad);
	CurState.add(CurState.boyfriend);

}