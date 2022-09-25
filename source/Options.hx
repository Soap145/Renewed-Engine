package; // add the folder

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import Controls;

class Options
{
	// REMEMBER TO ADD THE OPTIONS HERE!!!!
	// public static var masterVolume:Float = 1; // unused
	// public static var ghostTap:Bool;
	public static var downscroll:Bool;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var middlescroll:Bool;
	public static var ghostTapping:Bool;
	public static var professionalMode:Bool;
	public static var notePreset:String = "Normal";
	// Saving variable!
	var save = new FlxSave();

	public static function loadOptions()
	{
		if (FlxG.save.data.downscroll != null)
			{downscroll = FlxG.save.data.downscroll;}

		if (FlxG.save.data.middlescroll != null)
			{middlescroll = FlxG.save.data.middlescroll;}

		if (FlxG.save.data.arrowHSV != null)
			{arrowHSV = FlxG.save.data.arrowHSV;}

		if (FlxG.save.data.ghostTapping != null)
			{ghostTapping = FlxG.save.data.ghostTapping;}

		if (FlxG.save.data.professionalMode != null)
			{professionalMode = FlxG.save.data.professionalMode;}

		if (FlxG.save.data.professionalMode != null)
			{professionalMode = FlxG.save.data.professionalMode;}

	}

	public static function saveTheOptions() 
	{
		//gameplay menu
		FlxG.save.data.downscroll;
		FlxG.save.data.middlescroll;
		FlxG.save.data.healthbar;
		FlxG.save.data.botplay;
		FlxG.save.data.player2notes;
		//keybind shit
		FlxG.save.data.upBind;
		FlxG.save.data.downBind;
		FlxG.save.data.leftBind;
		FlxG.save.data.rightBind;
		//modchart menu
		FlxG.save.data.modenabled;
		//arrow colors
		FlxG.save.data.arrowHSV;
		FlxG.save.data.ghostTapping;
		FlxG.save.data.professionalMode;



		FlxG.save.flush();
		FlxG.save.bind('funkin', 'renewed');
		trace("Settings changed!");
	}

}
