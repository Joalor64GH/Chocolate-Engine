function beatHit()
{
	if (CurState.curBeat % 8 == 7)
	{
		CurState.boyfriend.playAnim('hey', true);
	}
}