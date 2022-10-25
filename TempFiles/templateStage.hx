function createBG()
{

	CurState.defaultCamZoom = 0.9;
	var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/stage/stageback'));
	bg.antialiasing = true;
	bg.scrollFactor.set(0.9, 0.9);
	bg.active = false;
	CurState.add(bg);

	var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('backgrounds/stage/stagefront'));
	stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
	stageFront.updateHitbox();
	stageFront.antialiasing = true;
	stageFront.scrollFactor.set(0.9, 0.9);
	stageFront.active = false;
	CurState.add(stageFront);

	var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('backgrounds/stage/stagecurtains'));
	stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
	stageCurtains.updateHitbox();
	stageCurtains.antialiasing = true;
	stageCurtains.scrollFactor.set(1.3, 1.3);
	stageCurtains.active = false;
	
	//add these idiots before the curtains.
	CurState.add(CurState.gf);
	CurState.add(CurState.dad);
	CurState.add(CurState.boyfriend);

	CurState.add(stageCurtains);
	
}