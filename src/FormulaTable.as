package  
{

	public class FormulaTable
	{
		
		public static function getAttack(modifier:Array, level:int):int
		{
			var base:int = modifier[0];
			var myMod:Number = modifier[1];
			var myLevel:int = level;
			var myAttack:int;
			
			myAttack = (myLevel * myMod) + base + myMod;
			
			return myAttack;
		}
		
		public static function getDefense(modifier:Array, level:int):int
		{
			var base:int = modifier[0];
			var myMod:Number = modifier[1];
			var myLevel:int = level;
			var myDefense:int;
			
			myDefense = (myLevel * myMod) + base + myMod;
			
			return myDefense;
		}
		
		public static function getSpeed(modifier:Array, level:int):int
		{
			var base:int = modifier[0];
			var myMod:Number = modifier[1];
			var myLevel:int = level;
			var mySpeed:int;
			
			mySpeed = (myLevel * myMod) + base + myMod;
			
			return mySpeed;
		}
		
		public static function getSpecial(modifier:Array, level:int):int
		{
			var base:int = modifier[0];
			var myMod:Number = modifier[1];
			var myLevel:int = level;
			var mySpecial:int;
			
			mySpecial = (myLevel * myMod) + base + myMod;
			
			return mySpecial;
		}
		
		public static function requiredPoints(modifier:Array, level:int):int
		{
			var base:int = modifier[0];
			var myMod:Number = modifier[1];
			var myLevel:int = level;
			var result:int;
			
			result = base + (Math.pow(myLevel, myMod) * 10);
			
			return result;
		}
		
		public static function getHP(modifier:Array, level:int, standard:int = 20):int
		{
			var levelOneHP:int = standard;
			
			var base:Number = modifier[0];
			var myMod:Number = modifier[1];
			var myLevel:int = level;
			var result:int;
			
			result = (levelOneHP + ((base * myLevel) + ((myMod * 6.5) * (level * .80))));
			return result;
		}
		
		public static function getSkills(skillSet:Array, skillLevel:Array, currentLevel:int):Array
		{
			var mySkills:Array;
			
			return mySkills;
		}
		
	}

}