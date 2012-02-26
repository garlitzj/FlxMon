package  
{
	import org.flixel.*;
	
	public class MenuCursor extends FlxSprite
	{
		[Embed(source = "graphics/menu/menu_cursor.png")] private var ImgMe:Class;
		[Embed(source = "sound/select.mp3")] private var SndSelect:Class;
		
		public var timer:int;
		public var pos:int; // this is used to determine where the cursor is relative to the page
		public var internal_pos:int; // this is used to find where the cursor is absolute in a list
		public var internalMax:int = -1;
		private var space:int;
		private const delay:int = 10;
		private var max:int;
		private var offset_y:int;
		private var offset_x:int;
		private var submenu:int;
		private var submenuActive:int;
		private var myType:int;
		
		public function MenuCursor(X:int, Y:int, maxPos:int, spacing:int, intMaxPos:int = -1, type:int = 0) 
		{
			super(X, Y);
			loadGraphic(ImgMe, true, false, 8, 8);
			
			addAnimation("norm", [0, 1, 2, 1], 5);
			
			play("norm");
			
			space = spacing;
			max = maxPos;
			
			offset_y = Y;
			offset_x = X;
			
			internalMax = intMaxPos;
			
			myType = type;
			
		}
		
		override public function update():void
		{
			if(myType == 0)
				y = pos * space + offset_y;
			else
				x = pos * space + offset_x;
			
			if (timer > 0)
			{
				timer -= FlxG.elapsed;
				
				if (timer < 0)
					timer = 0;
			}
			
			if (timer == 0)
			{
				//if (submenu == submenuActive)
				//{
					if (internalMax > -1)
					{
						if (FlxG.keys.pressed("UP"))
						{
							if (internalMax != -1 && internal_pos > 0)
							{
								pos -= 1;
								internal_pos -= 1;
								timer = delay;
								FlxG.play(SndSelect);
							}
						}
					
						if (FlxG.keys.pressed("DOWN"))
						{
							if (internalMax != -1 && internal_pos < internalMax - 1)
							{
								pos += 1;
								internal_pos += 1;
								timer = delay;
								FlxG.play(SndSelect);
							}
						}
					}
					else
					{
						if (myType == 0)
						{
							if (FlxG.keys.pressed("UP"))
							{							
								pos -= 1;
								internal_pos -= 1;
								timer = delay;
								FlxG.play(SndSelect);
								
							}
							
							if (FlxG.keys.pressed("DOWN"))
							{
								pos += 1;
								internal_pos += 1;
								timer = delay;
								FlxG.play(SndSelect);
							}
						}
						if (myType == 1)
						{
							if (FlxG.keys.pressed("LEFT"))
							{							
								pos -= 1;
								internal_pos -= 1;
								timer = delay;
								FlxG.play(SndSelect);								
							}
							
							if (FlxG.keys.pressed("RIGHT"))
							{
								pos += 1;
								internal_pos += 1;
								timer = delay;
								FlxG.play(SndSelect);
							}
						}
						
					}
				//}
				
				if (pos < 0)
					pos = max;
				if (pos > max)
					pos = 0;
			}
			
			super.update();
			
		}
		
	}

}