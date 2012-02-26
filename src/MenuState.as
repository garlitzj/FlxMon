package  
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		// HUD: Fonts
		[Embed(source="font/Gamegirl.ttf", fontFamily="GB")] public var	FontMenu:String;
		[Embed(source = "graphics/menu/menu.png")] private var ImgMe:Class;
		[Embed(source = "sound/select_2.mp3")] private var SndSelect:Class;
		[Embed(source = "sound/bump.mp3")] private var SndBump:Class;
		
		public static var money:int;
		private var menu_bg:FlxSprite;
		private var menu_text:FlxText;
		private var player_x:int;
		private var player_y:int;
		private var player_map:int;
		private var cursor:MenuCursor;
		private var sub_menu:int = 0;
		private var timer:int = 15;
		
		public function MenuState(px:int, py:int, pm:int):void
		{
			player_x = px;
			player_y = py;
			player_map = pm;
		}
		
		override public function create():void 
		{
			menu_bg = new FlxSprite(0, 0, ImgMe);
			add(menu_bg);
			
			menu_text = new FlxText(20, 8, 144);
			menu_text.font = "GB";
			
			for (var i:int = 0; i < DataTable.MenuBit.length; i ++)
			{
				menu_text.text += DataTable.MenuBit[i] + "\n\n";
			}
			
			FlxG.state.add(menu_text);
			
			menu_text = new FlxText(109, 9, 36, "$" + StatsTable.Money.toString());
			menu_text.font = "GB";
			menu_text.alignment = "center";
			add(menu_text);
			
			// cursor
			
			cursor = new MenuCursor(12, 11, DataTable.MenuBit.length - 1, 18);
			add(cursor);
			
		}
		
		override public function update():void
		{
			if (timer > 0)
			{
				timer -= FlxG.elapsed;
				
				if (timer < 0)
					timer = 0;
			}
			
			if (timer == 0)
			{
				if (FlxG.keys.justPressed("X"))
				{
					if (sub_menu == 0)
					{
						FlxG.fade.start(0xff000000, .45, returnTo);
						sub_menu = -1;
					}
				}
				
				if (FlxG.keys.justPressed("Z"))
				{
					if (sub_menu == 0)
					{
						if (cursor.pos != 3) // don't fade out for the save menu!
						{
							if (cursor.pos == 0 && StatsTable.Inventory.length == 0)
								errorBump();
							if (cursor.pos == 1 && StatsTable.MonsterRoster.length == 0)
								errorBump();
							
							if (timer == 0) // error thing sets off the timer, so if the timer is not 0 don't go to a new screen!
							{
								FlxG.fade.start(0xff000000, .25, newSection);
								sub_menu = -1;
								FlxG.play(SndSelect);
							}
						}
						else
						{
							FlxG.flash.start(0xffffffff, .5);
							FlxG.play(SndSelect);
						}
						
						
					}
				}
			}
			
			if(sub_menu > -1)
				super.update();
		}
		
		private function returnTo():void
		{
			FieldState.freeze = false;
			FlxG.state = new FieldState(player_x, player_y, player_map);
		}
		
		private function newSection():void
		{
			switch(cursor.pos)
			{
				case 0: FlxG.state = new MenuItemState(player_x, player_y, player_map); break;
				case 1: FlxG.state = new MenuTeamState(player_x, player_y, player_map); break;
				case 2: FlxG.state = new MenuStatsState(player_x, player_y, player_map); break;
				case 3: saveGame(); break;
				default: FlxG.state = new MenuState(player_x, player_y, player_map); break;
			}
		}
		
		private function errorBump():void
		{
			timer = 5;
			FlxG.play(SndBump);
			FlxG.quake.start(.005, .15);
		}
		
		private function saveGame():void
		{
			// shared object shit here
		}
		
	}

}