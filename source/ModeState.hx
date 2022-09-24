package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

// do i know how to code YES

class ModeState extends MusicBeatState
{
	var songs:Array<String> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

    //start shit
	var drunk:FlxText;
    var snake:FlxText;
    var flipped:FlxText;
    var strum:FlxText;
    //shit done
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

    var drunkit:String = 'false';
    var snakeit:String = 'false';
    var flipit:String = 'false';
    var strumit:String = 'false';

    var controlsStrings = CoolUtil.coolTextFile(Paths.txt('read'));

	override function create()
	{
		songs = ['Drunk Notes', 'Snake Notes', 'Flipped Notes', 'Show Only Strums'];

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end


		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i], true, false);
			songText.screenCenter();
			songText.y += (100 * (i - (songs.length / 2))) + 50;
			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

        drunk = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		drunk.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

        snake = new FlxText(FlxG.width * 0.7, 39, 0, "", 32);
		snake.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

        flipped = new FlxText(FlxG.width * 0.7, 70, 0, "", 32);
		flipped.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

        strum = new FlxText(FlxG.width * 0.7, 100, 0, "", 32);
		strum.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

        //text shit
        drunk.text = 'Drunk Notes:' + drunkit;
        snake.text = 'Snake Notes:' + snakeit;
        flipped.text = 'Flipped Notes:' + flipit;
        strum.text = 'Show Strums:' + strumit;

		var scoreBG:FlxSprite = new FlxSprite(drunk.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.65), 150, 0xFF000000);
		scoreBG.alpha = 0.6;

        //fuck
        if (FlxG.save.data.drunknotes == null)
            FlxG.save.data.drunknotes = controlsStrings[curSelected].split(" || ")[2];
        if (FlxG.save.data.snakenotes == null)
            FlxG.save.data.snakenotes = controlsStrings[curSelected].split(" || ")[2];
        if (FlxG.save.data.flipednotes == null)
            FlxG.save.data.flipednotes = controlsStrings[curSelected].split(" || ")[2];
        if (FlxG.save.data.strumnotes == null)
            FlxG.save.data.strumnotes = controlsStrings[curSelected].split(" || ")[2];

        //we add shit
		add(scoreBG);
        add(drunk);
        add(snake);
        add(flipped);
        add(strum);

		changeSelection();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}


	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

        if (FlxG.save.data.drunknotes)
            drunkit = 'true';
            drunk.text = 'Drunk Notes:' + drunkit;
        if (FlxG.save.data.snakenotes)
            snakeit = 'true';
            snake.text = 'Snake Notes:' + snakeit;
        if (FlxG.save.data.flipednotes)
            flipit = 'true';
            flipped.text = 'Flipped Notes:' + flipit;
        if (FlxG.save.data.strumnotes)
            strumit = 'true';
            strum.text = 'Show Strums:' + strumit;

		drunk.text = 'Drunk Notes:' + drunkit;
		snake.text = 'Snake Notes:' + snakeit;
		flipped.text = 'Flipped Notes:' + flipit;
		strum.text = 'Show Strums:' + strumit;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.switchState(new PauseSongState());
		}

        if (controls.ACCEPT)// funni changg stuf
			{
				//refeshing the text
				remove(drunk);
				add(drunk);
				remove(snake);
				add(snake);
				remove(flipped);
				add(flipped);
				remove(strum);
				add(strum);
                if (FlxG.save.data.drunknotes)
                    drunkit = 'true';
                    drunk.text = 'Drunk Notes:' + drunkit;
                if (FlxG.save.data.snakenotes)
                    snakeit = 'true';
                    snake.text = 'Snake Notes:' + snakeit;
                if (FlxG.save.data.flipednotes)
                    flipit = 'true';
                    flipped.text = 'Flipped Notes:' + flipit;
                if (FlxG.save.data.strumnotes)
                    strumit = 'true';
                    strum.text = 'Show Strums:' + strumit;
				
				switch (songs[curSelected])
				{
					case 'Drunk Notes':
						FlxG.save.data.drunknotes = !FlxG.save.data.drunknotes;
                    case 'Snake Notes':
                        FlxG.save.data.snakenotes = !FlxG.save.data.snakenotes;
                    case 'Flipped Notes':
                        FlxG.save.data.flipednotes = !FlxG.save.data.flipednotes;
                    case 'Show Only Strums':
                        FlxG.save.data.strumnotes = !FlxG.save.data.strumnotes;
				}
			}

	}

	function changeSelection(change:Int = 0)
	{

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpSongs.members)
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
}

