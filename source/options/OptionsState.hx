package options;

import states.MainMenuState;
import backend.StageData;
import options.OptionsStateNex;

import backend.ResetPrefs;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = [
		'Note Colors', 
		'Controls', 
		'Adjust Delay and Combo',
		'Graphics',
	    'Visuals and UI',
	    'Gameplay'
	];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;
	
	var HPref:FlxText;
	var holdT:Float = 0; 
    var holdD:Float = 3.0; 
    var hold:Bool = false;

	override function create() {
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In Psych Settings", null);
		#end 


		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xFF591CC9;
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		var Inst:FlxText = new FlxText(12, FlxG.height - 24, 0, "Press Arrow Right to switch settings menu", 12);
		Inst.scrollFactor.set();
		Inst.setFormat("comic.ttf", 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(Inst);
		HPref = new FlxText(12, FlxG.height - 44, 0, "Hold R to reset preferences", 12);  
		HPref.setFormat("comic.ttf", 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		HPref.scrollFactor.set();
		add(HPref);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '<', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '>', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In Psych Settings", null);
		#end
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		
		
		var Arrow:FlxSprite = new FlxSprite(-100, 100);

        Arrow.loadGraphic(Paths.image("campaign_menu_UI_assets"), true, 100, 100);
        Arrow.animation.add("arrow right", [0], 1, true);
        Arrow.animation.play("idle");
         add(Arrow);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.UI_RIGHT_P) {
             FlxG.switchState(new OptionsStateNex());
		}

		if (FlxG.keys.pressed.R) {
            holdT += elapsed;
            hold = true;

			var remaining = holdD - holdT;
			if (remaining > 0) {
			   HPref.text = "Wait..." + Std.string(Math.round(remaining * 100) / 100) + "s";
			} else {
				if (holdT - elapsed < holdD) { 
					FlxG.sound.play(Paths.sound('confirmMenu'));
					ResetPrefs.apply();
				} else {
					HPref.text = "Prefs Reset!";
				}
			}
        } else {
             if (hold && holdT < holdD) {
             HPref.text = "You need to hold for 3 seconds to reset preferences";
			 FlxG.sound.play(Paths.sound('cancelMenu'));
           }
          holdT = 0;
          hold = false;
        }

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}