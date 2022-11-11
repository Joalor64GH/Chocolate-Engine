/*
 * Apache License, Version 2.0
 *
 * Copyright (c) 2022 MemeHoovy, Joalor64 and Wither362
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package;

import modding.ModList;
import modding.PolymodHandler;
import modding.ModsMenuStateOption;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import lime.utils.Assets;

class ModsMenuState extends MusicBeatState
{
	#if MODS_ALLOWED
	var curSelected:Int = 0;

	var page:FlxTypedGroup<ModsMenuStateOption> = new FlxTypedGroup<ModsMenuStateOption>();

	public static var instance:ModsMenuState;

	public static var enabledMods = [];

	public static var coolId:String;
	public static var disableButton:FlxButton;
	public static var enableButton:FlxButton;

	var bgtwo:FlxSprite;
	var bg:FlxSprite;

	var infoText:FlxText;
	var infoTextcool:FlxText;

	override function create()
	{
		var menuBG:FlxSprite;

		if (FlxG.save.data.mousescroll)
		{
			FlxG.mouse.visible = true;
		}

		menuBG = new FlxSprite().loadGraphic(Paths.image('mainmenu/menuDesat'));

		menuBG.color = FlxColor.GRAY;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		infoText = new FlxText(0, 0, 0, "NO MODS INSTALLED!", 12);
		infoText.scrollFactor.set();
		infoText.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.borderSize = 2;
		infoText.screenCenter();
		infoText.visible = false;
		infoText.antialiasing = true;
		add(infoText);

		infoTextcool = new FlxText(340, 340, Std.int(FlxG.width * 0.9), "", 12);
		infoTextcool.scrollFactor.set();
		infoTextcool.setFormat(Paths.font("FridayNightFunkin-Regular.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoTextcool.borderSize = 2;
		infoTextcool.screenCenter(Y);

		super.create();

		PolymodHandler.loadModMetadata();

		add(page);

		loadMods();
		FlxG.mouse.visible = true;
	}

	function loadMods()
	{
		page.forEachExists(function(option:ModsMenuStateOption)
		{
			page.remove(option);
			option.kill();
			option.destroy();
		});

		var optionLoopNum:Int = 0;

		for (modId in PolymodHandler.metadataArrays)
		{
			var modOption = new ModsMenuStateOption(ModList.modMetadatas.get(modId).title, modId, optionLoopNum);
			page.add(modOption);
			optionLoopNum++;
			coolId = modId;
		}

		if (optionLoopNum > 0)
		{
			buildUI();
		}

		infoText.visible = (page.length == 0);
	}

	function buildUI()
	{
		bg = new FlxSprite(0, 0).loadGraphic(Paths.image("UI/default/modbg"));
		// bg.screenCenter(Y);

		bgtwo = new FlxSprite(720, 0).loadGraphic(Paths.image("UI/default/modbg"));
		bgtwo.screenCenter(Y);

		ModsMenuState.enableButton = new FlxButton(bg.x + 1120, 309, "Enable Mod", function()
		{
			page.members[curSelected].Mod_Enabled = true;
			if (!enabledMods.contains(page.members[curSelected].Option_Value))
			{
				enabledMods.push(page.members[curSelected].Option_Value);
			}
			ModList.setModEnabled(page.members[curSelected].Option_Value, page.members[curSelected].Mod_Enabled);
		});

		ModsMenuState.disableButton = new FlxButton(bg.x + 1120, 380, "Disable Mod", function()
		{
			page.members[curSelected].Mod_Enabled = false;
			if (enabledMods.contains(page.members[curSelected].Option_Value))
			{
				enabledMods.remove(page.members[curSelected].Option_Value);
			}
			ModList.setModEnabled(page.members[curSelected].Option_Value, page.members[curSelected].Mod_Enabled);
		});

		enableButton.setGraphicSize(150, 70);
		enableButton.updateHitbox();
		enableButton.color = FlxColor.GREEN;
		enableButton.label.setFormat(Paths.font("pixel.otf"), 12, FlxColor.WHITE);
		enableButton.label.fieldWidth = 135;
		setLabelOffset(enableButton, 5, 22);

		disableButton.setGraphicSize(150, 70);
		disableButton.updateHitbox();
		disableButton.color = FlxColor.RED;
		disableButton.label.setFormat(Paths.font("pixel.otf"), 12, FlxColor.WHITE);
		disableButton.label.fieldWidth = 135;
		setLabelOffset(disableButton, 5, 22);

		add(bgtwo);
		add(infoTextcool);
		add(disableButton);
		add(enableButton);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// a bit ugly but i was in a hurry
		if (page.length > 0)
		{
			infoTextcool.text = ModList.modMetadatas.get(PolymodHandler.metadataArrays[curSelected]).description;
			infoTextcool.visible = true;
			infoTextcool.antialiasing = true;
		}

		if (page.length > 0)
		{
			if (controls.UP_P)
			{
				curSelected--;
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			}

			if (controls.DOWN_P)
			{
				curSelected++;
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			}
		}

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (curSelected < 0)
			curSelected = page.length - 1;

		if (curSelected >= page.length)
			curSelected = 0;

		var bruh = 0;

		for (x in page.members)
		{
			x.Alphabet_Text.targetY = bruh - curSelected;
			bruh++;
		}
	}

	// haxeflixel bro why
	function setLabelOffset(button:FlxButton, x:Float, y:Float)
	{
		for (point in button.labelOffsets)
		{
			point.set(x, y);
		}
	}
	#end
}