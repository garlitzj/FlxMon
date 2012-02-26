package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class BattleAnimation extends FlxSprite
	{
		private var timer:int;
		[Embed(source = "graphics/battle/slash.png")] private var ImgSlash:Class;
		[Embed(source = "graphics/battle/claw.png")] private var ImgClaw:Class;
		[Embed(source = "graphics/battle/blunt.png")] private var ImgBlunt:Class;
		
		public function BattleAnimation(X:int, Y:int, animation:int = 0) 
		{
			super(X, Y);
			
			if (animation == 0)
			{
				loadGraphic(ImgSlash, true, false, 60, 45);
				addAnimation("default", [0, 1, 2, 3, 2, 1, 0], 40, false);
				
				play("default", true);
				
				timer = 25;
			}
			else if (animation == 1)
			{
				loadGraphic(ImgClaw, true, false, 60, 45);
				addAnimation("default", [0, 1, 2, 3, 3], 30, false);
				timer = 20;
				
				play("default", true);
			}
			else if (animation == 2)
			{
				// offset
				
				x += 2;
				y -= 2;
				
				loadGraphic(ImgBlunt, true, false, 60, 45);
				addAnimation("default", [0, 1, 2, 3, 3], 30, true);
				timer = 20;
				
				play("default", true);
			}
			else if (animation == 3)
			{
				// double slash
			}
			else if (animation == 4)
			{
				// chomp
			}
		}
		
		override public function update():void
		{
			if (timer > 0)
			{
				timer -= FlxG.elapsed;
				
				if (timer <= 0)
					kill();
			}
			
			super.update();
		}
		
	}

}