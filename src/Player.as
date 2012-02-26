package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source = "graphics/overworld/hero_sheet.png")] private var ImgMe:Class;
		[Embed(source = "graphics/overworld/solid_marker.png")] private var ImgTemp:Class;
		[Embed(source = "sound/encounter.mp3")] private var SndEncounter:Class; 
		[Embed(source = "sound/bump.mp3")] private var SndBump:Class;
		
		public var dir:int = 0; // down, up, right, left
		private var can_move:Boolean = true;
		private var my_speed:int = 1;
		private var my_vel:int = 75;
		public var encounterX:int; // store coordinates on last place the player was snapped to grid to prevent freezing
		public var encounterY:int;
		private var timer:int;
		public var solidCheck:Boolean; // running into a solid or not
		
		// for auto movement
		
		public var collide_point:FlxObject;
		public var moving:Boolean;
		private var solids_group:FlxGroup;
		private var tiles_ref:FlxTilemap;
		private var temp:FlxText;
		private var randomEncounter:Number = 0;
		private var mapID:int
		
		public function Player(X:int, Y:int, solid:FlxGroup, tile:FlxTilemap, mydir:int, map:int = 0) 
		{
			super(X, Y);
			loadGraphic(ImgMe, true, false, 16, 16);
			
			dir = mydir;
			mapID = map;
			solidCheck = false;
			
			addAnimation("walk_down", [1, 2, 1, 2], 4);
			addAnimation("walk_up", [3, 4, 3, 4], 4);
			addAnimation("walk_right", [6, 7, 8, 7], 8);
			addAnimation("walk_left", [9, 10, 11, 10], 8);
			
			addAnimation("idle_down", [0]);
			addAnimation("idle_up", [5]);
			addAnimation("idle_right", [7]);
			addAnimation("idle_left", [10]);
			
			collide_point = new FlxSprite(x, y + 16, ImgTemp);
			collide_point.visible = false;
			collide_point.width = 15;
			collide_point.height = 16;
			
			collide_point.solid = true;
			FlxG.state.add(collide_point);
			
			solids_group = solid;
			tiles_ref = tile;
			
			temp = new FlxText(8, 8, 96, "f");
			temp.scrollFactor.x = 0;
			temp.scrollFactor.y = 0;
			temp.color = 0x000000;
			//FlxG.state.add(temp);
		}
		
		override public function update():void
		{
			if (FlxG.keys.CONTROL)
			{
				my_vel = 150;
				solid = false;
			}
			else
			{
				my_vel = 75;
				solid = true;
			}
			
			if (FieldState.freeze == false)
			{
				movement();
			} else
			{
				moving = false;
				velocity.x = 0;
				velocity.y = 0;
			}
			
			if (FieldState.freeze == false && moving == true && FieldState.encounterOn == true && can_move == true)
			{
				if (Math.floor(x) % 8 == 0 && Math.floor(y) % 8 == 0 && solidCheck == false)
				{
					FlxU.seed = .5;
					randomEncounter += 1 + FlxU.random();
					encounterY = y;
					encounterX = x;
				}
				
				if (randomEncounter >= FieldState.encounterRate && Math.floor(x) % 8 == 0 && Math.floor(y) % 8 == 0)
				{
					randomEncounter = 0;
					FieldState.freeze = true;
					x = encounterX;
					y = encounterY;
					FlxG.play(SndEncounter);
					FlxG.fade.start(0xff000000, 1, startBattle);
				}				
			}
			
			animation();
			super.update();
		}
		
		private function round_point():void
		{
			if(velocity.x < 0)
				x = Math.ceil(x);
			else
				x = Math.floor(x);
			
			if(velocity.y < 0)
				y = Math.ceil(y);
			else
				y = Math.floor(y);
		}
		
		private function movement():void
		{			
			if (Math.floor(x) % 8 == 0 && Math.floor(y) % 8 == 0)
			{
				can_move = true;
				x = Math.floor(x);
				y = Math.floor(y);
			}
			else
				can_move = false;
			
			if (can_move)
			{
				if (FlxG.keys.UP && !FlxU.collide(tiles_ref, collide_point))
				{
					moving = true;
					dir = 1;
				}
				else if (FlxG.keys.DOWN && !FlxU.collide(tiles_ref, collide_point))
				{
					moving = true;
					dir = 0;
				}
				else if (FlxG.keys.LEFT && !FlxU.collide(tiles_ref, collide_point))
				{
					moving = true;
					dir = 3;
				}
				else if (FlxG.keys.RIGHT && !FlxU.collide(tiles_ref, collide_point))
				{
					moving = true;
					dir = 2;
				}
				else
				{
					moving = false;
				}
				
				
			}
			
			// another switch statement...
			
			if (moving)
			{
				switch(dir)
				{
					case 0: velocity.y = my_vel; velocity.x = 0; break;
					case 1: velocity.y = -my_vel; velocity.x = 0; break;
					case 2: velocity.y = 0; velocity.x = my_vel; break;
					case 3: velocity.y = 0; velocity.x = -my_vel; break;
				}
			}
			else
			{
				velocity.x = 0;
				velocity.y = 0;
			}
			
		}
		
		private function animation():void
		{
			switch(dir)
			{
				case 0: 
				if (!moving)
					play("idle_down")
				else
					play("walk_down"); 
				break;
				
				case 1: 
				if (!moving)
					play("idle_up")
				else
					play("walk_up"); 
				break;
				
				case 2: 
				if (!moving)
					play("idle_right")
				else
					play("walk_right"); 
				break;
				
				case 3: 
				if (!moving)
					play("idle_left")
				else
					play("walk_left"); 
				break;
				
			}
		}
		
		private function startBattle():void
		{
			StatsTable.startRandomBattle(this);
		}
	}

}