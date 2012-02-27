package  
{
	import org.flixel.*;
	
	public class NPC extends FlxSprite
	{
		[Embed(source = "graphics/overworld/npc_male_sheet.png")] protected var ImgNPC_1:Class;
		[Embed(source = "graphics/overworld/npc_guard_sheet.png")] protected var ImgNPC_2:Class;
		[Embed(source = "graphics/overworld/npc_female_sheet.png")] protected var ImgNPC_3:Class;
		[Embed(source = "graphics/overworld/npc_oldman_sheet.png")] protected var ImgNPC_4:Class;
		[Embed(source = "graphics/overworld/npc_female_mom.png")] protected var ImgNPC_5:Class;
		[Embed(source = "graphics/overworld/npc_male_alt_sheet.png")] protected var ImgNPC_6:Class;
		[Embed(source = "graphics/overworld/orb_sheet.png")] protected var ImgNPC_7:Class;
		
		public var dir:int = 0; // down, up, right, left
		public var old_dir:int;
		
		protected var pref:Player;
		protected var text:Array;
		protected var m_group:FlxGroup;
		protected var graphic_id:int;
		protected var myReqSwitch:int;
		protected var animated:Boolean;
		protected var interact:Boolean = true;
		protected var automatic:Boolean = false;
		protected var mySwitch:int = 0;
		protected var myMonster:int;
		
		public var message_up:Boolean;
		
		// The three optional arguments refer to switches stored in StatsTable. alt_id is the switch that triggers alternate text. switch_id is the switch
		// that permanently gets rid of this npc. Alt text is simply the alternate array for alt_id

		// for behavior: 0 = stand; 1 = walk in place; 2 = automatic message
		
		public function NPC(X:int, Y:int, p:Player, my_text:String = "", msg_group:FlxGroup = null, my_graphic_id:int = 0, my_dir:int = 0, behavior:int = 0, switch_id:int = -1, monsterID:int = 0, requiredSwitch:int = -1, switch_alt_id:int = -1, alt_text_id:int = 0)
		{
			graphic_id = my_graphic_id;
			super(X * 16, Y * 16);
			visible = false;
			
			mySwitch = switch_id;
			myMonster = monsterID;
			
			if (StatsTable.Switch[switch_id] == 1)
				kill();
				
			if (StatsTable.Switch[switch_alt_id] == 1)
				text = DataTable.Messages[alt_text_id];
			else
				text = my_text.split("#");
				
			if (graphic_id == 0) // for signs and the like
			{
				createGraphic(16, 16);
				visible = false;
			} 
			else
			{
				determineGraphic();
				solid = true;
				dir = my_dir;
				fixed = true;
			}
			
			pref = p;
			m_group = msg_group;
			
			if (behavior == 1)
				animated = true;
			if (behavior == 2)
				automatic = true;
				
			myReqSwitch = requiredSwitch;
			
			if (myReqSwitch == -1 || StatsTable.Switch[myReqSwitch] == 1)
				if(graphic_id != 0)
					visible = true;
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (myReqSwitch > -1)
			{
				if (StatsTable.Switch[myReqSwitch] == 1)
				{
					visible = true;
					solid = true;
					interact = true;
				}
				else
				{
					visible = false;
					solid = false;
					interact = false;
				}
			}
			
			if (automatic == false)
			{
				if (FlxG.keys.pressed("Z") && message_up == false && interact == true && pref.x % 16 == 0 && pref.y % 16 == 0 && FieldState.freeze == false)
				{
					switch(pref.dir)
					{
						case 0: if (pref.x == x && pref.y == y - 16) talkTo(1); break;
						case 1: if (pref.x == x && pref.y == y + 16) talkTo(0); break;
						case 2: if (pref.x == x - 16 && pref.y == y) talkTo(3); break;
						case 3: if (pref.x == x + 16 && pref.y == y) talkTo(2); break;
					}
				}
			}
			else
			{
				if(message_up == false && interact == true && pref.x % 16 == 0 && pref.y % 16 == 0 && FieldState.freeze == false)
					talkTo();
			}
			animate();
			
		}
		
		protected function determineGraphic():void
		{
			switch(graphic_id)
			{
				case 1: loadGraphic(ImgNPC_1, true, false, 16, 16); break;
				case 2: loadGraphic(ImgNPC_2, true, false, 16, 16); break;
				case 3: loadGraphic(ImgNPC_3, true, false, 16, 16); break;
				case 4: loadGraphic(ImgNPC_4, true, false, 16, 16); break;
				case 5: loadGraphic(ImgNPC_5, true, false, 16, 16); break;
				case 6: loadGraphic(ImgNPC_6, true, false, 16, 16); break;
				case 7: loadGraphic(ImgNPC_7, true, false, 16, 16); break;
			}
			
			addAnimation("walk_down", [1, 2, 1, 2], 4);
			addAnimation("walk_up", [3, 4, 3, 4], 4);
			addAnimation("walk_right", [6, 7, 8, 7], 8);
			addAnimation("walk_left", [9, 10, 11, 10], 8);
			
			addAnimation("idle_down", [0]);
			addAnimation("idle_up", [5]);
			addAnimation("idle_right", [7]);
			addAnimation("idle_left", [10]);
		} 
		
		protected function talkTo(mydir:int = 0):void
		{
			if (myMonster > 0) // whether or not this dialog will initiate a battle
			{
				StatsTable.switchToAct = mySwitch;
				StatsTable.scriptedBattle = 0;
				StatsTable.myMonster = myMonster;
			}
			
			old_dir = dir;
			dir = mydir;
			FieldState.freeze = true;
			FlxG.state.add(new MessageBox(text, pref, m_group, this));
			message_up = true;
			
			if (automatic)
				kill();
		}
		
		protected function animate():void
		{
			if (graphic_id != 0)
			{
				if (animated == false)
				{
					switch(dir)
					{
						case 0: play("idle_down"); break;
						case 1: play("idle_up"); break;
						case 2: play("idle_right"); break;
						case 3: play("idle_left"); break;
					}
				}
				else
				{
					switch(dir)
					{
						case 0: play("walk_down"); break;
						case 1: play("walk_up"); break;
						case 2: play("walk_right"); break;
						case 3: play("walk_left"); break;
					}
				}
			}
		}
		
	}

}