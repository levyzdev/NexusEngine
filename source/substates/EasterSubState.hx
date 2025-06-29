package substates;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxVideo;

import states.MainMenuState;

#if windows
import cpp.Lib;
#end

class EasterSubState extends FlxState
{
    var video:FlxVideo;

    override public function create():Void
    {
        super.create();
        
        #if DISCORD_ALLOWED
        DiscordClient.changePresence("ronaldo ronaldo ronaldo ronaldo ronaldo", null);
        #end


        FlxG.sound.music.stop();

        video = new FlxVideo();
        video.play(Paths.video('m'));
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            video.dispose();
            FlxG.sound.music.play();
            FlxG.switchState(new MainMenuState());
        }
    }

}
