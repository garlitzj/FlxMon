package  
{
	import org.flixel.*;
	
	public class TreasureBox extends NPC
	{
		[Embed(source = "graphics/overworld/treasure_chest.png")] private var ImgMe:Class;
		[Embed(source = "graphics/overworld/treasure_open.png")] private var ImgAlt:Class;
		
		// primary var is the type of chest; i.e. money (0) or item (1)... sub_var is the amount of money or item id respectively

		private var type:int;
		private var value:int;
		private var switch_id:int;
		
		public function TreasureBox(X:int, Y:int, treasure_id:int, primary_var:int, sub_var:int, msg_box:FlxGroup, p:Player) 
		{
			switch_id = treasure_id;
				
			super(X, Y, p, -1, msg_box, -1);
			loadGraphic(ImgMe);
			
			solid = true;
			fixed = true;
			
			type = primary_var;
			value = sub_var;
			
			pref = p;
			m_group = msg_box;

			
		}
		
		override public function update():void
		{
			if (StatsTable.Treasure[switch_id] == 1)
			{
				loadGraphic(ImgAlt);
				active = false;
			}
			
			super.update();
		}
		
		override protected function talkTo(mydir:int = 0):void
		{
			StatsTable.Treasure[switch_id] = 1;
			StatsTable.TreasureTotal += 1;
			
			if (type == 0)
			{
				StatsTable.Money += value;
				if (StatsTable.Money > 999)
					StatsTable.Money = 999;
				text = new Array("Found $" + value + " in the chest!");
			} else
			{
				StatsTable.Inventory.push(value);
				text = new Array("Found " + DataTable.ItemName[value] + " in the chest!");
			}
			
			super.talkTo();
			
		}
		
	}

}