package 
{
	import org.flixel.*;
	[SWF(width = "640", height = "576", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame 
	{
		public function Main()
		{
			super(160, 144, SplashState, 4);
			FlxG.framerate = 60;
			FlxState.bgColor = 0xff000000;
		}
		
	}
	
}