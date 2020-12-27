package objects;

import flixel.FlxSprite;
import flixel.FlxG;


class Barrel extends FlxSprite
{
public var barrelColor:Int;
  public function new(x:Float,y:Float,colorC:Int)
  {
    //get and set colors here
      super(x,y);
      barrelColor = colorC;
      drag.x = drag.y = 400;
      loadGraphic("assets/images/BarrelSheet.png",true,24,24);
      animation.add("only",[barrelColor],1,false,false);
      animation.play("only");

  }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}
