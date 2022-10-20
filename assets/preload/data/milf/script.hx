function beatHit()
{
	if (CurState.curBeat >= 168 && CurState.curBeat < 200 && CurState.camZooming && FlxG.camera.zoom < 1.35)
	{
		FlxG.camera.zoom += 0.015;
		CurState.camHUD.zoom += 0.03;
	}
}