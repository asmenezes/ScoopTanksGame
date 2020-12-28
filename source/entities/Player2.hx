package entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.math.FlxAngle;
class Player2 extends FlxSprite
{
var SPEED:Int = 175;

var up:Bool = false;
var down:Bool = false;
var left:Bool = false;
var right:Bool = false;

    public function new(x:Float = 0,y:Float = 0){
      //Have to call super first
      super(x,y);
      //Load the sprite sheet
      loadRotatedGraphic("assets/images/tank_darkLarge.png",8);

      //name of anim, frames to play, loops?, flip x?, flip y?


      //set max velocities
      maxVelocity.x = maxVelocity.y = 300;
      // Set drag
      drag.x = drag.y = Main.DRAG;
      //elasticity == bounciness, 1 is full bounce
      elasticity = .1;
      }

      public function ai(thePoint:FlxPoint){
        angle=FlxAngle.angleBetweenPoint(this,thePoint,true) + 270;
        FlxVelocity.moveTowardsPoint(this, thePoint, SPEED);
      }
    override public function update(elapsed:Float):Void{
      //call the movement function to move
      //move(elapsed);
        super.update(elapsed);


    }
}
