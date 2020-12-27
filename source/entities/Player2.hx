package entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
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
      //movement function
      function move(elapsed:Float){
        //get the buttons pressed
        up = FlxG.keys.anyPressed([UP]);
        down = FlxG.keys.anyPressed([DOWN]);
        left = FlxG.keys.anyPressed([LEFT]);
        right = FlxG.keys.anyPressed([RIGHT]);
        //cancel out any conflicting button presses
        if (up && down){
          up = down = false;
        }
        if (left && right){
          left = right = false;
        }


        if(up){
          velocity.y = -SPEED;
          facing = FlxObject.UP;
          angle=180;
        }
        if(down){
          velocity.y = SPEED;
          facing = FlxObject.DOWN;
          angle=0;
        }
        if(right){
          velocity.x = SPEED;

          facing = FlxObject.RIGHT;
          angle=270;
          if(up){
            angle-=45;
            velocity.x/=1.5;
            velocity.y/=1.5;
          }else if( down ) {
            angle += 45;
            velocity.x/=1.5;
            velocity.y/=1.5;
          }

        }else if (left){
          velocity.x = -SPEED;

          facing = FlxObject.LEFT;
          angle=90;
          if(up){
            angle+=45;
            velocity.x/=1.5;
            velocity.y/=1.5;
          }else if( down ) {
            angle-=45;
            velocity.x/=1.5;
            velocity.y/=1.5;

          }
        }else{
          velocity.x = 0;
          //animation.play("idle");
        }
      }
      public function ai(thePoint:FlxPoint){
        FlxVelocity.moveTowardsPoint(this, thePoint, SPEED);
      }
    override public function update(elapsed:Float):Void{
      //call the movement function to move
      //move(elapsed);
        super.update(elapsed);


    }
}
