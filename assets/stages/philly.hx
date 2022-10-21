var phillyCityLights;

var phillyCityLights;
var phillyTrain;
var trainSound;
var startedMoving;
var trainMoving = false;
var trainFrameTiming:Float = 0.00; //i dont think hscript cares about types.. ugh
var trainCars = 8;
var trainFinishing = false;
var trainCooldown = 0;
var startedMoving = false;

function createBG()
{
	var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('backgrounds/philly/sky'));
	bg.scrollFactor.set(0.1, 0.1);
	bg.antialiasing = true;
	
	CurState.add(bg);

	var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('backgrounds/philly/city'));
	city.scrollFactor.set(0.3, 0.3);
	city.setGraphicSize(Std.int(city.width * 0.85));
	city.updateHitbox();
	city.antialiasing = true;
	CurState.add(city);

	phillyCityLights = ScriptUtils.createTypedGroup();

	for (i in 0...5)
	{
		var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('backgrounds/philly/win' + i));
		light.scrollFactor.set(0.3, 0.3);
		light.visible = false;
		light.setGraphicSize(Std.int(light.width * 0.85));
		light.updateHitbox();
		light.antialiasing = true;
		phillyCityLights.add(light);
	}
	
	CurState.add(phillyCityLights);

	var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('backgrounds/philly/behindTrain'));
	CurState.add(streetBehind);

	phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('backgrounds/philly/train'));
	CurState.add(phillyTrain);

	trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
	FlxG.sound.list.add(trainSound);

	// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

	var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('backgrounds/philly/street'));
	CurState.add(street);
	street.antialiasing = true;
	streetBehind.antialiasing = true;
	phillyTrain.antialiasing = true;
	
	
	CurState.add(CurState.gf);
	
	CurState.add(CurState.dad);

	CurState.add(CurState.boyfriend);
}

function update(elapsed)
{
	if (trainMoving)
	{
		trainFrameTiming += elapsed;

		if (trainFrameTiming >= 1 / 24)
		{
			updateTrainPos();
			trainFrameTiming = 0;
		}
	}
}

function beatHit()
{
	if (!trainMoving)
		trainCooldown += 1;

	if (CurState.curBeat % 4 == 0)
	{
		phillyCityLights.forEach(function(light:FlxSprite)
		{
			light.visible = false;
		});

		curLight = FlxG.random.int(0, phillyCityLights.length - 1);

		phillyCityLights.members[curLight].visible = true;
		// phillyCityLights.members[curLight].alpha = 1;
	}

	if (CurState.curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
	{
		trainCooldown = FlxG.random.int(-4, 0);
		trainStart();
	}
}

function trainStart()
{
	trainMoving = true;
	if (!trainSound.playing)
		trainSound.play(true);
}

function updateTrainPos()
{
	if (trainSound.time >= 4700) //WHY THE FUCK DOESN'T THE GOD DAMN TRAIN WORK
	{
		startedMoving = true;
		CurState.gf.playAnim('hairBlow');
	}

	if (startedMoving)
	{
		phillyTrain.x -= 400;

		if (phillyTrain.x < -2000 && !trainFinishing)
		{
			phillyTrain.x = -1150;
			trainCars -= 1;

			if (trainCars <= 0)
				trainFinishing = true;
		}

		if (phillyTrain.x < -4000 && trainFinishing)
			trainReset();
	}
}

function trainReset():Void
{
	CurState.gf.playAnim('hairFall');
	phillyTrain.x = FlxG.width + 200;
	trainMoving = false;
	// trainSound.stop();
	// trainSound.time = 0;
	trainCars = 8;
	trainFinishing = false;
	startedMoving = false;
}