package  
{
	import org.flixel.*;
	
	public class SubMenuOption extends FlxSprite
	{
		[Embed(source = "graphics/menu/submenu_option.png")] private var ImgMe:Class; // Simple two choice sub menu
		
		public function SubMenuOption(X:int, Y:int) 
		{
			super(X, Y, ImgMe);
		}
		
	}

}