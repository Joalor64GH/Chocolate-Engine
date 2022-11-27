package;

/**
	@author BeastlyGhost
	@see `https://github.com/BeastlyGhost/Forever-Engine-Feather`
**/
typedef LangDataDef =
{
	// MENUS
	var difficulties:Array<String>;
	var personalBest:String;

	// PAUSE MENU
	var pauseScoreTxt:String;
	var resumeSong:String;
	var restartSong:String;
	var gotoOptions:String;
	var exitFreeplay:String;
	var exitMenu:String;
	var deathsText:String;
	// HUD INFO BAR
	var scoreTxt:String;
	var missesTxt:String;
	var chocoTxt:String;
	// OTHER STUFF
	var useCustomFont:Bool;
	var fontPath:String;
	var fontKey:String;
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
		curLang = haxe.Json.parse(Paths.locales('locales/$language/languageData.json'));
	}
}
