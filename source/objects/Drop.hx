package objects;

import flixel.FlxSprite;
import flixel.FlxG;

class Drop extends FlxSprite
{


  //add a direction to constructor
    public function new(x:Float,y:Float)
    {
        super(x,y);
        loadGraphic("assets/images/explosionSmoke5.png");

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}
