package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class TestState extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var mroptions:Array<String> = ['Option1', 'Option2', 'Option3', 'Option4', 'Option5'];

	private var grpControls:FlxTypedGroup<Alphabet>;
    private var checkboxGroup:FlxTypedGroup<CheckboxThingie>;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

        checkboxGroup = new FlxTypedGroup<CheckboxThingie>();
		add(checkboxGroup);

	    for (i in 0...mroptions.length)
		{
				/*var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i].substring(3) + ': ' + controlsStrings[i + 1], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);*/
				//we hate this

			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, mroptions[i], false, false);
			controlLabel.screenCenter();
			controlLabel.y += (100 * (i - (mroptions.length / 2))) + 50;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!

            var checkbox:CheckboxThingie = new CheckboxThingie(controlLabel.x - 45, controlLabel.y - 45, controlLabel[i].getValue() == true);
            //, controlLabel[i].getValue() == true
            checkbox.sprTracker = controlLabel;
            checkbox.ID = i;
            checkboxGroup.add(checkbox);
		}

		super.create();

		//openSubState(new OptionsSubState());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			//changeBinding();
		}
		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		if (controls.BACK)
			FlxG.switchState(new MainMenuState());
		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		NGio.logEvent('Fresh');
		#end

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

    function reloadCheckboxes() {
		for (checkbox in checkboxGroup) {
			checkbox.daValue = (optionsArray[checkbox.ID].getValue() == true);
		}
	}
}
