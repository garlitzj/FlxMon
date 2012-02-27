package  
{
	import org.flixel.*;
	
	public class Orb extends NPC
	{
		private var myMonsterID:int;
		private var myMonsterRequirement:int;
		//private var mySwitch:int;
		private var myItem:int;
		private var addMonster:Boolean = false;
		private var myMessageID:String;
		
		// condition: 0 = free, 1 == fight; 2 = item in battle
		// Switch ID simply turns on a switch... the only way to get rid of an orb event by having the monster
		
		public function Orb(X:int, Y:int, msg_box:FlxGroup, p:Player, monsterID:int, monsterCondition:int = 0, switchID:int = -1, my_msg:String = "", monsterItem:int = -1) 
		{
			my_msg += "#Kim negotiated with the#monster. And...#...";
			super(X, Y, p, my_msg, msg_box, 7, 1, 0);
			myMonsterID = monsterID;
			myMonsterRequirement = monsterCondition;
			mySwitch = switchID;
			myItem = monsterItem;
			myMessageID = my_msg;
			animated = true;
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (addMonster == true && StatsTable.scriptedBattle == -1)
			{
				StatsTable.addMonster(myMonsterID, pref, m_group);
				addMonster = false;
				StatsTable.postBattle = false; // just to prevent looping
				FieldState.timer = 30;
				
				if (mySwitch > -1)
				{
					StatsTable.Switch[mySwitch] = 1;
				}
			}
			
			if (StatsTable.MonsterStatus[myMonsterID] > 0)
				kill();
		}
		
		override protected function talkTo(mydir:int = 0):void
		{
			text = myMessageID.split("#");
			
			var myMessage:Array = new Array()
			myMessage.length = text.length;
			
			for (var i:int = 0; i < myMessage.length; i++)
			{
				myMessage[i] = text[i];
			}
					
			text = myMessage;
			
			if (myMonsterRequirement == 0)
			{
				StatsTable.scriptedBattle = -1; // simply give the monster to the player
				text.push(DataTable.MonsterNames[myMonsterID] + " joined!");
				addMonster = true;
			}
			
			if (myMonsterRequirement == 1)
			{
				StatsTable.monsterOrbID = myMonsterID;
				StatsTable.scriptedBattle = 1;
				text.push(DataTable.MonsterNames[myMonsterID] + " wants to fight!");
			}
			if (myMonsterRequirement == 2)
			{
				StatsTable.monsterOrbID = myMonsterID;
				StatsTable.scriptedBattle = 2;
				StatsTable.requiredItem = myItem;
				text.push(DataTable.MonsterNames[myMonsterID] + " has a demand!");
				text.push("Give me " + DataTable.ItemName[myItem] + "!");
			}
						
			super.talkTo();
		}
		
	}

}