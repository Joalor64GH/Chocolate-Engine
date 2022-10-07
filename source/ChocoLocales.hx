package;

/**
    @author BeastlyGhost
**/

typedef LangDataDef =
{
	// MENUS
	var difficulties:Array<String>;
	var personalBest:String;

	// PAUSE MENU
	var resumeSong:String;
	var restartSong:String;
	var exitFreeplay:String;
	var exitMenu:String;
	var exitgame:String;
	var blueballedTxt:String;
	// HUD INFO BAR
	var scoreTxt:String;
	var missTxt:String;
	var chocoTxt:String;
}

/*
	a class used to set up typedefs for Game Localizations
	these are used by the game language option!
 */
class ChocoLocales
{
	public static var curLang:LangDataDef;

	public static function getLocale(language:String = 'english')
	{
		curLang = haxe.Json.parse(Paths.getTextFromFile('locales/$language/languageData.json'));
	}
}