var fastCar;

var grpLimoDancers;

var limo;

var fastCarCanDrive = false;

function createBG()
{
	CurState.defaultCamZoom = 0.90;

	var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('stages/limo/limoSunset'));
	skyBG.scrollFactor.set(0.1, 0.1);
	CurState.add(skyBG);

	var bgLimo:FlxSprite = new FlxSprite(-200, 480);
	bgLimo.frames = Paths.getSparrowAtlas('stages/limo/bgLimo');
	bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
	bgLimo.animation.play('drive');
	bgLimo.scrollFactor.set(0.4, 0.4);
	CurState.add(bgLimo);

	grpLimoDancers = ScriptUtils.createTypedGroup();
	CurState.add(grpLimoDancers);

	for (i in 0...5)
	{
		var dancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
		dancer.scrollFactor.set(0.4, 0.4);
		grpLimoDancers.add(dancer);
	}

	var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('stages/limo/limoOverlay'));
	overlayShit.alpha = 0.5;
	// add(overlayShit);

	// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

	// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

	// overlayShit.shader = shaderBullshit;

	var limoTex = Paths.getSparrowAtlas('stages/limo/limoDrive');

	limo = new FlxSprite(-120, 550);
	limo.frames = limoTex;
	limo.animation.addByPrefix('drive', "Limo stage", 24);
	limo.animation.play('drive');
	limo.antialiasing = true;

	fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('stages/limo/fastCarLol'));
	CurState.add(fastCar);
	
	CurState.add(CurState.gf);

	CurState.add(limo);
	
	CurState.add(CurState.dad);

	CurState.add(CurState.boyfriend);
	
	
	CurState.boyfriend.y -= 220;
	CurState.boyfriend.x += 260;
	
	resetFastCar();
}

function beatHit()
{
	grpLimoDancers.forEach(function(dancer)
	{
		dancer.dance();
	});

	if (FlxG.random.bool(10) && fastCarCanDrive)
		fastCarDrive();
}

function resetFastCar()
{
	fastCar.x = -12600;
	fastCar.y = FlxG.random.int(140, 250);
	fastCar.velocity.x = 0;
	fastCarCanDrive = true;
}

function fastCarDrive()
{
	FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

	fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
	fastCarCanDrive = false;
	new FlxTimer().start(2, function(tmr:FlxTimer)
	{
		resetFastCar();
	});
}