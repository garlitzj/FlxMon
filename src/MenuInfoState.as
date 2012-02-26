package  
{
	import org.flixel.*;
	
	public class MenuInfoState extends FlxState
	{
		[Embed(source = "graphics/menu/info_menu.png")] private var ImgMe:Class;
		[Embed(source = "font/Gamegirl.ttf", fontFamily = "GB")] public var	FontMenu:String;
		
		private var monster_id:int;
		private var timer:int = 15;
		private var myText:FlxText;
		private var menu_bg:FlxSprite;
		private var myGraphic:FlxSprite;
		private var myClass:Class;
		private var p_x:int;
		private var p_y:int;
		private var p_m:int;
		private var myAttack:int;
		private var myDefense:int;
		private var mySpeed:int;
		private var mySpecial:int;
		private var myEXP:int;
		private var toNextLevel:int;
		
		public function MenuInfoState(px:int, py:int, pm:int, mid:int) 
		{
			p_x = px;
			p_y = py;
			p_m = pm;
			monster_id = mid;
		}
		
		override public function create():void
		{	
			menu_bg = new FlxSprite(0, 0, ImgMe);
			add(menu_bg);
			
			myClass = DataTable["imgFront" + monster_id];
			
			myGraphic = new FlxSprite(12, 12, myClass);
			add(myGraphic);
			
			// Name, HP, SP
			
			myText = new FlxText(62, 12, 100);
			myText.font = "GB";
			myText.text = DataTable.MonsterNames[monster_id] + "\n";
			myText.text += "HP: " + StatsTable.MonsterHP[monster_id] + "/" + StatsTable.MonsterHPMax[monster_id] + "\n";
			myText.text += "SP: " + StatsTable.MonsterSP[monster_id] + "/" + StatsTable.MonsterSPMax[monster_id] + "\n";
			myText.text += "Fine";
			add(myText);
			
			myAttack = FormulaTable.getAttack(StatsTable.MonsterAttack[monster_id], StatsTable.MonsterLevel[monster_id]);
			myDefense = FormulaTable.getAttack(StatsTable.MonsterDefense[monster_id], StatsTable.MonsterLevel[monster_id]);
			mySpeed = FormulaTable.getAttack(StatsTable.MonsterSpeed[monster_id], StatsTable.MonsterLevel[monster_id]);
			mySpecial = FormulaTable.getAttack(StatsTable.MonsterSpecial[monster_id], StatsTable.MonsterLevel[monster_id]);
			
			myEXP = StatsTable.MonsterEXP[monster_id];
			
			// this line, however, will always be needed
			toNextLevel = 0;
			
			for (var i:int = 0; i < StatsTable.MonsterLevel[monster_id]; i++)
				toNextLevel += FormulaTable.requiredPoints(StatsTable.MonsterEXPMod[monster_id], i);
				
			toNextLevel -= myEXP;
			
			myText = new FlxText(8, 90, 70);
			myText.font = "GB";
			myText.text = "Atk: " + myAttack;
			myText.text += "\nDef: " + myDefense;
			myText.text += "\nSpd: " + mySpeed;
			myText.text += "\nSpc: " + mySpecial;
			add(myText);
			
			myText = new FlxText(91, 80, 70);
			myText.font = "GB";
			myText.text = "Lvl " + StatsTable.MonsterLevel[monster_id];
			add(myText);
			
			myText = new FlxText(91, 85, 70);
			myText.font = "GB";
			myText.text += "\nEXP:\n" + myEXP;
			myText.text += "\nNext:\n" + toNextLevel;
			add(myText);
			
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
				if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("Z"))
				{
					timer = 100;
					FlxG.fade.start(0xff000000, .35, returnTo);
				}
			}
			
			super.update();
		}
		
		private function returnTo():void
		{
			FlxG.state = new MenuTeamState(p_x, p_y, p_m);
		}
		
	}

}