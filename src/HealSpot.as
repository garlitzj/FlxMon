package  
{
	import org.flixel.*;
	
	public class HealSpot extends FlxSprite
	{
		private var p:Player;
		private var timer:int;
		private var trigger:Boolean;
		
		[Embed(source = "graphics/overworld/tel_marker.png")] private var ImgMe:Class;
		[Embed(source = "sound/healthup.mp3")] private var SndHeal:Class;
		
		public function HealSpot(X:int, Y:int, mywidth:int, myheight:int, pref:Player) 
		{
			super(X * 16, Y * 16);
			createGraphic(16 * mywidth, 16 * myheight, 0xffffff);
			
			visible = false;
			
			p = pref;
		}
		
		override public function update():void
		{
			if (p.x >= x && p.x <= x + (width - 15) && p.y <= y + (height - 15) && p.y >= y)
			{
				if (trigger == false)
				{
					p.velocity.x = 0;
					p.velocity.y = 0;
					FlxG.play(SndHeal);
					FieldState.freeze = true;
					FlxG.flash(0xffffffff, .75, endHeal);
					trigger = true;
				}
			}
			else
			{
				trigger = false;
			}
			
			super.update();
		}
		
		private function endHeal():void
		{
			FieldState.freeze = false;
			
			for (var i:int = 0; i < StatsTable.MonsterHP.length; i++)
			{
				StatsTable.MonsterHP[i] = StatsTable.MonsterHPMax[i];
			}
			
			trigger = true;
		}
		
		
	}

}