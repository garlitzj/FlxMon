package  
{
	import org.flixel.*;
	
	public class StatsTable
	{
		[Embed(source = "sound/encounter.mp3")] public static var SndEncounter:Class;
		
		// motherfucker
		
		public static var myMonster:int;
		public static var myMonsterLevel:int;
		public static var myBattleType:int;
		
		
		public static const TotalMonsters:int = 28;
		
		public static var MonsterStatus:Array = new Array(TotalMonsters); // 0 = not caught; 1 = dead; 2 = fine
		public static var MonsterHP:Array = new Array(TotalMonsters);
		public static var MonsterHPMax:Array = new Array(TotalMonsters);
		public static var MonsterHPMod:Array = new Array(TotalMonsters); // values: base per level, level-based mod
		public static var MonsterSP:Array = new Array(TotalMonsters);
		public static var MonsterSPMax:Array = new Array(TotalMonsters);
		public static var MonsterEXP:Array = new Array(TotalMonsters);
		public static var MonsterEXPMod:Array = new Array(TotalMonsters); // values: base requirement, level based mod
		public static var MonsterLevel:Array = new Array(TotalMonsters);
		public static var MonsterAttack:Array = new Array(TotalMonsters); // These are MODIFIER arrays, which determine the stat in a separate formula
																		  // First value is base statistic, second is the modifier
		public static var MonsterDefense:Array = new Array(TotalMonsters);
		public static var MonsterSpecial:Array = new Array(TotalMonsters);
		public static var MonsterSpeed:Array = new Array(TotalMonsters);
		public static var MonsterType:Array = new Array(TotalMonsters);
		public static var MonsterSkills:Array = new Array(TotalMonsters);
		public static var MonsterSkillSet:Array = new Array(TotalMonsters);
		public static var MonsterGraphicID:Array = new Array(TotalMonsters);
		
		public static var Inventory:Array = new Array();
		public static var Money:int;
		public static var PlayTime:Number = 60;
		public static var Battles:int;
		public static var TreasureTotal:int;
		public static var KeyOne:int = 0;
		public static var KeyTwo:int = 0;
		public static var KeyThree:int = 0;
		public static var KeyFour:int = 0;
		
		public static var currentWorld:int = 0;
		public static var fromTeleport:int = 0;
		public static var tileMapMemory:String = "";
		public static var tileMapTreasure:Array = new Array();
		public static var tileMapOrbs:Array = new Array();
		public static var worldType:int;
		public static var MonstersOnFloor:int;
		public static var TreasuresInWorld:Array = new Array(8);
		public static var TotalTreasuresInWorld:Array = new Array(8);
		public static var TreasuresArray:Array = new Array();
		public static var OrbsArray:Array = new Array(); // assign orbs and treasures to each world
		OrbsArray[0] = new Array(1, 2, 4, 5);
		 
		public static var WorldsArray:Array = new Array(8);
		public static var FloorsArray:Array = new Array(); // the random floor IDs for each world, generated at the start of each teleport!
		// each world has a combination of potential floors, certain worlds have a mandatory floor with a fight against the "keymaster".
		// other floors are not required and thus create an element of randomness; can re-enter worlds; certain monsters can only be found on certain maps
		// bottom floor is always constant
		FloorsArray[0] = new Array(4, 4, 4, 4, 4, 4, 4, 4, 10);
		FloorsArray[1] = new Array(5, 5, 5, 5, 5, 5, 11);
		public static var floorPoint:int;
		public static var treasurePoint:int;
		public static var orbPoint:int;
		public static var thisFloorArray:Array = new Array(); // current world of random order
		
		public static var MonsterRoster:Array = new Array();
		
		public static var Region_Encounter:Array;
		
		// player stuff
		
		public static var playerX:int = -1;
		public static var playerY:int = -1;
		public static var playerDir:int = -1;
		public static var playerMap:int = -1;
		
		// switches / scripted events
		
		//public static var monsterOrbCondition:Boolean; // this is the global flag that determines whether or not you get the new monster
		public static var monsterOrbID:int = -1; // this is the ID of the monster you will receive
		public static var switchToAct:int = -1; // used to turn switches on after dialog, battle, etc.
		public static var switchToActPost:int = -1;
		public static var scriptedBattle:int = -1; // used to initiate a battle after dialog... if specified, switchToAct will be handled post battle
		public static var postBattle:Boolean; // do stuff post battle?
		public static var requiredItem:int; // required item for monster capture
		
		public static var Keys:Array;
		public static var Switch:Array = new Array(100); // switches prevent events from happening more than once
		public static var Triggers:Array = new Array(100); // triggers start off events
		public static var Treasure:Array = new Array(4); // boolean of treasure chests
				
		public static var testcounter:int;
		
		public static var song_id:String;
		public static var old_song:String;
						
		// beginning stats for monsters... hoo boy
		
		// spider
		MonsterLevel[0] = 3;
		MonsterHPMod[0] = new Array(2.7, .65);
		MonsterHP[0] = FormulaTable.getHP(MonsterHPMod[0], MonsterLevel[0]);
		MonsterHPMax[0] = MonsterHP[0];
		MonsterSP[0] = 20;
		MonsterSPMax[0] = 20;
		MonsterEXPMod[0] = new Array(15, 1.60);
		MonsterEXP[0] = 0;
		MonsterAttack[0] = new Array(10, 1.05);
		MonsterDefense[0] = new Array(8, 1.05);
		MonsterSpecial[0] = new Array(8, 1.15);
		MonsterSpeed[0] = new Array(8, .85);
		MonsterSkills[0] = new Array(10, 11, 16);
		
		// zombie
		
		MonsterLevel[1] = 5;
		MonsterHPMod[1] = new Array(3, .62);
		MonsterHP[1] = FormulaTable.getHP(MonsterHPMod[1], MonsterLevel[1]);
		MonsterHPMax[1] = MonsterHP[1];
		MonsterSP[1] = 10;
		MonsterSPMax[1] = 10;
		MonsterEXPMod[1] = new Array(15, 1.57);
		MonsterEXP[1] = 0;
		MonsterAttack[1] = new Array(12, 1.55);
		MonsterDefense[1] = new Array(8, 1.05);
		MonsterSpecial[1] = new Array(8, 0.85);
		MonsterSpeed[1] = new Array(8, .80);
		MonsterSkills[1] = new Array(0, 1, 2, 9);
		
		// ghost
		
		MonsterLevel[2] = 7;
		MonsterHPMod[2] = new Array(2.2, .60);
		MonsterHP[2] = FormulaTable.getHP(MonsterHPMod[2], MonsterLevel[2]);
		MonsterHPMax[2] = MonsterHP[2];
		MonsterSP[2] = 20;
		MonsterSPMax[2] = 20;
		MonsterEXPMod[2] = new Array(15, 1.57);
		MonsterEXP[2] = 0;
		MonsterAttack[2] = new Array(10, 1.35);
		MonsterDefense[2] = new Array(8, 1.05);
		MonsterSpecial[2] = new Array(8, 0.85);
		MonsterSpeed[2] = new Array(8, .80);
		MonsterSkills[2] = new Array(20, 9, 19);
		
		// Pumpkin
		
		MonsterLevel[3] = 10;
		MonsterHPMod[3] = new Array(2.1, .61);
		MonsterHP[3] = FormulaTable.getHP(MonsterHPMod[3], MonsterLevel[3]);
		MonsterHPMax[3] = MonsterHP[3];
		MonsterSP[3] = 25;
		MonsterSPMax[3] = 25;
		MonsterEXPMod[3] = new Array(15, 1.57);
		MonsterEXP[3] = 0;
		MonsterAttack[3] = new Array(7, 1.35);
		MonsterDefense[3] = new Array(8, 1.05);
		MonsterSpecial[3] = new Array(10, 0.85);
		MonsterSpeed[3] = new Array(9, .80);
		MonsterSkills[3] = new Array(8, 19, 20, 21);
		
		// slime
		MonsterLevel[4] = 5;
		MonsterHPMod[4] = new Array(2.4, .62);
		MonsterHP[4] = FormulaTable.getHP(MonsterHPMod[4], MonsterLevel[4]);
		MonsterHPMax[4] = MonsterHP[4];
		MonsterSP[4] = 30;
		MonsterSPMax[4] = 30;
		MonsterEXPMod[4] = new Array(10, 1.61);
		MonsterAttack[4] = new Array(8, 1.25);
		MonsterDefense[4] = new Array(7, 1.25);
		MonsterSpecial[4] = new Array(11, 1);
		MonsterSpeed[4] = new Array(7, .85);
		MonsterEXP[4] = 0;
		MonsterSkills[4] = new Array(1, 12, 16);
		
		// bat
		MonsterLevel[5] = 5;
		MonsterHPMod[5] = new Array(2.4, .60);
		MonsterHP[5] = FormulaTable.getHP(MonsterHPMod[5], MonsterLevel[5]);
		MonsterHPMax[5] = MonsterHP[5];
		MonsterSP[5] = 35;
		MonsterSPMax[5] = 35;
		MonsterEXPMod[5] = new Array(12, 1.37);
		MonsterAttack[5] = new Array(10, 1.25);
		MonsterDefense[5] = new Array(5, 1.25);
		MonsterSpecial[5] = new Array(7, 1);
		MonsterSpeed[5] = new Array(8, 1.25);
		MonsterSkills[5] = new Array(0, 1, 19);
		MonsterEXP[5] = 0;
		
		// Snake
		
		MonsterLevel[6] = 3;
		MonsterHPMod[6] = new Array(2.0, .60);
		MonsterHP[6] = FormulaTable.getHP(MonsterHPMod[6], MonsterLevel[6]);
		MonsterHPMax[6] = MonsterHP[6];
		MonsterSP[6] = 15;
		MonsterSPMax[6] = 15;
		MonsterEXPMod[6] = new Array(15, 1.47);
		MonsterEXP[6] = 0;
		MonsterAttack[6] = new Array(8, 1.35);
		MonsterDefense[6] = new Array(7, 1.05);
		MonsterSpecial[6] = new Array(9, 0.85);
		MonsterSpeed[6] = new Array(8, .80);
		MonsterSkills[6] = new Array(9, 16, 17);
		
		// Skeleton
		
		MonsterLevel[7] = 10;
		MonsterHPMod[7] = new Array(3, .68);
		MonsterHP[7] = FormulaTable.getHP(MonsterHPMod[7], MonsterLevel[7]);
		MonsterHPMax[7] = MonsterHP[7];
		MonsterSP[7] = 12;
		MonsterSPMax[7] = 12;
		MonsterEXPMod[7] = new Array(15, 1.47);
		MonsterEXP[7] = 0;
		MonsterAttack[7] = new Array(13, 1.35);
		MonsterDefense[7] = new Array(5, 1.00);
		MonsterSpecial[7] = new Array(5, 0.85);
		MonsterSpeed[7] = new Array(8, .80);
		MonsterSkills[7] = new Array(3, 6, 20);
		
		// fighter
		MonsterLevel[8] = 5;
		MonsterHPMod[8] = new Array(5, .47);
		MonsterHP[8] = FormulaTable.getHP(MonsterHPMod[8], MonsterLevel[8]);
		MonsterHPMax[8] = MonsterHP[8];
		MonsterSP[8] = 20;
		MonsterSPMax[8] = 20;
		MonsterEXPMod[8] = new Array(15, 1.65);
		MonsterAttack[8] = new Array(12, 1.25);
		MonsterDefense[8] = new Array(13, 1.25);
		MonsterSpecial[8] = new Array(5, .95);
		MonsterSpeed[8] = new Array(7, .85);
		MonsterSkills[8] = new Array(0, 1, 2, 3, 4, 5, 12);
		MonsterEXP[8] = 0;
		
		// Witch
		
		MonsterLevel[9] = 15;
		MonsterHPMod[9] = new Array(1.56, .38);
		MonsterHP[9] = FormulaTable.getHP(MonsterHPMod[9], MonsterLevel[9]);
		MonsterHPMax[9] = MonsterHP[9];
		MonsterSP[9] = 30;
		MonsterSPMax[9] = 30;
		MonsterEXPMod[9] = new Array(15, 1.67);
		MonsterEXP[9] = 0;
		MonsterAttack[9] = new Array(5, 1.35);
		MonsterDefense[9] = new Array(5, 1.05);
		MonsterSpecial[9] = new Array(12, 0.85);
		MonsterSpeed[9] = new Array(8, .80);
		MonsterSkills[9] = new Array(23, 25, 26, 27);
		
		// Troll
		
		MonsterLevel[10] = 15;
		MonsterHPMod[10] = new Array(6.2, .38);
		MonsterHP[10] = FormulaTable.getHP(MonsterHPMod[10], MonsterLevel[10]);
		MonsterHPMax[10] = MonsterHP[10];
		MonsterSP[10] = 30;
		MonsterSPMax[10] = 30;
		MonsterEXPMod[10] = new Array(15, 1.67);
		MonsterEXP[10] = 0;
		MonsterAttack[10] = new Array(12, 1.35);
		MonsterDefense[10] = new Array(12, 1.05);
		MonsterSpecial[10] = new Array(5, 0.85);
		MonsterSpeed[10] = new Array(6, .80);
		MonsterSkills[10] = new Array(2, 4, 8);
		
		// Gargoyle

		MonsterLevel[11] = 12;
		MonsterHPMod[11] = new Array(4.8, .45);
		MonsterHP[11] = FormulaTable.getHP(MonsterHPMod[11], MonsterLevel[11]);
		MonsterHPMax[11] = MonsterHP[11];
		MonsterSP[11] = 20;
		MonsterSPMax[11] = 20;
		MonsterEXPMod[11] = new Array(14, 1.60);
		MonsterEXP[11] = 0;
		MonsterAttack[11] = new Array(10, 1.25);
		MonsterDefense[11] = new Array(10, 1.25);
		MonsterSpecial[11] = new Array(7, .95);
		MonsterSpeed[11] = new Array(7, .85);
		MonsterSkills[11] = new Array(0, 4, 20, 25);
		
		// Mastermind

		MonsterLevel[12] = 15;
		MonsterHPMod[12] = new Array(4.0, .45);
		MonsterHP[12] = FormulaTable.getHP(MonsterHPMod[12], MonsterLevel[12]);
		MonsterHPMax[12] = MonsterHP[12];
		MonsterSP[12] = 30;
		MonsterSPMax[12] = 30;
		MonsterEXPMod[12] = new Array(17, 1.60);
		MonsterEXP[12] = 0;
		MonsterAttack[12] = new Array(8, 1.25);
		MonsterDefense[12] = new Array(8, 1.25);
		MonsterSpecial[12] = new Array(12, .95);
		MonsterSpeed[12] = new Array(7, .85);
		MonsterSkills[12] = new Array(11, 16, 25);
		
		// Vampire

		MonsterLevel[13] = 10;
		MonsterHPMod[13] = new Array(3.8, .55);
		MonsterHP[13] = FormulaTable.getHP(MonsterHPMod[13], MonsterLevel[13]);
		MonsterHPMax[13] = MonsterHP[13];
		MonsterSP[13] = 30;
		MonsterSPMax[13] = 30;
		MonsterEXPMod[13] = new Array(14, 1.60);
		MonsterEXP[13] = 0;
		MonsterAttack[13] = new Array(8, 1.35);
		MonsterDefense[13] = new Array(6, 1.25);
		MonsterSpecial[13] = new Array(12, .95);
		MonsterSpeed[13] = new Array(10, .85);
		MonsterSkills[13] = new Array(17, 19, 4);
		
		// EvilTree

		MonsterLevel[14] = 17;
		MonsterHPMod[14] = new Array(5.8, .55);
		MonsterHP[14] = FormulaTable.getHP(MonsterHPMod[14], MonsterLevel[14]);
		MonsterHPMax[14] = MonsterHP[14];
		MonsterSP[14] = 20;
		MonsterSPMax[14] = 20;
		MonsterEXPMod[14] = new Array(15, 1.62);
		MonsterEXP[14] = 0;
		MonsterAttack[14] = new Array(12, 1.35);
		MonsterDefense[14] = new Array(10, 1.25);
		MonsterSpecial[14] = new Array(7, .95);
		MonsterSpeed[14] = new Array(5, .85);
		MonsterSkills[14] = new Array(2, 5, 10, 18);
		
		public static function addMonster(myID:int, p:Player = null, msg:FlxGroup = null):void
		{
			MonsterStatus[myID] = 1;
			MonsterRoster.push(myID);
			
			// start up the experience
			
			for (var i:int = 0; i < MonsterLevel[myID] - 1; i++)
				MonsterEXP[myID] += FormulaTable.requiredPoints(MonsterEXPMod[myID], i);
			
			// add any post fight messages
		}
		
		public static function scriptBattle(p:Player):void
		{
			
			// scripted event, enemies
			
			switch(scriptedBattle)
			{
				case 0: myBattleType = 1; break;
				case 1: myMonster = monsterOrbID; myMonsterLevel = MonsterLevel[monsterOrbID]; myBattleType = 2; break;
				case 2: myMonster = monsterOrbID; myMonsterLevel = MonsterLevel[monsterOrbID]; myBattleType = 3; break;
			}
			
			playerX = p.x;
			playerY = p.y;
			playerDir = p.dir;
			playerMap = FieldState.map_id;
			old_song = "battle";
			song_id = "";
			
			FlxG.music.stop();
			FieldState.freeze = true;
			
			FlxG.play(SndEncounter);
			FlxG.fade.start(0xff000000, 1, startScriptedBattle);
			
			
		}
		
		public static function startRandomBattle(p:Player):void
		{
			playerX = p.encounterX;
			playerY = p.encounterY;
			playerDir = p.dir;
			playerMap = FieldState.map_id;
			old_song = "battle";
			song_id = "";
						
			// calculate the enemy level and monster type here
			
			var base:int = Math.floor(FieldState.encounterDifficulty[0] - (FieldState.encounterDifficulty[1] / 2));
			var enemyLevel:int = base + Math.round(base + Math.random() * FieldState.encounterDifficulty[1]);
			
			var enemyID:int = Math.round(Math.random() * FieldState.encounterList.length);
			FlxG.play(SndEncounter);
			FlxG.state = new BattleState(MonsterRoster[0], FieldState.encounterList[enemyID], enemyLevel);
		}
		
		public static function startScriptedBattle():void
		{
			switch(myBattleType)
			{
				case 1: FlxG.state = new BattleState(MonsterRoster[0], myMonster, myMonsterLevel, 1); break; // boss battle
				case 2: FlxG.state = new BattleState(MonsterRoster[0], myMonster, myMonsterLevel, 2); break; // capture by winning
				case 3: FlxG.state = new BattleState(MonsterRoster[0], myMonster, myMonsterLevel, 2, 1, requiredItem); break; // capture by item
			}
		}
		
		public static function levelUp(monster_id:int = 0):void
		{
			MonsterLevel[monster_id] += 1;
			MonsterHPMax[monster_id] = FormulaTable.getHP(MonsterHPMod[monster_id], MonsterLevel[monster_id]);
		}
		
		public static function shuffleMap(worldID:int):void
		{
			thisFloorArray = new Array();
			var arr:Array = FloorsArray[worldID];
			
			
			while (arr.length > 1) {
				thisFloorArray.push(arr.splice(Math.round(Math.random() * (arr.length - 2)), 1)[0]);
			}
			
			thisFloorArray.push(arr[arr.length - 1]);
			
		}
		
		public static function handleSwitch():void
		{
			if (switchToAct > -1)
			{
				Switch[switchToAct] = 1;
				switchToAct = -1;
			}
			if (switchToActPost > -1)
			{
				Switch[switchToActPost] = 1;
				switchToActPost = -1;
			}
		}
		
	}

}