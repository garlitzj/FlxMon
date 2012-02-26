package  
{
	/*
	 *  This class will hold all the message box values, text data, etc.
	 *  Constants only! These are merely pieces of data that
	 *  are used for descriptions and messages
	 */
	
	public final class DataTable
	{
		[Embed(source = "graphics/monsters/Spider.png")] public static var imgFront0:Class;
		[Embed(source = "graphics/monsters/SpiderBack.png")] public static var imgBack0:Class;
		[Embed(source = "graphics/monsters/Zombie.png")] public static var imgFront1:Class;
		[Embed(source = "graphics/monsters/ZombieBack.png")] public static var imgBack1:Class;
		[Embed(source = "graphics/monsters/Ghost.png")] public static var imgFront2:Class;
		[Embed(source = "graphics/monsters/GhostBack.png")] public static var imgBack2:Class;
		[Embed(source = "graphics/monsters/Pumpkin.png")] public static var imgFront3:Class;
		[Embed(source = "graphics/monsters/PumpkinBack.png")] public static var imgBack3:Class;
		[Embed(source = "graphics/monsters/Slime.png")] public static var imgFront4:Class;
		[Embed(source = "graphics/monsters/SlimeBack.png")] public static var imgBack4:Class;
		[Embed(source = "graphics/monsters/Bat.png")] public static var imgFront5:Class;
		[Embed(source = "graphics/monsters/BatBack.png")] public static var imgBack5:Class;
		[Embed(source = "graphics/monsters/Snake.png")] public static var imgFront6:Class;
		[Embed(source = "graphics/monsters/SnakeBack.png")] public static var imgBack6:Class;
		[Embed(source = "graphics/monsters/Skeleton.png")] public static var imgFront7:Class;
		[Embed(source = "graphics/monsters/SkeletonBack.png")] public static var imgBack7:Class;
		[Embed(source = "graphics/monsters/Fighter.png")] public static var imgFront8:Class;
		[Embed(source = "graphics/monsters/FighterBack.png")] public static var imgBack8:Class;
		[Embed(source = "graphics/monsters/Witch.png")] public static var imgFront9:Class;
		[Embed(source = "graphics/monsters/WitchBack.png")] public static var imgBack9:Class;
		[Embed(source = "graphics/monsters/Troll.png")] public static var imgFront10:Class;
		[Embed(source = "graphics/monsters/TrollBack.png")] public static var imgBack10:Class;
		[Embed(source = "graphics/monsters/Gargoyle.png")] public static var imgFront11:Class;
		[Embed(source = "graphics/monsters/GargoyleBack.png")] public static var imgBack11:Class;
		[Embed(source = "graphics/monsters/Mastermind.png")] public static var imgFront12:Class;
		[Embed(source = "graphics/monsters/MastermindBack.png")] public static var imgBack12:Class;
		[Embed(source = "graphics/monsters/Vampire.png")] public static var imgFront13:Class;
		[Embed(source = "graphics/monsters/VampireBack.png")] public static var imgBack13:Class;
		[Embed(source = "graphics/monsters/EvilTree.png")] public static var imgFront14:Class;
		[Embed(source = "graphics/monsters/EvilTreeBack.png")] public static var imgBack14:Class;
		[Embed(source = "graphics/monsters/Jason.png")] public static var imgFront15:Class;
		[Embed(source = "graphics/monsters/JasonBack.png")] public static var imgBack15:Class;
		[Embed(source = "graphics/monsters/Gremlin.png")] public static var imgFront16:Class;
		[Embed(source = "graphics/monsters/GremlinBack.png")] public static var imgBack16:Class;
		[Embed(source = "graphics/monsters/Goblin.png")] public static var imgFront17:Class;
		[Embed(source = "graphics/monsters/GoblinBack.png")] public static var imgBack17:Class;
		[Embed(source = "graphics/monsters/Oni.png")] public static var imgFront18:Class;
		[Embed(source = "graphics/monsters/OniBack.png")] public static var imgBack18:Class;
		[Embed(source = "graphics/monsters/Eyeball.png")] public static var imgFront19:Class;
		[Embed(source = "graphics/monsters/EyeballBack.png")] public static var imgBack19:Class;
		[Embed(source = "graphics/monsters/Horseman.png")] public static var imgFront20:Class;
		[Embed(source = "graphics/monsters/HorsemanBack.png")] public static var imgBack20:Class;
		[Embed(source = "graphics/monsters/Spirit.png")] public static var imgFront21:Class;
		[Embed(source = "graphics/monsters/SpiritBack.png")] public static var imgBack21:Class;
		[Embed(source = "graphics/monsters/Frankenstein.png")] public static var imgFront22:Class;
		[Embed(source = "graphics/monsters/FrankensteinBack.png")] public static var imgBack22:Class;
		[Embed(source = "graphics/monsters/Wizard.png")] public static var imgFront23:Class;
		[Embed(source = "graphics/monsters/WizardBack.png")] public static var imgBack23:Class;
		[Embed(source = "graphics/monsters/SkeleFish.png")] public static var imgFront24:Class;
		[Embed(source = "graphics/monsters/SkeleFishBack.png")] public static var imgBack24:Class;
		[Embed(source = "graphics/monsters/Boogie.png")] public static var imgFront25:Class;
		[Embed(source = "graphics/monsters/BoogieBack.png")] public static var imgBack25:Class;
		[Embed(source = "graphics/monsters/Martian.png")] public static var imgFront26:Class;
		[Embed(source = "graphics/monsters/MartianBack.png")] public static var imgBack26:Class;
		[Embed(source = "graphics/monsters/Shadow.png")] public static var imgFront27:Class;
		[Embed(source = "graphics/monsters/ShadowBack.png")] public static var imgBack27:Class;
		[Embed(source = "graphics/monsters/AlienLeader.png")] public static var imgFront28:Class;
		[Embed(source = "graphics/monsters/AlienLeaderBack.png")] public static var imgBack28:Class;
		
		internal static const Messages:Array = new Array(new Array());
		internal static const Description:Array = new Array();
		internal static const MenuBit:Array = new Array();
		internal static const MonsterNames:Array = new Array();
		internal static const HeroName:String = "Kim";
		internal static const ItemName:Array = new Array();
		internal static const ItemDesc:Array = new Array();
		internal static const ItemType:Array = new Array();
		internal static const ItemSub:Array = new Array();
		internal static const ItemCost:Array = new Array();
		internal static const ShopInventory:Array = new Array();
		internal static const SkillName:Array = new Array();
		internal static const SkillType:Array = new Array();
		internal static const SkillBP:Array = new Array();
		internal static const SkillSub:Array = new Array();
		internal static const SkillSubAlt:Array = new Array();
		internal static const SkillAccuracy:Array = new Array();
		internal static const SkillTime:Array = new Array();
		internal static const SkillDesc:Array = new Array();
		internal static const SkillAnimation:Array = new Array();
		internal static const SkillNumber:Array = new Array(); // number of attacks
		internal static const PlaceName:Array =  new Array();
		
		PlaceName[0] = "Garlic";
		PlaceName[1] = "Bacon";
		PlaceName[2] = "Key Master Shrine";
		
		Messages[0] = new Array("Not just anyone can enter here!", "It's too dangerous for kids like you!");
		Messages[1] = new Array("Welcome to " + PlaceName[0] + ".");
		Messages[2] = new Array("Dr. Gerund's Office");
		Messages[3] = new Array(PlaceName[2]);
		Messages[4] = new Array("World 1\n5 Floors");
		Messages[5] = new Array("World 2\n7 Floors");
		Messages[6] = new Array("No human can beat a key master.", "Only those few who can call monsters", "stand a chance in combat!");
		Messages[7] = new Array("The world is dangerous.", "Monsters keep most people from", "leaving their homes.");
		Messages[8] = new Array("Use the Rest command when your", "monster's BP gets low during", "a battle.");
		Messages[9] = new Array("I keep hearing strange noises", "coming from that cave nearby.", "But, I'm too old to do anything...");
		Messages[10] = new Array("Route 1: to " + PlaceName[1]);
		Messages[11] = new Array("Hello, Kim. I called you here", "because you are a Negotiator.", "You can negotiate", "with certain monsters!", "Defeat the 4 KeyMasters and", "go to the world of riches!", "Monsters in orbs will join you.", "Although they may test you!", "Take this one and get started!", "And then travel to the key cave", "southeast of here.");
		Messages[12] = new Array("Now go! Communicate with", "any orbs you find and get monsters", "to join your team.");
		Messages[13] = new Array("Kim negotiated with the", "monster. And...", "...");
		Messages[14] = new Array("You can negotiate?", "Then go ahead!");
		Messages[15] = new Array("So you've reached the end", "of my world!", "Prove your worth by", "fighting me, and I shall", "join you!");
		
		MenuBit[0] = "Item";
		MenuBit[1] = "Team";
		MenuBit[2] = "Stats";
		MenuBit[3] = "Save";
		
		MonsterNames[0] = "Spider";
		MonsterNames[1] = "Zombie";
		MonsterNames[2] = "Ghost";
		MonsterNames[3] = "Pumpkin";
		MonsterNames[4] = "Slime";
		MonsterNames[5] = "Bat";
		MonsterNames[6] = "Snake";
		MonsterNames[7] = "Skeleton";
		MonsterNames[8] = "Fighter";
		MonsterNames[9] = "Witch";
		MonsterNames[10] = "Troll";
		MonsterNames[11] = "Gargoyle";
		MonsterNames[12] = "Mastermind";
		MonsterNames[13] = "Vampire";
		MonsterNames[14] = "EvilTree";
		MonsterNames[15] = "Jason";
		MonsterNames[16] = "Gremlin";
		MonsterNames[17] = "Goblin";
		MonsterNames[18] = "Oni";
		MonsterNames[19] = "Eyeball";
		MonsterNames[20] = "Horseman";
		MonsterNames[21] = "Spirit";
		MonsterNames[22] = "Frankenstein";
		MonsterNames[23] = "Wizard";
		MonsterNames[24] = "SkeleFish";
		MonsterNames[25] = "Boogey";
		MonsterNames[26] = "Martian";
		MonsterNames[27] = "Shadow";
		MonsterNames[28] = "Alien Leader";
		
		// items
		
		ItemName[0] = "Potion";
		ItemName[1] = "Antidote";
		ItemName[2] = "Ether Ore";
		ItemName[3] = "CoolRock";
		ItemName[4] = "Brains";
		ItemName[5] = "Mushroom";
		ItemName[6] = "Weed";
		
		ItemDesc[0] = "Restores 50 HP to leader";
		ItemDesc[1] = "Restores status in battle";
		ItemDesc[2] = "Restores all BP in battle";
		ItemDesc[3] = "Increase leader's level by one";
		ItemDesc[4] = "Braiinnnsss..";
		ItemDesc[5] = "Restores some HP";
		ItemDesc[6] = "Restores half BP in battle";
		
		/*
		 * item types: 
		 * 0: healing
		 * 1: restore status
		 * 2: restore bp
		 * 3: invoke spell
		 * 4: level up out of battle
		 * 5: key item that you must hold
		 * 6: event item that can be used only at a certain spot
		 * 7: event item that can be used only at a certain battle
		 * 8: increase a stat permanently
		 * 9: increase a stat in battle
		 * 10: frenzy; set frenzy bonus = 3 in battle
		 * 11: half bp for a battle
		 * 
		*/
		
		ItemType[0] = 0;
		ItemType[1] = 1;
		ItemType[2] = 2;
		ItemType[3] = 4;
		ItemType[4] = 7;
		ItemType[5] = 0;
		ItemType[6] = 2;
		
		ItemSub[0] = 50;
		ItemSub[1] = 0;
		ItemSub[2] = 100;
		ItemSub[3] = 1;
		ItemSub[4] = 0;
		ItemSub[5] = 12;
		ItemSub[6] = 50;
		
		// cost
		
		ItemCost[0] = 5;
		ItemCost[1] = 10;
		ItemCost[2] = 5;
		ItemCost[3] = 400;
		ItemCost[4] = 0;
		ItemCost[5] = 2;
		ItemCost[6] = 4;
		
		// shops
		
		ShopInventory[0] = new Array(0, 1, 2);
		
		// skills
				
		// melee
		
		SkillName[0] = "Claw";
		SkillBP[0] = 3;
		SkillType[0] = 0; // type = melee
		SkillSub[0] = 8; // base damage
		SkillSubAlt[0] = .45; // attack modifier
		SkillAccuracy[0] = 95; // accuracy
		SkillTime[0] = 50;
		SkillNumber[0] = 1;
		SkillAnimation[0] = 1;
		
		SkillName[1] = "Strike";
		SkillBP[1] = 2;
		SkillType[1] = 0; // type = melee
		SkillSub[1] = 7; // base damage
		SkillSubAlt[1] = .45; // attack modifier
		SkillAccuracy[1] = 90; // accuracy
		SkillTime[1] = 50;
		SkillNumber[1] = 1;
		SkillAnimation[1] = 2;
		
		SkillName[2] = "Smash";
		SkillBP[2] = 5;
		SkillType[2] = 0; // type = melee
		SkillSub[2] = 6; // base damage
		SkillSubAlt[2] = .65; // attack modifier
		SkillAccuracy[2] = 80; // accuracy
		SkillTime[2] = 50;
		SkillNumber[2] = 1;
		SkillAnimation[2] = 2;
		
		SkillName[3] = "2xSlice";
		SkillBP[3] = 5;
		SkillType[3] = 0; // type = melee
		SkillSub[3] = 6; // base damage
		SkillSubAlt[3] = .65; // attack modifier
		SkillAccuracy[3] = 85; // accuracy
		SkillTime[3] = 35;
		SkillNumber[3] = 2;
		SkillAnimation[3] = 0;
		
		SkillName[4] = "Punch";
		SkillBP[4] = 7;
		SkillType[4] = 0; // type = melee
		SkillSub[4] = 8; // base damage
		SkillSubAlt[4] = .55; // attack modifier
		SkillAccuracy[4] = 95; // accuracy
		SkillTime[4] = 50;
		SkillNumber[4] = 1;
		SkillAnimation[4] = 2;
		
		SkillName[5] = "Fury";
		SkillBP[5] = 10;
		SkillType[5] = 0; // type = melee
		SkillSub[5] = 6; // base damage
		SkillSubAlt[5] = .45; // attack modifier
		SkillAccuracy[5] = 75; // accuracy
		SkillTime[5] = 25;
		SkillNumber[5] = 5;
		SkillAnimation[5] = 0;
		
		SkillName[6] = "Slice";
		SkillBP[6] = 3;
		SkillType[6] = 0; // type = melee
		SkillSub[6] = 8; // base damage
		SkillSubAlt[6] = .50; // attack modifier
		SkillAccuracy[6] = 95; // accuracy
		SkillTime[6] = 25;
		SkillNumber[6] = 1;
		SkillAnimation[6] = 0;
		
		SkillName[7] = "Slash";
		SkillBP[7] = 7;
		SkillType[7] = 0; // type = melee
		SkillSub[7] = 8; // base damage
		SkillSubAlt[7] = .60; // attack modifier
		SkillAccuracy[7] = 95; // accuracy
		SkillTime[7] = 25;
		SkillNumber[7] = 1;
		SkillAnimation[7] = 0;
		
		SkillName[8] = "Tackle";
		SkillBP[8] = 5;
		SkillType[8] = 0; // type = melee
		SkillSub[8] = 8; // base damage
		SkillSubAlt[8] = .55; // attack modifier
		SkillAccuracy[8] = 85; // accuracy
		SkillTime[8] = 35;
		SkillNumber[8] = 1;
		SkillAnimation[8] = 2;
		
		SkillName[9] = "Bite";
		SkillBP[9] = 5;
		SkillType[9] = 0; // type = melee
		SkillSub[9] = 8; // base damage
		SkillSubAlt[9] = .50; // attack modifier
		SkillAccuracy[9] = 95; // accuracy
		SkillTime[9] = 35;
		SkillNumber[9] = 1;
		SkillAnimation[9] = 4;
		
		SkillName[10] = "DeathBlow";
		SkillBP[10] = 10;
		SkillType[10] = 0; // type = melee
		SkillSub[10] = 13; // base damage
		SkillSubAlt[10] = 1.50; // attack modifier
		SkillAccuracy[10] = 35; // accuracy
		SkillTime[10] = 35;
		SkillNumber[10] = 1;
		SkillAnimation[10] = 0;
		
		// buffs
		
		SkillName[11] = "AtkUp";
		SkillBP[11] = 7;
		SkillType[11] = 1; // type = buff
		SkillSub[11] = 0; // type: 0-3 = atk, def, spd, spc up; 4 = accuracy up;
		SkillSubAlt[11] = 0; // attack modifier
		SkillAccuracy[11] = 100; // accuracy
		SkillTime[11] = 35;
		SkillNumber[11] = 1;
		SkillAnimation[11] = 5;
		
		SkillName[12] = "DefUp";
		SkillBP[12] = 7;
		SkillType[12] = 1; // type = buff
		SkillSub[12] = 1; // type: 0-3 = atk, def, spd, spc up; 4 = accuracy up;
		SkillSubAlt[12] = 0; // attack modifier
		SkillAccuracy[12] = 100; // accuracy
		SkillTime[12] = 35;
		SkillNumber[12] = 1;
		SkillAnimation[12] = 5;
		
		SkillName[13] = "SpdUp";
		SkillBP[13] = 7;
		SkillType[13] = 1; // type = buff
		SkillSub[13] = 2; // type: 0-3 = atk, def, spd, spc up; 4 = accuracy up;
		SkillSubAlt[13] = 0; // attack modifier
		SkillAccuracy[13] = 100; // accuracy
		SkillTime[13] = 35;
		SkillNumber[13] = 1;
		SkillAnimation[13] = 5;
		
		SkillName[14] = "SpcUp";
		SkillBP[14] = 7;
		SkillType[14] = 1; // type = buff
		SkillSub[14] = 3; // type: 0-3 = atk, def, spd, spc up; 4 = accuracy up;
		SkillSubAlt[14] = 0; // attack modifier
		SkillAccuracy[14] = 100; // accuracy
		SkillTime[14] = 35;
		SkillNumber[14] = 1;
		SkillAnimation[14] = 5;
		
		SkillName[15] = "Focus";
		SkillBP[15] = 10;
		SkillType[15] = 1; // type = buff
		SkillSub[15] = 4; // type: 0-3 = atk, def, spd, spc up; 4 = accuracy up;
		SkillSubAlt[15] = 0; // attack modifier
		SkillAccuracy[15] = 100; // accuracy
		SkillTime[15] = 35;
		SkillNumber[15] = 1;
		SkillAnimation[15] = 5;
		
		// special/debuff
		
		SkillName[16] = "Poison";
		SkillBP[16] = 7;
		SkillType[16] = 2; // type = special
		SkillSub[16] = 0; // type: 0 = psn; 1 = bloodsuck; 2-5 = lower atk/def/spd/spc; 6 = revenge
		SkillSubAlt[16] = 0; // attack modifier if applicable
		SkillAccuracy[16] = 80; // accuracy
		SkillTime[16] = 35;
		SkillNumber[16] = 1;
		SkillAnimation[16] = 5;
		
		SkillName[17] = "BloodSuck";
		SkillBP[17] = 5;
		SkillType[17] = 2; // type = special
		SkillSub[17] = 1; // type: 0 = psn; 1 = bloodsuck; 2-5 = lower atk/def/spd/spc; 6 = revenge
		SkillSubAlt[17] = .55; // attack modifier if applicable
		SkillAccuracy[17] = 90; // accuracy
		SkillTime[17] = 35;
		SkillNumber[17] = 1;
		SkillAnimation[17] = 4;
		
		SkillName[18] = "Absorb";
		SkillBP[18] = 8;
		SkillType[18] = 2; // type = special
		SkillSub[18] = 1; // type: 0 = psn; 1 = bloodsuck; 2-5 = lower atk/def/spd/spc; 6 = revenge
		SkillSubAlt[18] = .65; // attack modifier if applicable
		SkillAccuracy[18] = 85; // accuracy
		SkillTime[18] = 35;
		SkillNumber[18] = 1;
		SkillAnimation[18] = 3;
		
		SkillName[19] = "Laugh";
		SkillBP[19] = 7;
		SkillType[19] = 2; // type = special
		SkillSub[19] = 2; // type: 0 = psn; 1 = bloodsuck; 2-5 = lower atk/def/spd/spc; 6 = revenge
		SkillSubAlt[19] = 0; // attack modifier if applicable
		SkillAccuracy[19] = 80; // accuracy
		SkillTime[19] = 35;
		SkillNumber[19] = 1;
		SkillAnimation[19] = 6;
		
		SkillName[20] = "Spook";
		SkillBP[20] = 7;
		SkillType[20] = 2; // type = special
		SkillSub[20] = 3; // type: 0 = psn; 1 = bloodsuck; 2-5 = lower atk/def/spd/spc; 6 = revenge
		SkillSubAlt[20] = 0; // attack modifier if applicable
		SkillAccuracy[20] = 80; // accuracy
		SkillTime[20] = 35;
		SkillNumber[20] = 1;
		SkillAnimation[20] = 6;
		
		SkillName[21] = "Taunt";
		SkillBP[21] = 7;
		SkillType[21] = 2; // type = special
		SkillSub[21] = 4; // type: 0 = psn; 1 = bloodsuck; 2-4 = lower atk/def/accuracy; 5 = revenge
		SkillSubAlt[21] = 0; // attack modifier if applicable
		SkillAccuracy[21] = 80; // accuracy
		SkillTime[21] = 35;
		SkillNumber[21] = 1;
		SkillAnimation[21] = 6;
		
		SkillName[22] = "Revenge";
		SkillBP[22] = 10;
		SkillType[22] = 2; // type = special
		SkillSub[22] = 5; // type: 0 = psn; 1 = bloodsuck; 2-5 = lower atk/def/spd/spc; 6 = revenge
		SkillSubAlt[22] = 0; // attack modifier if applicable
		SkillAccuracy[22] = 50; // accuracy
		SkillTime[22] = 35;
		SkillNumber[22] = 1;
		SkillAnimation[22] = 0;
		
		// heal
		
		SkillName[23] = "Heal";
		SkillBP[23] = 7;
		SkillType[23] = 3; // type = heal
		SkillSub[23] = 40; // heal amount
		SkillSubAlt[23] = 0; //na
		SkillAccuracy[23] = 100; // accuracy
		SkillTime[23] = 35;
		SkillNumber[23] = 1;
		SkillAnimation[23] = 7;
		
		SkillName[24] = "HealMore";
		SkillBP[24] = 7;
		SkillType[24] = 3; // type = heal
		SkillSub[24] = 100; // heal amount
		SkillSubAlt[24] = 0; //na
		SkillAccuracy[24] = 100; // accuracy
		SkillTime[24] = 35;
		SkillNumber[24] = 1;
		SkillAnimation[24] = 7;
		
		// magic 
		
		SkillName[25] = "Fireball";
		SkillBP[25] = 7;
		SkillType[25] = 4; // type = magic
		SkillSub[25] = 30; // base
		SkillSubAlt[25] = .10; // modifier.. most magic is relatively fixed damage
		SkillAccuracy[25] = 100; // accuracy
		SkillTime[25] = 35;
		SkillNumber[25] = 1;
		SkillAnimation[25] = 8;
			
		SkillName[26] = "DarkBall";
		SkillBP[26] = 8;
		SkillType[26] = 4; // type = magic
		SkillSub[26] = 40; // base
		SkillSubAlt[26] = 0; // modifier.. most magic is relatively fixed damage
		SkillAccuracy[26] = 100; // accuracy
		SkillTime[26] = 35;
		SkillNumber[26] = 1;
		SkillAnimation[26] = 8;
		
		SkillName[27] = "Lightning";
		SkillBP[27] = 10;
		SkillType[27] = 4; // type = magic
		SkillSub[27] = 15; // base
		SkillSubAlt[27] = .10; // modifier.. most magic is relatively fixed damage
		SkillAccuracy[27] = 90; // accuracy
		SkillTime[27] = 35;
		SkillNumber[27] = 3;
		SkillAnimation[27] = 8;
		
		SkillName[28] = "EarthFury";
		SkillBP[28] = 15;
		SkillType[28] = 4; // type = magic
		SkillSub[28] = 10; // base
		SkillSubAlt[28] = .07; // modifier.. most magic is relatively fixed damage
		SkillAccuracy[28] = 80; // accuracy
		SkillTime[28] = 25;
		SkillNumber[28] = 6;
		SkillAnimation[28] = 8;
	}

}