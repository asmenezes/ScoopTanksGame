package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class CreditsState extends FlxState{
   var playButton:FlxButton;
    override public function create():Void{
      if (FlxG.sound.music == null || FlxG.sound.music.playing == false)
{
    FlxG.sound.playMusic("assets/music/Analog-Nostalgia.ogg", 1, true);
}
      var disp = new FlxText();
      disp.text = "You Lose!";
      disp.color = FlxColor.RED;
      disp.size = 28;
      disp.screenCenter();
      disp.y -= 100;

      playButton = new FlxButton(0, 0, "Play Again", clickPlay);
      playButton.screenCenter();
      add(disp);
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
