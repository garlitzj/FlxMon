package  
{
	import org.flixel.*;
	
	public class MenuTeamState extends FlxState
	{
		
		[Embed(source="font/Gamegirl.ttf", fontFamily="GB")] public var	FontMenu:String;
		[Embed(source = "graphics/menu/roster_menu.png")] private var ImgMe:Class;
		[Embed(source = "sound/bump.mp3")] private var SndBump:Class;
		[Embed(source = "sound/select_2.mp3")] private var SndSelect:Class;
		[Embed(source = "sound/healthup.mp3")] private var SndHealth:Class;
		[Embed(source = "sound/slide.mp3")] private var SndToss:Class;
		
		private var p_x:int
		private var p_y:int
		private var p_m:int;
		private var timer:int = 10;
		private var per_page:int = 5;
		private var start:int = 0;
		private var end:int;
		private var page:int;
		private var sub_menu:int = 0;
		private var dispCursor:DisplayCursor;
		private var subMenu:SubMenuOption;
		private var divider:MenuDivider;
		private var menu_bg:FlxSprite;
		private var cursor:MenuCursor;
		private var cursor2:MenuCursor;
		private var menu_text:FlxText;
		private var submenu_text:FlxText;
		private var description_text:FlxText;
		
		public function MenuTeamState(px:int, py:int, pm:int) 
		{
			p_x = px;
			p_y = py;
			p_m = pm;
		}
		
		override public function create():void
		{	
			menu_bg = new FlxSprite(0, 0, ImgMe);
			add(menu_bg);
			
			if (StatsTable.MonsterRoster.length > 0)
			{
				cursor = new MenuCursor(8, 8, per_page, 27, StatsTable.MonsterRoster.length);
				add(cursor);
			}
			
			menu_text = new FlxText(16, 6, 72);
			menu_text.font = "GB";
			menu_text.size = 7.5;
			add(menu_text);
			
			description_text = new FlxText(90, 6, 68);
			description_text.font = "GB";
			description_text.size = 7.5;
			add(description_text);
			
			dispCursor = new DisplayCursor(78, 136);
			dispCursor.visible = false;
			add(dispCursor);
			
			
			if (StatsTable.MonsterRoster.length > 0)
			{
				dispCursor.visible = true;
				getTeam();
			}
			
			divider = new MenuDivider(5, 27);
			divider.visible = false;
			add(divider);
			
			subMenu = new SubMenuOption(0, 112);
			subMenu.visible = false;
			add(subMenu);
			
			submenu_text = new FlxText(10, 122, 136, "Info  Lead");
			submenu_text.font = "GB";
			submenu_text.visible = false;
			add(submenu_text);
			
			cursor2 = new MenuCursor(3, 124, 1, 48, -1, 1);
			cursor2.visible = false;
			cursor2.active = false;
			add(cursor2);
		}
		
		override public function update():void
		{
			
			if (sub_menu == 0)
			{
				subMenu.visible = false;
				cursor.active = true;
				dispCursor.visible = true;
				submenu_text.visible = false;
				
				cursor2.visible = false;
				cursor2.active = false;
			}
			if (sub_menu == 1)
			{
				subMenu.visible = true;
				cursor.active = false;
				dispCursor.visible = false;
				submenu_text.visible = true;
				
				cursor2.visible = true;
				cursor2.active = true;
			}
			
			// should the leader divider be visible or not?
			
			divider.visible = false;
			if (page == 0 && StatsTable.MonsterRoster.length > 1)
				divider.visible = true;
			
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
						FlxG.fade.start(0xff000000, .25, returnTo);
					}
					if (sub_menu == 1)
					{
						sub_menu = 0;
						timer = 10;
						FlxG.play(SndSelect);
					}
				}
				
				if (FlxG.keys.justPressed("Z"))
				{
					if (sub_menu == 0)
					{
						sub_menu = 1;
						FlxG.play(SndSelect);
						timer = 10;
					}
					if (sub_menu == 1 && timer == 0) // so the user doesn't press two things at once
					{
						if (cursor2.pos == 0)
						{
							timer = 50;
							sub_menu = 0;
							FlxG.play(SndSelect);
							FlxG.fade.start(0xff000000, .25, infoState);
						}
						
						if (cursor2.pos == 1)
						{
							sendToFront();
						}
					}
				}
			}
			
			if (StatsTable.MonsterRoster.length > 0 && sub_menu == 0)
			{
				if (cursor.internal_pos > end - 2)
				{
					page++;
					cursor.pos = 0;
					getTeam();
				}
				
				if (cursor.internal_pos < start && start > 0)
				{
					page--;
					cursor.pos = per_page - 1;
					getTeam();
				}
			}
			
			super.update(); 
		}
		
		private function getTeam():void
		{
			start = per_page * page;
			end = start + (per_page) + 1;
			teamText();
		}
		
		private function teamText():void
		{
			var i:int = start;
			var temp:int = end;
			dispCursor.myState = 0;
			
			if (temp > StatsTable.MonsterRoster.length)
			{
				temp = StatsTable.MonsterRoster.length + 1; // set the cutoff to the end of roster + offset of 1
				dispCursor.myState = 1;
			}
			
			menu_text.text = DataTable.MonsterNames[StatsTable.MonsterRoster[i]] + "\n\n\n";
			description_text.text = "HP:\n" + StatsTable.MonsterHP[StatsTable.MonsterRoster[i]] + "/" + StatsTable.MonsterHPMax[StatsTable.MonsterRoster[i]]  + "\n\n";
			
			for (i = start + 1; i < temp - 1; i++)
			{
				menu_text.text += DataTable.MonsterNames[StatsTable.MonsterRoster[i]] + "\n\n\n";
				description_text.text += "HP:\n" + StatsTable.MonsterHP[StatsTable.MonsterRoster[i]] + "/" + StatsTable.MonsterHPMax[StatsTable.MonsterRoster[i]]  + "\n\n";			}
		}
		
		private function returnTo():void
		{
			FlxG.state = new MenuState(p_x, p_y, p_m);
		}
		
		private function toTeamAgain():void
		{
			FlxG.state = new MenuTeamState(p_x, p_y, p_m);
		}
		
		private function infoState():void
		{
			FlxG.state = new MenuInfoState(p_x, p_y, p_m, StatsTable.MonsterRoster[cursor.internal_pos]);
		}
		
		private function sendToFront():void
		{
			var temp:int;
			temp = StatsTable.MonsterRoster[cursor.internal_pos];
			
			StatsTable.MonsterRoster.splice(cursor.internal_pos, 1);
			StatsTable.MonsterRoster.unshift(temp);
			timer = 30;
			FlxG.fade.start(0xff000000, .35, toTeamAgain); 
		}
		
		private function errorBump():void
		{
			timer = 5;
			FlxG.play(SndBump);
			FlxG.quake.start(.005, .15);
		}
		
		
	}

}