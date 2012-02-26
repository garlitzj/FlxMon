package  
{
	import org.flixel.*;
	
	public class ShopState extends FlxState
	{
		// HUD: Fonts
		[Embed(source="font/Gamegirl.ttf", fontFamily="GB")] public var	FontMenu:String;
		[Embed(source = "graphics/menu/shop_menu.png")] private var ImgMe:Class;
		[Embed(source = "sound/select_2.mp3")] private var SndSelect:Class;
		[Embed(source = "sound/coin.mp3")] private var SndCoin:Class;
		[Embed(source = "sound/bump.mp3")] private var SndBump:Class;
		
		public static var money:int;
		private var menu_bg:FlxSprite;
		private var menu_text:FlxText;
		private var money_text:FlxText;
		private var cost_text:FlxText;
		private var inventory_text:FlxText;
		private var player_x:int;
		private var player_y:int;
		private var player_map:int;
		private var player_dir:int;
		private var cursor:MenuCursor;
		private var cursor2:MenuCursor;
		private var timer:int;
		private var dispCursor:DisplayCursor;
		private var sub_menu:int = 0;
		private var inventory:Array;
		private var start:int = 0;
		private var end:int;
		private var per_page:int = 5;
		private var page:int;
		
		public function ShopState(px:int, py:int, pm:int, myShop:int, pdir:int):void
		{
			player_x = px;
			player_y = py;
			player_map = pm;
			player_dir = pdir;
			inventory = DataTable.ShopInventory[myShop];
		}
		
		override public function create():void 
		{
			menu_bg = new FlxSprite(0, 0, ImgMe);
			add(menu_bg);
			
			menu_text = new FlxText(12, 8, 144, "Buy  Exit");
			menu_text.font = "GB";
			
			add(menu_text);
			
			money_text = new FlxText(109, 8, 36, "$" + StatsTable.Money.toString());
			money_text.font = "GB";
			money_text.alignment = "center";
			
			add(money_text);
			
			inventory_text = new FlxText(16, 42, 58);
			cost_text = new FlxText(80, 42, 32);
			
			// cursors
			
			cursor = new MenuCursor(4, 10, 1, 42, -1, 1);
			add(cursor);
			
			cursor2 = new MenuCursor(8, 44, per_page, 20, inventory.length);
			cursor2.visible = false;
			add(cursor2);
			
			dispCursor = new DisplayCursor(50, 134);
			dispCursor.visible = false;
			add(dispCursor);
			
			// get the text and display
			
			getItems();
			add(inventory_text);
			add(cost_text);
		}
		
		override public function update():void
		{
			// handle the cursors here
			cursor.active = true;
			cursor2.active = false;
			cursor2.visible = false;
			dispCursor.visible = false;
			
			money_text.text = "$" + StatsTable.Money.toString(); // update the money text
			
			if (timer > 0)
			{
				timer -= FlxG.elapsed;
				
				if (timer < 0)
					timer = 0;
			}
			
			if (sub_menu > 0)
			{
				cursor.active = false;
				cursor2.active = true;
				cursor2.visible = true;
				dispCursor.visible = true;
			}
			
			if (timer == 0)
			{
				if (FlxG.keys.justPressed("X"))
				{
					if (sub_menu == 0)
					{
						FlxG.fade.start(0xff000000, .25, returnTo);
						sub_menu = -1;
					}
					if (sub_menu == 1)
					{
						sub_menu = 0;
						timer = 5;
						FlxG.play(SndSelect);
					}
				}
				
				if (FlxG.keys.justPressed("Z"))
				{
					if (sub_menu == 0)
					{
						if (cursor.pos == 0) // don't fade out for the save menu!
						{
							sub_menu = 1;
							FlxG.play(SndSelect);
							timer = 5;
						}
						else
						{
							FlxG.fade.start(0xff000000, .25, returnTo);
							sub_menu = -1;
						}
					}
					if (sub_menu == 1 && timer == 0) // timer == 0 condition is so the user doesn't purchase something as he enters sub menu
					{
						// let's do some purchasin'
						if (StatsTable.Money >= DataTable.ItemCost[inventory[cursor2.internal_pos]])
						{
							// yay! purchase
							timer = 10;
							FlxG.play(SndCoin);
							StatsTable.Money -= DataTable.ItemCost[inventory[cursor2.internal_pos]];
							StatsTable.Inventory.push(inventory[cursor2.internal_pos]);
						}
						else
						{
							timer = 5;
							FlxG.play(SndBump);
							FlxG.quake.start(.005, .15);
						}
					}
				}
			}
			if (inventory.length > 0)
			{
				if (cursor2.internal_pos > end - 2)
				{
					page++;
					cursor2.pos = 0;
					getItems();
				}
				
				if (cursor2.internal_pos < start && start > 0)
				{
					page--;
					cursor2.pos = per_page - 1;
					getItems();
				}
			}
			
			if(sub_menu > -1)
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
			
			if (temp > inventory.length)
			{
				temp = inventory.length;
				dispCursor.myState = 1; // stop the cursor... this is the last page
			}
			
			inventory_text.text = DataTable.ItemName[inventory[i]] + "\n\n";
			cost_text.text = "$" + DataTable.ItemCost[inventory[i]].toString() + "\n\n";
			
			for (i = start + 1; i < temp; i++)
			{
				inventory_text.text += DataTable.ItemName[inventory[i]] + "\n\n";
				cost_text.text += "$" + DataTable.ItemCost[inventory[i]].toString() + "\n\n";
			}
		}
		
		private function returnTo():void
		{
			FieldState.freeze = false;
			FlxG.state = new FieldState(player_x, player_y, player_map, player_dir);
		}
		
	}

}