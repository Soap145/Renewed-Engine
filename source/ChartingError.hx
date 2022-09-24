import Conductor.BPMChangeEvent;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import haxe.Json;
import lime.utils.Assets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.media.Sound;
import openfl.net.FileReference;
import openfl.utils.ByteArray;

using StringTools;

class ChartingError extends MusicBeatState
{
	var UI_box:FlxUITabMenu;

	override function create()
	{
		var tabs = [
			{name: "Error 104", label: 'Error 104'}
		];

        var tab_group_section = new FlxUI(null, UI_box);
		tab_group_section.name = 'Error 104';

		UI_box = new FlxUITabMenu(null, tabs, true);

		UI_box.resize(200, 200);
		UI_box.x = 50;
		UI_box.y = 60;
		add(UI_box);

        var yes:FlxButton = new FlxButton(10, 130, "Yes", function()
        {
            FlxG.switchState(new ChartingState());
        });

        var no:FlxButton = new FlxButton(10, 200, "No", function()
        {
            FlxG.switchState(new MainMenuState());
        });

        tab_group_section.add(yes);
		tab_group_section.add(no);

        UI_box.addGroup(tab_group_section);
    }
}