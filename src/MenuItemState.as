package  
{
	import org.flixel.*;

	public class MenuItemState extends FlxState
	{
		// HUD: Fonts
		[Embed(source="font/Gamegirl.ttf", fontFamily="GB")] public var	FontMenu:String;
		[Embed(source = "graphics/menu/item_menu.png")] private var ImgMe:Class;
		[Embed(source = "sound/bump.mp3")] private var SndBump:Class;
		[Embed(source = "sound/select_2.mp3")] private var SndSelect:Class;
		[Embed(source = "sound/healthup.mp3")] private var SndHealth:Class;
		[Embed(source = "sound/slide.mp3")] private var SndToss:Class;
		
		private var p_x:int
		private var p_y:int
		private var p_m:int;
		private var timer:int = 15;
		private var per_page:int = 6;
		private var start:int = 0;
		private var end:int;
		private var page:int;
		private var sub_menu:int = 0;
		private var dispCursor:DisplayCursor;
		private var subMenu:SubMenuOption;
		private var menu_bg:FlxSprite;
		private var cursor:MenuCursor;
		private var cursor2:MenuCursor;
		private var menu_text:FlxText;
		private var submenu_text:FlxText;
		private var description_text:FlxText;
		
		public function MenuItemState(px:int, py:int, pm:int) 
		{
			p_x = px;
			p_y = py;
			p_m = pm;
		}
		
		override public function create():void
		{	
			menu_bg = new FlxSprite(0, 0, ImgMe);
			add(menu_bg);
			
			if (StatsTable.Inventory.length > 0)
			{
				cursor = new MenuCursor(38, 8, per_page, 18, StatsTable.Inventory.length);
				add(cursor);
			}
			
			menu_text = new FlxText(46, 6, 144);
			menu_text.font = "GB";
			add(menu_text);
			
			description_text = new FlxText(3, 129, 151);
			//description_text.font = "GB";
			description_text.size = 7.5;
			add(description_text);
			
			dispCursor = new DisplayCursor(72, 109);
			dispCursor.visible = false;
			add(dispCursor);
			
			
			if (StatsTable.Inventory.length > 0)
			{
				dispCursor.visible = true;
				getItems();
			}
			
			subMenu = new SubMenuOption(0, 112);
			subMenu.visible = false;
			add(subMenu);
			
			submenu_text = new FlxText(12, 122, 136, "Use  Drop");
			submenu_text.font = "GB";
			submenu_text.visible = false;
			add(submenu_text);
			
			cursor2 = new MenuCursor(3, 124, 1, 42, -1, 1);
			cursor2.visible = false;
			cursor2.active = false;
			add(cursor2);
		}
		
		override public function update():void
		{	
			if (sub_menu == 0)
			{
				subMenu.visible = false;
				cursor.visible = true;
				cursor.active = true;
				dispCursor.visible = true;
				submenu_text.visible = false;
				
				cursor2.visible = false;
				cursor2.active = false;
			}
			if (sub_menu == 1)
			{
				subMenu.visible = true;
				cursor.visible = true;
				cursor.active = false;
				dispCursor.visible = false;
				submenu_text.visible = true;
				
				cursor2.visible = true;
				cursor2.active = true;
			}
			
			
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
						var temp:int; // item type
						temp = DataTable.ItemType[StatsTable.Inventory[cursor.internal_pos]];
						if (cursor2.pos == 0) // use
						{
							if (temp == 0 || temp == 4 || temp == 6)
								useItem();
							else
								errorBump();
						}
						if (cursor2.pos == 1) // drop
						{
							if (temp < 5) // if the item is not important, drop it
								dropItem();
							else
								errorBump();
						}
					}
				}
			}
			
			if (StatsTable.Inventory.length > 0 && sub_menu == 0)
			{
				if (cursor.internal_pos > end - 2)
				{
					page++;
					cursor.pos = 0;
					getItems();
				}
				
				if (cursor.internal_pos < start && start > 0)
				{
					page--;
					cursor.pos = per_page - 1;
					getItems();
				}
				
				description_text.text = DataTable.ItemDesc[StatsTable.Inventory[cursor.internal_pos]];
			}
		
			super.update();
		}
		
		
		private function getItems():void
		{
			start = per_page * page;
			end = start + (per_page) + 1;
			itemText();
		}
		
		private function itemText():void
		{
			var i:int = start;
			var temp:int = end;
			dispCursor.myState = 0;
			
			if (temp > StatsTable.Inventory.length)
			{
				temp = StatsTable.Inventory.length + 1; // set the cutoff to the end of inventory + offset of 1
				dispCursor.myState = 1;
			}
			
			menu_text.text = DataTable.ItemName[StatsTable.Inventory[i]] + "\n\n";
			
			for (i = start + 1; i < temp - 1; i++)
			{
				menu_text.text += DataTable.ItemName[StatsTable.Inventory[i]] + "\n\n";
			}
		}
		
		private function returnTo():void
		{
			FlxG.state = new MenuState(p_x, p_y, p_m);
		}
		
		private function useItem():void
		{
			// add the specifics later, this is just the outline
			
			switch(DataTable.ItemType[cursor.internal_pos])
			{
				case 0: healingItem(); break;
			}
		}
		
		private function healingItem():void
		{
				if (StatsTable.MonsterRoster.length > 0)
				{
					var myID:int = StatsTable.MonsterRoster[0];
			
					StatsTable.MonsterHP[myID] += DataTable.ItemSub[cursor.internal_pos];
				
					if (StatsTable.MonsterHP[myID] >= StatsTable.MonsterHPMax[myID])
					{
						StatsTable.MonsterHP[myID] = StatsTable.MonsterHPMax[myID];
					}
				
					StatsTable.Inventory.splice(cursor.internal_pos, 1);

					timer = 50;
					FlxG.fade.start(0xff000000, .45, toMenuAgain, true);
					FlxG.play(SndHealth);
				}
				else
					errorBump();
		}
		
		private function dropItem():void
		{
			StatsTable.Inventory.splice(cursor.internal_pos, 1);
			
			timer = 30;
			FlxG.play(SndToss);
			FlxG.fade.start(0xff000000, .25, toMenuAgain);
		}
		
		private function errorBump():void
		{
			timer = 5;
			FlxG.play(SndBump);
			FlxG.quake.start(.005, .15);
		}
		
		private function toMenuAgain():void
		{
			if(StatsTable.Inventory.length > 0)
				FlxG.state = new MenuItemState(p_x, p_y, p_m);
			else
				FlxG.state = new MenuState(p_x, p_y, p_m);
			
		}
		
		private function toDemo():void
		{
			
		}
	}
	

}