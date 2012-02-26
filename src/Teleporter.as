package  
{
	import org.flixel.*;
	
	public class Teleporter extends FlxSprite
	{
		private var mapid:int;
		private var p:Player;
		private var targetx:int;
		private var targety:int;
		private var trigger:Boolean = false;
		
		[Embed(source = "graphics/overworld/tel_marker.png")] private var ImgMe:Class;
		[Embed(source = "sound/enter.mp3")] private var SndEnter:Class;
		
		public function Teleporter(X:int, Y:int, mywidth:int, myheight:int, map_id:int, target_x:int, target_y:int, pref:Player) 
		{
			super(X, Y);
			createGraphic(16 * mywidth, 16 * myheight, 0xffffff);
			
			visible = false;
			
			p = pref;
			mapid = map_id;
			targetx = target_x;
			targety = target_y;
						
		}
		
		override public function update():void
		{
			if (p.x >= x - 1 && p.x <= x + (width - 15))
			{
				if (p.y <= y + (height - 15) && p.y >= y - 1)
				{
					if (trigger == false)
					{
						p.velocity.x = 0;
						p.velocity.y = 0;
						FlxG.play(SndEnter);
						FieldState.freeze = true;
						FlxG.fade.start(0xff000000, .75, newMap);
						trigger = true;
					}
				}
			}
			super.update();
		}
		
		private function newMap():void
		{
			FlxG.state = new FieldState(targetx, targety, mapid, p.dir);
			FieldState.freeze = false;
		}
		
		
	}

}