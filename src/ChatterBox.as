package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Owen Jones
	 */
	public class ChatterBox extends FlxGroup
	{
		private var _text:FlxText;
		private var _maxLines:int;
		private var _width:uint;
		private var _numLines:int = 0;

		private var _fadeOutDelay:Number = 0;
		private var _RESETFADEOUTDELAY:Number = 0;
		private var _fadeOutCountDown:Number = 0;
		private var _RESETFADEOUTCOUNTDOWN:Number = 0;
		
		public function ChatterBox(X:Number, Y:Number, Width:uint, Text:String = null, MaxLines:int = 5) 
		{
			super();
			_maxLines = MaxLines;
			_width = Width;
			if (Text) {
				text = Text;
			}
			resetFadeOutDelay();
		}
		public function set text(Text:String):void 
		{
			//FlxG.log(_numLines + " " + lines);
			add(new FlxText(0, _numLines * 10, _width, Text));
			_numLines += 1;
		}
		public function set maxLines(Max:int):void 
		{
			_maxLines = Max;
		}
		public function get maxLines():int 
		{
			return _maxLines;
		}

		public function set fadeOutDelay(Delay:int):void 
		{
			if (Delay < 0) {
				FlxG.log("Delay cannot be less than 0");
			}else{
				_fadeOutDelay = Delay;
				_RESETFADEOUTDELAY = Delay;
			}
		}
		public function set fadeOutTimer(Delay:int):void 
		{
			if (Delay < 0) {
				FlxG.log("Delay cannot be less than 0");
			}else{
				_fadeOutCountDown = Delay;
				_RESETFADEOUTCOUNTDOWN = Delay;
			}
		}
		override public function update():void 
		{
			if (countLiving() > _maxLines) {
				var first:FlxText = getFirstAlive() as org.flixel.FlxText;
				//FlxG.log(first + " " + first.x + ": " + first.text);	
				if(_fadeOutCountDown <= 0){
					first.alpha = 0;
				}else {
					if(_fadeOutDelay <= 0){
						first.alpha = _fadeOutCountDown -= FlxG.elapsed;
					}
				}
				if (first.alpha <= 0) {
					first.kill();
					_numLines -= 1;
					FlxG.log("done!");
					resetFadeOutCountdown();
					resetFadeOutDelay();
					for each(var eachText:FlxText in members) {
						eachText.y = eachText.y - 10;
					}					
				}
			}
			_fadeOutDelay -= FlxG.elapsed;
			super.update();
		}
		private function resetFadeOutDelay():void 
		{
			_fadeOutDelay = _RESETFADEOUTDELAY;
			FlxG.log("starting at: " + _fadeOutDelay);
		}
		private function resetFadeOutCountdown():void 
		{
			_fadeOutCountDown = _RESETFADEOUTCOUNTDOWN;
		}
	}
}