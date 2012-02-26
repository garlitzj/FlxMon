package  
{
	import org.flixel.*;

	public class SplashState extends FlxState
	{
		[Embed(source = "font/Gamegirl.ttf", fontFamily = "GB")] public var	FontMenu:String;
		[Embed(source = "sound/splash.mp3")] private var SndSplash:Class;
		
		private var splashText:FlxText;
		private var flag:int = 0;
		private var timer:int = 30;
		public function SplashState() 
		{
			bgColor = 0xffffffff;
			splashText = new FlxText(0, 144, 160, "[NoTendo]");
			splashText.font = "GB";
			splashText.color = 0xff000000;
			splashText.alignment = "center";
			add(splashText);
		}
		
		override public function update():void
		{
			if (flag == 0)
			{
				splashText.y -= 1;
				
				if (splashText.y <= 64)
				{
					flag = 1;
					FlxG.flash.start(0xff666666, .75, flagTwo);
					FlxG.play(SndSplash);
				}
			}
			
			if (timer > 0 && flag == 2)
				timer -= FlxG.elapsed;
				
			if (timer <= 0)
				FlxG.fade.start(0xff000000, 2, toTitle);
		}
		
		private function flagTwo():void
		{
			flag = 2;
		}
		
		private function toTitle():void
		{
			FlxG.state = new TitleState();
		}
		
	}

}