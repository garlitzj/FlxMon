package  
{
	import org.flixel.*;

	public class MenuStatsState extends FlxState
	{
		// HUD: Fonts
		[Embed(source="font/Gamegirl.ttf", fontFamily="GB")] public var	FontMenu:String;
		[Embed(source = "graphics/menu/stats_menu.png")] private var ImgMe:Class;
		[Embed(source = "graphics/menu/profile.png")] private var ImgProfile:Class;
		
		private var p_x:int
		private var p_y:int
		private var p_m:int;
		private var timer:int = 15;
		
		private var minutes:int;
		private var hours:int;
		
		private var menu_bg:FlxSprite;
		private var menu_profile:FlxSprite;
		private var menu_text:FlxText;
		
		public function MenuStatsState(px:int, py:int, pm:int) 
		{
			p_x = px;
			p_y = py;
			p_m = pm;
		}
		
		override public function create():void
		{
			hours = (StatsTable.PlayTime / 3600); 
			minutes = (StatsTable.PlayTime / 60);

			var minutes_str:String;
			var total_m_str:String = (StatsTable.TotalMonsters + 1).toString();
				
			menu_bg = new FlxSprite(0, 0, ImgMe);
			add(menu_bg);
			
			menu_profile = new FlxSprite(96, 16, ImgProfile);
			add(menu_profile);
			
			for (var i:int = 0; i < minutes; i += 60)
			{
				hours++;
			}
			
			hours -= 1;
			minutes = minutes % 60;
			
			if (minutes < 10)
				minutes_str = "0" + minutes.toString();
			else
				minutes_str = minutes.toString();
			
			// place more emphasis on the number of keys collected and number of monsters
			
			var completeness:Number = ((StatsTable.MonsterRoster.length + StatsTable.TreasureTotal) / (StatsTable.TotalMonsters + 1 + StatsTable.Treasure.length));
			completeness *= 100;
			completeness = Math.round(completeness);
			
			menu_text = new FlxText(34, 8, 144);
			menu_text.font = "GB";
			menu_text.text = " " + DataTable.HeroName + "\n\n Time:\n  " + hours.toString() + ":" + minutes_str;
			menu_text.text += "\n\n Monsters:\n  " + StatsTable.MonsterRoster.length.toString() + "/" + total_m_str + "\n";
			menu_text.text += "\n Treasure:\n  " + StatsTable.TreasureTotal.toString() + "/" + StatsTable.Treasure.length.toString() + "\n";
			menu_text.text += "\n Complete:\n  " + completeness + "%\n";
			add(menu_text);
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
					FlxG.fade.start(0xff000000, .25, returnTo);
				}
			}
		
			super.update();
		}
		
		private function returnTo():void
		{
			FieldState.freeze = false;
			FlxG.state = new MenuState(p_x, p_y, p_m);
		}
		
	}
	

}