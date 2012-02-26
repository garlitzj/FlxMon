package  
{
	import org.flixel.*;
	
	public class MenuDivider extends FlxSprite
	{
		[Embed(source = "graphics/menu/menu_divider.png")] private var ImgMe:Class; // Simple two choice sub menu
		
		public function MenuDivider(X:int, Y:int) 
		{
			super(X, Y, ImgMe);
		}
		
	}

}