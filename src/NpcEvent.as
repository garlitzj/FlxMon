package  
{
	import org.flixel.*;
	
	public class NpcEvent extends NPC
	{		
		private var switchID:int;
				
		// The three optional arguments refer to switches stored in StatsTable. alt_id is the switch that triggers alternate text. switch_id is the switch
		// that permanently gets rid of this npc. Alt text is simply the alternate array for alt_id
		
		public function NpcEvent(X:int, Y:int, p:Player, my_text:int = 0, msg_group:FlxGroup = null, my_graphic_id:int = 0, my_dir:int = 0, switch_id:int = -1, myMusic:Class = null)
		{
			super(X, Y, p, my_text, msg_group, my_graphic_id, my_dir);
			animated = true;
			graphic_id = my_graphic_id;
			
		}
		
		override public function update():void
		{
			super.update();
			
			animate();
			
			if (StatsTable.Switch[switchID] == 1)
				kill();
		}
		
		
		override protected function talkTo(mydir:int = 0):void
		{
			if (switchID > -1)
			{
				StatsTable.switchToAct = switchID;
			}
			super.talkTo();
		}
		
	}

}