import flixel.FlxG;

// YOU CAN IGNORE THIS
class FlxgShit
{
	/**
	* Simple helper function to update all options to prevent crashes. ngl you could probably run this every frame :troll:
	**/
	static public function updateOptions() {
		FlxG.save.bind('savedata', 'Funky');
		trace(FlxG.save.data.quaverbar);
		var controlsStrings = CoolUtil.coolTextFile(Paths.txt('read'));
		
		var curSelected = 1;
		for (i in 0...controlsStrings.length)
		{
			curSelected = i;
            //ratings
            if (FlxG.save.data.fc == null)
				FlxG.save.data.fc = "FC";
			if (FlxG.save.data.good == null)
				FlxG.save.data.good = "GOOD";
            if (FlxG.save.data.ok == null)
				FlxG.save.data.ok = "OK";
            if (FlxG.save.data.eh == null)
				FlxG.save.data.eh = "EH";
            if (FlxG.save.data.bad == null)
				FlxG.save.data.bad = "BAD";
            if (FlxG.save.data.shit == null)
				FlxG.save.data.shit = "SHIT";
            if (FlxG.save.data.bruh == null)
				FlxG.save.data.bruh = "BRUH";
			if (FlxG.save.data.nohealth == null) {
				FlxG.save.data.nohealth = controlsStrings[curSelected].split(" || ")[2];
			if (FlxG.save.data.flippednotes == null) {
				FlxG.save.data.flippednotes = controlsStrings[curSelected].split(" || ")[2];
				flippednotes = !flippednotes
			
			}
		}
	}
}

