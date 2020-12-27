package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import entities.Player;
//import objects.Square;
import objects.Barrel;
//import objects.Door;
import entities.Player2;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.math.FlxPoint;
class PlayState extends FlxState
{
  var map:FlxTilemap;
  var blockMap:FlxTilemap;
  var player:Player;
  var barrels:FlxTypedGroup<Barrel>;
  var itemMap:FlxTilemap;
  var player2:Player2;

//  var door:Door;
    override public function create():Void
    {

      //Create the Map
        map = new FlxTilemap();
        //Block Map
        blockMap = new FlxTilemap();

        //create the Item Map
        itemMap = new FlxTilemap();
        itemMap.loadMapFromCSV("assets/data/map_Barrels.csv","assets/images/BlockSheet.png");
        itemMap.screenCenter();
      //get an array of the tiles coordinates so that I can use them to place Barrels
          barrels = new FlxTypedGroup<Barrel>();
          var barrelLocations:Array<FlxPoint>;
for(i in 1...5){
       barrelLocations = itemMap.getTileCoords(i);
       for(bar in barrelLocations){
         addBarrel(bar,i);
       }
}

          //Add one to all CSV numbers and add a blank initial tile
        map.loadMapFromCSV("assets/data/map.csv","assets/images/TileSheet.png");
        blockMap.loadMapFromCSV("assets/data/map_Blocks.csv","assets/images/BlockSheet.png");
        map.screenCenter();

        blockMap.screenCenter();
        //Set the bounds of the world to the size of the map..... SUPER IMPORTANT
        FlxG.worldBounds.set(map.x, map.y, map.width, map.height);
        player2 = new Player2(50,70);

        //Create the Player
    player = new Player(90,70);
    player.screenCenter();
    //add player to the level
    add(map);
    add(blockMap);
    add(barrels);
      add(player);
      add(player2);
      // bullets = new FlxTypedGroup<Square>(50);
      // add(bullets);
      //make the camera follow the player
      FlxG.camera.follow(player,TOPDOWN,1);

        super.create();
    }
    // function hitBullet(map:FlxTilemap,bullet:Square):Void{
    //   bullets.remove(bullet,true);
    // }
    // function hitEnemy(enemy:Enemy,bullet:Square):Void{
    //   bullets.remove(bullet,true);
    //   enemy.hitByBullet = true;
    //   }
    function shoot(){
      if(FlxG.keys.justPressed.SPACE&&player.barrelStack.length > 0){
      var bColor:Int = player.barrelStack.pop();
      var newBarrel = new Barrel(player.x,player.y,bColor);
      newBarrel.velocity.set(Math.max(200.0,(Math.abs(player.velocity.x)+Math.abs(player.velocity.y)*1.5)),0);
      newBarrel.velocity.rotate(FlxPoint.weak(0, 0), player.angle + 90);

      barrels.add(newBarrel);
      player.SPEED += 25;
      }
    }
    function addBarrel(location:FlxPoint,num:Int){
      barrels.add(new Barrel(location.x,location.y,num));
    }
     function collectBarrel(player:Player,barrel:Barrel){

       player.barrelStack.push(barrel.barrelColor);

      barrels.remove(barrel,true);
      player.SPEED-=25;
      if(player.SPEED <= 50){
        player.SPEED = 50;
      }
      // Main.gems++;

    }
    // function checkPass(player:Player,door:Door){
    //   //go to new level but check first
    //   trace("Go to new level");
    //
    // }
    override public function update(elapsed:Float):Void
    {

    //FlxG.collide(map,player);
    FlxG.collide(blockMap,barrels);
    FlxG.collide(player,barrels,collectBarrel);
    //FlxG.collide(map,bullets,hitBullet);
    //FlxG.collide(enem,bullets,hitEnemy);
    //FlxG.collide(map,enem);
    FlxG.collide(player,blockMap);
    FlxG.collide(player2,blockMap);
    //FlxG.collide(map,door);
  shoot();
        super.update(elapsed);


    }
}
