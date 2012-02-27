package  
{
	import flash.utils.ByteArray;
	import org.flixel.*;
	
	public class FieldState extends FlxState
	{
		[Embed(source = "graphics/overworld/tilesheet.png")] private var ImgTiles:Class;
		[Embed(source = "graphics/menu/message_box.png")] private var ImgMsg:Class;
		[Embed(source = "graphics/menu/dialog_cursor.png")] private var ImgCsr:Class;
		
		[Embed(source = "sound/menu.mp3")] private var SndMenu:Class;
		
		public static var timer:int = 0;
		
		public static var freeze:Boolean;
		public static var encounterRate:int;
		public static var encounterList:Array;
		public static var encounterDifficulty:Array; // average level, deviation 
		public static var encounterOn:Boolean;
		public static var grid_x:int = 0;
		public static var grid_y:int = 0; // location of the player on the flip screen grid
		private var mwidth:int;
		private var mheight:int;
		private var current_map:String;
		private var p_x:int;
		private var p_y:int;
		private var p_dir:int;
		public static var map_id:int;

		private var camera_timer:int;
		private var camera_x:int = 0;
		private var camera_y:int = 0;
		private var camera:Camera;
		private var tempCounter:FlxText;
		
		private var msg_text:FlxText;
		
		// objects
		
		private var p:Player;
		private var tiles:FlxTilemap;
		private var mbox:FlxSprite;
		private var d_cursor:FlxSprite;
		
		private var solids:FlxGroup;
		private var teleporters:FlxGroup;
		private var message_box:FlxGroup;
		
		// embed all the maps... dear god
		
		[Embed(source = "graphics/map/town_1.txt", mimeType = "application/octet-stream")] private var mTown1:Class;
		[Embed(source = "graphics/map/town_2.txt", mimeType = "application/octet-stream")] private var mTown2:Class;
		[Embed(source = "graphics/map/town_1_interior.txt", mimeType = "application/octet-stream")] private var mTown1_interior:Class;
		[Embed(source = "graphics/map/region_1.txt", mimeType = "application/octet-stream")] private var mRegion1:Class;
		[Embed(source = "graphics/map/hub_dungeon.txt", mimeType = "application/octet-stream")] private var mHub_Dungeon:Class;
		[Embed(source = "graphics/map/hub_tunnel.txt", mimeType = "application/octet-stream")] private var mHub_Tunnel:Class;
		
		// embed songs
		
		[Embed(source = "music/town.mp3")] private var SngTown:Class;
		[Embed(source = "music/town_2.mp3")] private var SngTown2:Class;
		[Embed(source = "music/overworld.mp3")] private var SngWorld:Class;
		[Embed(source = "music/cave_2.mp3")] private var SngCave:Class;
		
		public function FieldState(px:int = 64, py:int = 64, mapid:int = 0, pdir:int = 0, specialEventType:int = 0):void
		{
			p_x = px;
			p_y = py;
			p_dir = pdir;
			
			map_id = mapid;
			
		}
		
		override public function create():void
		{
			freeze = true; // no movement while loading
			
			map_to_string();
			
			tiles = new FlxTilemap();
			tiles.loadMap(current_map, ImgTiles, 16, 16);
			tiles.collideIndex = 112;
			add(tiles);
			
			solids = new FlxGroup();
			teleporters = new FlxGroup();
			message_box = new FlxGroup();
			
			p = new Player(p_x, p_y, solids, tiles, p_dir, map_id);
			add(p);
			
			add(solids);
			add(teleporters);
			add(message_box);
			
			message_box.visible = false;
			
			msg_text = new FlxText(4, 116, 152);
			
			mbox = new FlxSprite(0, 0, ImgMsg);
			d_cursor = new FlxSprite(0, 0);
			d_cursor.loadGraphic(ImgCsr, true);
			
			message_box.add(mbox);
			message_box.add(msg_text);
			message_box.add(d_cursor);
			
			// determine the camera's quadrant
			
			for (var i:int = 0; i < p.x + 8; i += 160)
				camera_x = i;
			for (i = 0; i < p.y + 8 ; i += 144)
				camera_y = i;
				
			camera = new Camera(camera_x, camera_y);
			add(camera);
			
			
			FlxG.followBounds(camera.coord_x, camera.coord_y, camera.coord_x + 160, camera.coord_y + 144);
			FlxG.follow(camera);
			
			map_properties();
			populate_map();
			play_music();
			
			freeze = false;
		}
		
		private function gotoMenu():void
		{
			FlxG.state = new MenuState(p.x, p.y, map_id);
		}
		
		override public function update():void
		{
			StatsTable.PlayTime += FlxG.elapsed;
			
			super.update();
			
			if (timer > 0)
			{
				timer -= FlxG.elapsed;
				freeze = true;
				timer = Math.max(timer, 0);
			}
			
			if (tiles.collide(p) || solids.collide(p))
			{
				p.solidCheck = true
			}
			else
			{
				p.solidCheck = false;
			}
			
			if (FlxG.keys.pressed("X") && p.x % 8 == 0 && p.y % 8 == 0 && freeze == false)
			{
				freeze = true;
				timer = 15;
				FlxG.play(SndMenu);
				FlxG.fade.start(0xff000000, .35, gotoMenu);
			}
			
			
			if (freeze == false && p.moving == true)
			{
				if (p.x > camera.coord_x + 160)
				{
					camera.coord_x += 160;
					//FlxG.followBounds(camera.coord_x, camera.coord_y, camera.coord_x + 160, camera.coord_y + 144);
				}
				if (p.x < camera.coord_x)
				{
					camera.coord_x -= 160;
					//FlxG.followBounds(camera.coord_x, camera.coord_y, camera.coord_x + 160, camera.coord_y + 144);
				}
				if (p.y > camera.coord_y + 144)
				{
					camera.coord_y += 144;
					//FlxG.followBounds(camera.coord_x, camera.coord_y, camera.coord_x + 160, camera.coord_y + 144);
				}
				if (p.y < camera.coord_y)
				{
					camera.coord_y -= 144;
					//FlxG.followBounds(camera.coord_x, camera.coord_y, camera.coord_x + 160, camera.coord_y + 144);
				}
			}
			
			if (camera_timer > 0)
			{
				camera_timer -= FlxG.elapsed / 2;
				//FlxG.follow(camera, 1);
				
				if (camera_timer <= 0)
				{
					camera_timer = 0;
					//FlxG.follow(camera, 40);
				}
			}
						
		}
		
		private function map_to_string():void
		{
			switch(map_id)
			{
				case 0: current_map = (new mTown1 as ByteArray).toString(); mwidth = 30 * 16; mheight = 27 * 16; break;
				case 1: current_map = (new mTown1_interior as ByteArray).toString(); mwidth = 40 * 16; mheight = 27 * 16; break;
				case 2: current_map = (new mRegion1 as ByteArray).toString(); mwidth = 100 * 16; mheight = 90 * 16; break;
				case 3: current_map = (new mHub_Dungeon as ByteArray).toString(); mwidth = 70 * 16; mheight = 63 * 16; break;
				case 4: current_map = (new mTown2 as ByteArray).toString(); mwidth = 30 * 16; mheight = 27 * 16; break;
				case 5: current_map = (new mHub_Tunnel as ByteArray).toString(); mwidth = 40 * 16; mheight = 36 * 16; break;
			}
		}
		
		private function populate_map():void
		{
			var temp:FlxObject;
			switch(map_id)
			{
				case 0: 
				teleporters.add(new Teleporter(6 * 16, 4 * 16, 1, 1, 1, 4 * 16, 7 * 16, p));
				teleporters.add(new Teleporter(25 * 16, 5 * 16, 1, 1, 1, 34 * 16, 7 * 16, p)); 
				teleporters.add(new Teleporter(5 * 16, 10 * 16, 1, 1, 1, 25 * 16, 7 * 16, p));
				teleporters.add(new Teleporter(24 * 16, 14 * 16, 1, 1, 1, 24 * 16, 16 * 16, p));
				teleporters.add(new Teleporter(6 * 16, 21 * 16, 1, 1, 1, 12 * 16, 25 * 16, p));
				teleporters.add(new Teleporter(14 * 16, -1 * 16, 2, 2, 2, 94 * 16, 88 * 16, p));
				solids.add(new NPC(13, 5, p, "Testing", message_box));
				solids.add(new NPC(5, 22, p, "Testing", message_box));
				solids.add(new NPC(14, 1, p, "Testing", message_box, 2, 0, 1, 1));
				solids.add(new NPC(15, 1, p, "Testing", message_box, 2, 0, 1, 1));
				solids.add(new NPC(13, 2, p, "Testing", message_box, 2, 0, 1, -1, 1));
				solids.add(new NPC(16, 2, p, "Testing", message_box, 2, 0, 1, -1, 1));
				solids.add(new NPC(16, 11, p, "Testing", message_box, 3));
				solids.add(new TreasureBox(2, 21, 0, 1, 4, message_box, p));
				
				break;
				case 1: // town 1 interior
				teleporters.add(new Teleporter(4 * 16, 8 * 16, 2, 2, 0, 6 * 16, 5 * 16, p)); 
				teleporters.add(new Teleporter(34 * 16, 8 * 16, 2, 2, 0, 25 * 16, 6 * 16, p)); 
				teleporters.add(new Teleporter(24 * 16, 17 * 16, 2, 2, 0, 24 * 16, 15 * 16, p)); 
				teleporters.add(new Teleporter(25 * 16, 8 * 16, 2, 2, 0, 5 * 16, 11 * 16, p));
				teleporters.add(new Teleporter(12 * 16, 26 * 16, 2, 2, 0, 6 * 16, 22 * 16, p)); 
				teleporters.add(new Teleporter(24 * 16, 26 * 16, 2, 2, 2, 85 * 16, 78 * 16, p)); 
				teleporters.add(new Teleporter(33 * 16, 11 * 16, 1, 1, 1, 7 * 16, 15 * 16, p)); // stairs
				teleporters.add(new Teleporter(8 * 16, 15 * 16, 1, 1, 1, 33 * 16, 12 * 16, p)); 
				solids.add(new NPC(2, 3, p, "Testing", message_box, 1));
				solids.add(new NPC(16, 11, p, "Testing", message_box, 5, 0, 1));
				solids.add(new NPC(24, 2, p, "Testing", message_box, 4, 1));
				solids.add(new NPC(25, 20, p, "Testing", message_box, 4));
				solids.add(new NPC(34, 2, p, "Testing", message_box, 1));
				solids.add(new NpcEvent(3, 22, p, "Hey I'm cool", message_box, 6, 0, 0));
				solids.add(new Orb(3, 21, message_box, p, 8, 0, 1, "Sup"));
				solids.add(new NPC(5, 22, p, "Testing", message_box, 6, 0, 1, -1, 0));
				solids.add(new ShopKeeper(34, 3, 0, p, map_id));
				solids.add(new TreasureBox(3, 11, 2, 0, 50, message_box, p));
				
				break;
				
				case 2: // region 1
				teleporters.add(new Teleporter(94 * 16, 89 * 16, 2, 2, 0, 14 * 16, 1 * 16, p));
				teleporters.add(new Teleporter(82 * 16, 74 * 16, 1, 1, 3, 64 * 16, 61 * 16, p));
				teleporters.add(new Teleporter(85 * 16, 77 * 16, 1, 1, 1, 24 * 16, 25 * 16, p));
				teleporters.add(new Teleporter(20 * 16, 77 * 16, 1, 2, 4, 28 * 16, 14 * 16, p));
				teleporters.add(new Teleporter(85 * 16, 87 * 16, 1, 1, 5, 36 * 16, 29 * 16, p));
				
				solids.add(new NPC(96, 73, p, "Testing", message_box));
				solids.add(new NPC(94, 67, p, "Testing", message_box));
				solids.add(new NPC(95, 67, p, "Testing", message_box));
				
				break; 
				
				case 3: // region 1 caves
				teleporters.add(new Teleporter(64 * 16, 62 * 16, 2, 2, 2, 82 * 16, 75 * 16, p));
				solids.add(new TreasureBox(55, 47, 1, 0, 15, message_box, p));
				solids.add(new Orb(64, 38, message_box, p, 5, 2, -1, "Arrggghh", 4));
				solids.add(new Orb(65, 38, message_box, p, 0, 1));
				break;
				
				// town 2
				
				case 4:
				teleporters.add(new Teleporter(29 * 16, 14 * 16, 1, 2, 2, 21 * 16, 77 * 16, p));
				
				// hub tunnel
				
				case 5:
				teleporters.add(new Teleporter(36 * 16, 27 * 16, 1, 2, 2, 85 * 16, 88 * 16, p));
			}
		}
		
		private function map_properties():void
		{
			
			// encounter properties
			switch(map_id)
			{
				default: encounterOn = false; break; // no encounters by default
				case 2: // region 1: change these properties for different areas of a given map, based on p.x and p.y
				encounterOn = true;
				encounterList = new Array(0, 1, 3);
				encounterDifficulty = new Array(2, 1);
				encounterRate = 35;
				break;
				case 3: // cave 1
				encounterOn = true;
				encounterDifficulty = new Array(3, 1);
				encounterList = new Array(0, 1, 3);
				encounterRate = 35;
				break;
				
			}
		}
		
		private function play_music():void
		{
			
			switch(map_id)
			{ 
				case 0: StatsTable.song_id = "town"; break;
				case 1: StatsTable.song_id = "town"; break;
				case 2: StatsTable.song_id = "world"; break;
				case 3: StatsTable.song_id = "cave"; break;
				case 4: StatsTable.song_id = "town2"; break;
			}
			
			if (StatsTable.song_id != StatsTable.old_song)
			{
				
				switch(StatsTable.song_id)
				{
					case "town": FlxG.playMusic(SngTown); StatsTable.old_song = StatsTable.song_id;  break;
					case "town2": FlxG.playMusic(SngTown2); StatsTable.old_song = StatsTable.song_id;  break;
					case "world": FlxG.playMusic(SngWorld); StatsTable.old_song = StatsTable.song_id; break;
					case "cave": FlxG.playMusic(SngCave); StatsTable.old_song = StatsTable.song_id; break;
				}
			}
		}
		
	}

}