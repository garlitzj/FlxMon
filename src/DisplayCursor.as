package  
{
	import org.flixel.*;
	
	public class DisplayCursor extends FlxSprite
	{
		[Embed(source = "graphics/menu/dialog_cursor.png")] private var ImgMe:Class;
		public var myState:int = 0;
		
		public function DisplayCursor(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgMe, true, false, 8, 8);
			
			addAnimation("norm", [0, 1, 2, 1], 5);
			addAnimation("stop", [3]);
			
		}
		
		override public function update():void
		{
			if (myState == 0)
				play("norm");
			else
				play("stop");
			
			super.update();
		}
		
	}

}