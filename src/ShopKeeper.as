package  
{
	import org.flixel.*;
	
	public class ShopKeeper extends FlxSprite
	{
		private var myShop:int;
		private var p:Player;
		private var myMap:int;
		
		[Embed(source = "graphics/overworld/tel_marker.png")] private var ImgMe:Class;
		
		[Embed(source = "sound/menu.mp3")] private var SndMenu:Class;
		
		public function ShopKeeper(X:int, Y:int, shopID:int, pref:Player, mapID:int) 
		{
			super(X, Y, ImgMe);
			
			solid = true;
			fixed = true;
			
			visible = false;
			 
			myShop = shopID;
			p = pref;
			myMap = mapID;
		}
		
		override public function update():void
		{
			
			if (p.x >= x - 1 && p.x <= x + (width - 15))
			{
				if (p.y <= y + (height + 15) && p.y >= y - 1)
				{
					if (FlxG.keys.pressed("Z") && FieldState.freeze == false && p.dir == 1 && p.moving == false)
					{
						FieldState.freeze = true;
						FlxG.play(SndMenu);
						FlxG.fade.start(0xff000000, .25, gotoMenu);
					}
				}
			}
			super.update();
		}
		
		private function gotoMenu():void
		{
			FlxG.state = new ShopState(p.x, p.y, myMap, myShop, p.dir);
		}
	}

}