package  
{
	import org.flixel.*;
	
	public class Camera extends FlxSprite
	{
		[Embed(source = "graphics/overworld/tel_marker.png")] private var ImgMe:Class;
		public var new_x:Number;
		public var new_y:Number;
		public var coord_x:Number;
		public var coord_y:Number;
		
		public function Camera(X:int, Y:int) 
		{
			x = X;
			y = Y;
			loadGraphic(ImgMe);
			new_x = x;
			new_y = y;
			
			coord_x = x;
			coord_y = y;
			visible = false;
		}
		
		override public function update():void
		{			
			if (x < coord_x)
			{
				x += 8;
				FlxG.followBounds(x, coord_y, x + 160, y + 144);
				if (x > coord_x)
					x = coord_x;
			}
			if (x > coord_x)
			{
				x -= 8;
				FlxG.followBounds(x, coord_y, x + 160, y + 144);
				if (x < coord_x)
					x = coord_x;
			}
			if (y < coord_y)
			{
				y += 8;
				FlxG.followBounds(coord_x, y, x + 160, y + 144);
				if (y > coord_y)
					y = coord_y;
			}
			if (y > coord_y)
			{
				y -= 8;
				FlxG.followBounds(coord_x, y, x + 160, y + 144);
				if (y < coord_y)
					y = coord_y;
			}
		}
		
	}

}