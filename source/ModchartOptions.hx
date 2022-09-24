package; // add the folder

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxGradient;
import flixel.addons.display.FlxBackdrop;
import Options;

class ModchartOptions extends MusicBeatState
{
	var textMenuItems:Array<String> = [
        "Modcharts"
	];  // Menu Settings here!

	var descTex:FlxText;
	var statusTex:FlxText;

	var curSelected:Int = 0;
	var save = new FlxSave();
	public static var instance:ModchartOptions;

	var optionText:Alphabet;
	var grpOptionsTexts:FlxTypedGroup<Alphabet>;
    var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);

	public function new()
	{
		super();

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGMagenta'));
		// controlsStrings = CoolUtil.coolTextFile(Paths.txt('controls'));
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

        FlxG.sound.playMusic(Paths.music('normalMenu'));

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55AE59E4, 0xAA19ECFF], 1, 90, true);
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0, 0.07);





		FlxG.save.bind('funkin', 'renewed');
		instance = this;

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
			// optionText = new Alphabet(0, (70 * i) + 30, textMenuItems[i], true, false); // make textMenuItems display.
			// optionText.isMenuItem = true; // is a menu item?
			// optionText.targetY = i;
			// optionText.ID = i; // the id.
			/*optionText = new Alphabet(0, 0, textMenuItems[i], true, false);
			optionText.screenCenter(X);
			optionText.y += (i * 100) + 350;
			optionText.targetY = i;
			optionText.ID = i;
			grpOptionsTexts.add(optionText);*/
            var optionText:Alphabet = new Alphabet(0, (70 * i) + 30, textMenuItems[i], true, false);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			grpOptionsTexts.add(optionText);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !
		}

		descTex = new FlxText(5, 0, 0, "", 26);
		descTex.setFormat(Paths.font("vcr.ttf"), 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descTex.scrollFactor.set();
		descTex.borderSize = 2;
		descTex.antialiasing = true;
		add(descTex);
		descTex.screenCenter(Y);
		descTex.y += 244;

		statusTex = new FlxText(5, 0, 0, "", 26);
		statusTex.setFormat(Paths.font("vcr.ttf"), 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		statusTex.scrollFactor.set();
		statusTex.borderSize = 2;
		statusTex.antialiasing = true;
		add(statusTex);
		statusTex.screenCenter(Y);
		statusTex.y += 324;
	}

	override function update(elapsed:Float)
	{
        
		super.update(elapsed);

        checker.x -= 0.45;
		checker.y -= 0.16;

		FlxG.mouse.visible = false;

		if (controls.UP_P)
		{
			curSelected -= 1;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (controls.DOWN_P)
		{
			curSelected += 1;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;
		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;
	
		for (item in grpOptionsTexts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

		if (item.targetY == 0)
		{
			item.alpha = 1;
		}
		}

		grpOptionsTexts.forEach(function(txt:Alphabet)
		{
			switch (textMenuItems[curSelected]) 
			{
                case "Modcharts":
					descTex.text = "Disable modcharts (this can be disabled by the developer).";
					if (FlxG.save.data.modenabled)
						statusTex.text = "Disabled";
					else if (FlxG.save.data.modenabled)
						statusTex.text = "Enabled";
			}
		});

		if (controls.BACK)
			{
				//save.close();
              //  FlxG.save.close();
				//save.flush();
                save.flush();
                trace("Saved on something");
                trace(FlxG.save.data.middlescroll);
				Options.saveTheOptions();
				FlxG.switchState(new MainOptions());
			}

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				// The Options go here!
                case "Downscroll": // Downscroll.
                if (!FlxG.save.data.modenabled)
                {
                    FlxG.save.data.modenabled = true;
                    trace ("Modcharts Turned On!");
                }
                else
                {
                    FlxG.save.data.modenabled = false;
                    trace ("Modcharts Turned Off!");
                }
			}
		}
	}
}