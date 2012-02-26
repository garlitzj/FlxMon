package  
{
	import org.flixel.*;
	
	public class MessageBox extends FlxSprite
	{
		[Embed(source = "font/Gamegirl.ttf", fontFamily = "GB")] public var	FontMenu:String;
		[Embed(source = "sound/select.mp3")] private var SndSelect:Class;
		[Embed(source = "sound/msg.mp3")] private var SndMsg:Class;
		
		private var message:Array;
		private var current_line:int = 0;
		private var thetext:FlxText;
		private var the_box:FlxSprite;
		private var cursor:FlxSprite;
		private var npc_id:NPC; // so the box doesn't get jammed with the npc
		private var p:Player;
		
		private var message_group:FlxGroup;
		
		public function MessageBox(msg:Array, pref:Player, msg_group:FlxGroup, my_npc:NPC = null) 
		{
			if (msg_group.visible == true) // stops npcs from glitching out; ensures there is only one message index at any given time
				kill();
			
			var Y:int;
			
			npc_id = my_npc;
			p = pref;
			
			Y = 112;
			
			FlxG.play(SndMsg);
			
			visible = false;
			
			// align the msg box
			
			the_box = msg_group.members[0];
			the_box.y = Y;
			the_box.x = 0;
			the_box.scrollFactor.x = 0;
			the_box.scrollFactor.y = 0;
			
			message = msg;
			
			thetext = msg_group.members[1];
						
			thetext.x = x + 4;
			thetext.y = Y + 4;
			
			thetext.scrollFactor.x = 0;
			thetext.scrollFactor.y = 0;
			thetext.font = "GB";
			//thetext.color = 0x000000;
			thetext.text = message[0];
			thetext.size = 8;
			
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			
			// finally the cursor
			
			cursor = msg_group.members[2];
			
			cursor.x = x + 74;
			cursor.y = y + 136;
			
			cursor.addAnimation("norm", [0, 1, 2, 1], 5);
			cursor.addAnimation("stop", [3]);
			
			cursor.play("norm");
			
			cursor.scrollFactor.x = 0;
			cursor.scrollFactor.y = 0;
			
			message_group = msg_group;
			message_group.visible = true;
			FieldState.freeze = true;
			
		}
		
		override public function update():void
		{
			if (message_group.visible == false)
				kill();
			
			if (FlxG.keys.justPressed("Z"))
			{
				current_line += 1;
				
				if (current_line < message.length - 1)
					cursor.play("norm");
				else
					cursor.play("stop");
				
				if (current_line < message.length)
				{
					FlxG.play(SndSelect);
					thetext.text = message[current_line];
				}
				
				if (current_line > message.length - 1)
					kill();
			}
			
			super.update();
		}
		
		override public function kill():void
		{
			FieldState.freeze = false;
			thetext.text = "";
			FlxG.play(SndMsg);
			
			message_group.visible = false;
			FlxG.keys.reset();
			
			if(npc_id != null)
				npc_id.message_up = false;
			
			npc_id.dir = npc_id.old_dir;
						
			// turn on any switches per request
			
			if(StatsTable.scriptedBattle == -1)
				StatsTable.handleSwitch();
			else
				StatsTable.scriptBattle(p);
			
			super.kill();
		}
		
	}

}