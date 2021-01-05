package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;

class MenuState extends FlxState{
   var playButton:FlxButton;
    override public function create():Void{
      trace(FlxG.sound.music);
      if (FlxG.sound.music == null || FlxG.sound.music.playing == false) 
{
    FlxG.sound.playMusic("assets/music/Analog-Nostalgia.ogg", 1, true);
}
      playButton = new FlxButton(0, 0, "Play", clickPlay);
      playButton.screenCenter();
      add(playButton);
        super.create();
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
    function clickPlay(){
      FlxG.sound.pause();

    FlxG.switchState(new PlayState());
}
}
