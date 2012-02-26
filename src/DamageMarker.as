package  
{
	import org.flixel.*;
	
	public class DamageMarker extends FlxText
	{
		private var myText:FlxText;
		private var myString:String;
		private var finalY:int;
		private var myBehavior:int;
		private var flag:int = 0;
		private var timer:int = 13;
		
		[Embed(source = "font/Gamegirl.ttf", fontFamily = "GB")] public var	FontMenu:String;
				
		public function DamageMarker(X:int, Y:int, string:String, behavior:int = 0) 
		{
			super(X, Y, 64, string);
			
			shadow = 0xff000000;
			
			color = 0xffa8a8a8;
			
			finalY = y - 12;
			
			myBehavior = behavior;
						
			size = 8;
		}
		
		override public function update():void
		{
			if (flag == 0)
			{
				if (myBehavior == 1)
					y -= .75;
				else
					y -= .45;
			}
			
			if (flag == 1)
			{
				y += .75;
				
				if (timer > 0)
					timer -= FlxG.elapsed;
			}
			
			if (timer <= 0)
				kill();
			
			if (y <= finalY)
			{
				if(myBehavior == 0)
					kill();
				else
				{
					flag = 1;
				}
			}
		
			super.update();
		}
		
	}

}