package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import entities.Player;
import objects.Drop;
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
  var dropOff:Drop;
  var camFollow:FlxObject;
//  var door:Door;
    override public function create():Void
    {
      camFollow = new FlxObject(0,0);
      //Create the Dropoff
      dropOff = new Drop(50,50);
      dropOff.screenCenter();
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
    player2.screenCenter();
    player2.y += 500;
    //add player to the level
    add(map);
    add(blockMap);
    add(barrels);
    add(dropOff);
      add(player);
      add(player2);
      add(camFollow);
      // bullets = new FlxTypedGroup<Square>(50);
      // add(bullets);
      //make the camera follow the player
      FlxG.camera.follow(camFollow,TOPDOWN,1);

        super.create();
    }
    function hitDrop(drop:Drop,barrel:Barrel):Void{
      barrels.remove(barrel,true);
      checkWin();
    }
    function checkWin():Void{
      if(barrels.length <= 0 && player.barrelStack.length <= 0){
        FlxG.switchState(new MenuState());
      }
    }
    // function hitEnemy(enemy:Enemy,bullet:Square):Void{
    //   bullets.remove(bullet,true);
    //   enemy.hitByBullet = true;
    //   }
    function shoot(){
      if(FlxG.keys.justPressed.SPACE&&player.barrelStack.length > 0){
      var bColor:Int = player.barrelStack.pop();
      var newBarrel = new Barrel(player.x,player.y,bColor);
      newBarrel.velocity.set(Math.max(300.0,(Math.abs(player.velocity.x)+Math.abs(player.velocity.y)*1.5)),0);
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
      camFollow.x = (player.x+player2.x)/2;
      camFollow.y = (player.y+player2.y)/2;
      player2.ai(player.getMidpoint());
    //FlxG.collide(map,player);
    FlxG.collide(blockMap,barrels);
    FlxG.collide(player,barrels,collectBarrel);
    FlxG.collide(dropOff,barrels,hitDrop);
    //FlxG.collide(enem,bullets,hitEnemy);
    //FlxG.collide(map,enem);
    FlxG.collide(player,blockMap);
    FlxG.collide(player2,blockMap);
  if(FlxG.collide(player2,player)){
    FlxG.switchState(new MenuState());
  };
    //FlxG.collide(map,door);
    shoot();

        super.update(elapsed);


    }
}
