package  
{
	import org.flixel.*;
	
	public class TitleState extends FlxState
	{
		[Embed(source = "font/Gamegirl.ttf", fontFamily = "GB")] public var	FontMenu:String;
		[Embed(source = "music/title.mp3")] private var SngTitle:Class;
		
		public function TitleState() 
		{
			bgColor = 0xff000000;
			
			var text:FlxText = new FlxText(0, 24, 160, "FlxMon");
			text.font = "GB";
			text.alignment = "center";
			add(text);
			
			text = new FlxText(0, 40, 160, "(Press Z)");
			text.alignment = "center";
			text.font = "GB";
			add(text);
			
			FlxG.playMusic(SngTitle);
			
			FlxG.debug = true;
		}
		
		override public function update():void
		{
			if (FlxG.keys.pressed("Z"))
				FlxG.state = new FieldState(7 * 16, 12 * 16, 1);
		}
	}

}