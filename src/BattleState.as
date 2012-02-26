package  
{
	import org.flixel.*;
	
	public class BattleState extends FlxState
	{
		[Embed(source = "music/alt_battle.mp3")] private var SngBattle:Class;
		[Embed(source = "music/event_battle.mp3")] private var SngBattle2:Class;
		[Embed(source = "music/boss_battle.mp3")] private var SngBattle3:Class;
		[Embed(source = "graphics/menu/battle_menu_bg.png")] private var ImgMe:Class;
		[Embed(source = "graphics/menu/battle_bg.png")] private var ImgMe2:Class;
		[Embed(source = "graphics/menu/battle_sub_menu.png")] private var ImgSub:Class;
		[Embed(source = "graphics/menu/message_box_battle.png")] private var ImgAnnounce:Class;
		[Embed(source = "font/Gamegirl.ttf", fontFamily = "GB")] public var	FontMenu:String;
		[Embed(source = "sound/enter.mp3")] private var SndEnter:Class;
		[Embed(source = "sound/healthup.mp3")] private var SndRest:Class;
		[Embed(source = "sound/bump.mp3")] private var SndBump:Class;
		[Embed(source = "sound/select.mp3")] private var SndSelect:Class;
		[Embed(source = "sound/explode.mp3")] private var SndMelee:Class;
		[Embed(source = "sound/jingle.mp3")] private var SndJingle:Class;
		
		// menu stuff
		
		private var backgroundImage:FlxSprite;
		private var hpText:FlxText;
		private var bpText:FlxText;
		private var commandText:FlxText;
		private var menuText:FlxText;
		private var myImage:Class;
		private var enemyImage:Class;
		private var enemyText:FlxText;
		private var playerSprite:FlxSprite;
		private var enemySprite:FlxSprite;
		private var playerBarSprite:FlxSprite;
		private var mainMenuCursor:MenuCursor;
		private var subMenuCursor:MenuCursor;
		private var subMenuDisplayCursor:DisplayCursor;
		private var subMenuBox:FlxSprite;
		private var subText:FlxText;
		private var subText2:FlxText;
		private var announceText:FlxText;
		private var announceBox:FlxSprite;
		
		// animation stuff
		
		private var runningAnim:Boolean = false;
		
		// player basics
		
		private var playerMonsterID:int;
		private var playerName:String;
		private var playerHP:int;
		private var playerHPMax:int;
		private var playerBP:int;
		private var playerBPMax:int;
		private var playerAttack:int;
		private var playerDefense:int;
		private var playerSpeed:int;
		private var playerSpecial:int;
		private var playerRate:int; // the rate of the player's bar
		private var playerStatus:int // status 0 = fine; 1 = poison
		
		// enemy basics
		
		private var enemyMonsterID:int;
		private var enemyName:String;
		private var enemyLevel:int;
		private var enemyHP:int;
		private var enemyHPMax:int;
		private var enemyAttack:int;
		private var enemyDefense:int;
		private var enemySpeed:int;
		private var enemySpecial:int;
		private var enemyRate:int; // the rate of the enemy's bar
		private var enemyStatus:int;
		
		// battle flow vars
		
		private var myBattleType:int;
		private var playerBar:int; // player's atb bar
		private var enemyBar:int; // enemy's atb bar
		private var playerTurn:Boolean = false;
		private var enemyTurn:Boolean = false;
		private var playerNumberAttacks:int; // number of attacks in a skill (e.g. double slice)
		private var enemyNumberAttacks:int;
		private var winMessage:int; // how much winning is going on
		private var winMax:int // when do we stop showing victory messages?
		private var enemySkillChoice:int; // what did the enemy choose to use?
		
		private var freeze:Boolean; // freeze everything?
		private var animationTimer:int; // animation timer
		private var animationHalf:int; // when to show damage display
		private var animation:Boolean; // is an animation current playing?
		private var calculatedDamage:int = -1; // calculated damage for display and subtraction
		private var calculatedDamage2:int = -1; // for the enemy
		private var playerMove:Boolean; // move forward to attack?
		private var enemyMove:Boolean; // move forward for certain moves
		
		private var playerAttackBonus:Boolean = false; // attack bonus?
		private var playerDefenseBonus:Boolean = false;
		private var playerSpeedBonus:Boolean = false;
		private var playerSpecialBonus:Boolean = false; 
		private var playerCrazyRounds:int = 0; // number of really high agility rounds
		
		private var enemyAttackBonus:Boolean = false;
		private var enemyDefenseBonus:Boolean = false;
		private var enemySpeedBonus:Boolean = false;
		private var enemySpecialBonus:Boolean = false;
		private var enemyCrazyRounds:int = 0; 
		
		// menu stuff
		
		private var subMenu:int = 0;
		private var subMenuType:int = 0; // item or skill ?
		private var cursorPos:int = 0;
		private var start:int = 0;
		private var end:int;
		private var page:int;
		private var per_page:int = 4;
		private var myCondition:int;
		private var mySubValue:int;
		private var announcement:Boolean;
		private var victoryFlag:Boolean;
		private var lossFlag:Boolean;
		private var lossVar:int = 0;
		private var itemFlag:Boolean;
		
		// event condition can either be victory or simply using an item... this pertains mostly to monster capture battles; battle type determines the music played
		
		public function BattleState(playerID:int, enemyID:int, enemyLev:int, battleType:int = 0, eventCondition:int = 0, eventSub:int = 0) 
		{
			playerMonsterID = playerID;
			playerName = DataTable.MonsterNames[playerID];
			playerHP = StatsTable.MonsterHP[playerID];
			playerHPMax = StatsTable.MonsterHPMax[playerID];
			playerBP = StatsTable.MonsterSP[playerID];
			playerBPMax = StatsTable.MonsterSPMax[playerID];
			playerAttack = FormulaTable.getAttack(StatsTable.MonsterAttack[playerID], StatsTable.MonsterLevel[playerID]);
			playerDefense = FormulaTable.getDefense(StatsTable.MonsterDefense[playerID], StatsTable.MonsterLevel[playerID]);
			playerSpecial = FormulaTable.getSpecial(StatsTable.MonsterSpecial[playerID], StatsTable.MonsterLevel[playerID]);
			playerSpeed = FormulaTable.getSpeed(StatsTable.MonsterSpeed[playerID], StatsTable.MonsterLevel[playerID]);
			
			enemyMonsterID = enemyID;
			enemyName = DataTable.MonsterNames[enemyID];
			enemyLevel = enemyLev;
			myBattleType = battleType;
			
			enemyHPMax = FormulaTable.getHP(StatsTable.MonsterHPMod[enemyMonsterID], enemyLevel, 17) * .70;
			enemyHP = enemyHPMax;
			enemyAttack = FormulaTable.getAttack(StatsTable.MonsterAttack[enemyMonsterID], enemyLevel - 1);
			enemyDefense = FormulaTable.getDefense(StatsTable.MonsterDefense[enemyMonsterID], enemyLevel);
			enemySpecial = FormulaTable.getSpecial(StatsTable.MonsterSpecial[enemyMonsterID], enemyLevel - 1);
			enemySpeed = FormulaTable.getSpeed(StatsTable.MonsterSpeed[enemyMonsterID], enemyLevel - 1); 
			
			myCondition = eventCondition;
			mySubValue = eventSub;
		}
		
		override public function create():void
		{
			
			switch(myBattleType)
			{
				default: FlxG.playMusic(SngBattle); break;
				case 1: FlxG.playMusic(SngBattle3); break;
				case 2: FlxG.playMusic(SngBattle2); break;
				case 3: FlxG.playMusic(SngBattle2); break;
			}
			
			
			backgroundImage = new FlxSprite(0, 0, ImgMe2);
			add(backgroundImage);
			
			myImage = DataTable["imgBack" + playerMonsterID];
			playerSprite = new FlxSprite(95, 52, myImage);
			add(playerSprite);
			
			enemyImage = DataTable["imgFront" + enemyMonsterID];
			enemySprite = new FlxSprite(10, 15, enemyImage);
			add(enemySprite);
			
			backgroundImage = new FlxSprite(0, 0, ImgMe);
			add(backgroundImage);
			
			hpText = new FlxText(1, 122, 88, "HP:\n" + playerHP.toString() + "/" + playerHPMax.toString());
			hpText.font = "GB";
			add(hpText);
			
			bpText = new FlxText(90, 122, 77, "BP:\n" + playerBP.toString() + "/" + playerBPMax.toString());
			bpText.font = "GB";
			add(bpText);
			
			enemyText = new FlxText(1, 1, 158, enemyName + "  LVL " + enemyLevel.toString());
			enemyText.font = "GB";
			add(enemyText);
			
			// add the player's atb bar
			
			playerBarSprite = new FlxSprite(6, 105);
			playerBarSprite.createGraphic(148, 8);
			playerBarSprite.scale.x = 0;
			add(playerBarSprite);
			
			// cursors and stuff
			
			mainMenuCursor = new MenuCursor(-1, 104, 3, 40, -1, 1);
			mainMenuCursor.visible = false;
			add(mainMenuCursor);
			
			// enemy stats
			
			// calculate relative agility
			
			playerRate = 1.5 * (playerSpeed / enemySpeed);
			enemyRate = 1.5 * (enemySpeed / playerSpeed);
			
			// more text .. !
			
			commandText = new FlxText(4, 102, 154, "Rush Rest Item Run");
			commandText.font = "GB";
			commandText.visible = false;
			add(commandText);
			
			// sub menu 
			
			subMenuBox = new FlxSprite(0, 64, ImgSub);
			subMenuBox.visible = false;
			add(subMenuBox);
			
			subMenuCursor = new MenuCursor(0, 75, 3, 17, -1);
			subMenuCursor.visible = false;
			add(subMenuCursor);
			
			subText = new FlxText(7, 71, 115);
			subText.font = "GB";
			subText.visible = false;
			add(subText);
			
			subText2 = new FlxText(86, 71, 30);
			subText2.font = "GB";
			subText2.visible = false;
			add(subText2);
			
			subMenuDisplayCursor = new DisplayCursor(55, 136);
			subMenuDisplayCursor.visible = false;
			add(subMenuDisplayCursor);
			
			// announcements + text
			
			announceBox = new FlxSprite(0, 0, ImgAnnounce);
			announceBox.visible = false;
			add(announceBox);
			
			announceText = new FlxText(1, 1, 154);
			announceText.font = "GB";
			announceText.visible = false;
			add(announceText);
			
			
		}
		
		override public function update():void
		{
			
			// update the HP stuff
			
			hpText.text = "HP:\n" + playerHP.toString() + "/" + playerHPMax.toString();
			bpText.text = "BP:\n" + playerBP.toString() + "/" + playerBPMax.toString();
			
			// check to see if anyone is dead yet...
			
			if (animationTimer <= 0)
			{
				if (victoryFlag == true)
				{
					youWin();
				}
				if (lossFlag == true)
				{
					youLose();
				}
			}
			
			// victory or loss "animation
			
			if (winMessage > 0 && itemFlag == false)
			{
				enemySprite.x -= 2;
				enemySprite.alpha -= .07;
			}
			
			if (lossFlag == true && lossVar > 0)
			{
				playerSprite.x += 2;
				playerSprite.alpha -= .07;
			}
			
			if (animationTimer > 0)
			{
				freeze = true;
				animationTimer -= FlxG.elapsed;
				
				if (animation == true && animationTimer <= animationHalf && animationHalf > 0)
				{
					// damage display
					animation = false;
					
					if (calculatedDamage > -1)
					{
						add(new DamageMarker(25, 20, calculatedDamage.toString(), 1));
						calculatedDamage = -1;
						animationHalf = 0;
					}
					else if(calculatedDamage == -2) // -2 is a flag for miss
					{
						add(new DamageMarker(25, 20, "Miss!", 0));
						animationHalf = 0;
						calculatedDamage = -1;
					}
					
					if (calculatedDamage2 > -1)
					{
						add(new DamageMarker(105, 55, calculatedDamage2.toString(), 1));
						calculatedDamage2 = -1;
						animationHalf = 0;
					}
					else if(calculatedDamage2 == -2) // -2 is a flag for miss
					{
						add(new DamageMarker(105, 55, "Miss!", 0));
						calculatedDamage2 = -1;
						animationHalf = 0;
					}
				}
				
				if (animationTimer <= 0)
				{
					animationTimer = 0;
					
					// the player or enemy is moved forward, move 'em back
					
					if (playerMove == true) // if this is the end of an the hero's turn
					{
						playerNumberAttacks -= 1;
						
						if (playerNumberAttacks <= 0)
						{
							// end the turn
							
							animation = false; // just in case
							freeze = false;
							announcement = false; // turn off the attack announcement
							playerMoveFoward(1);
						}
						else
						{
							// continue attacking
							freeze = true;
							playerMoveFoward(1);
							useSkill(1);
						}
					}
					
					if (enemyMove == true) // if this is the end of an the hero's turn
					{
						enemyNumberAttacks -= 1;
						
						if (enemyNumberAttacks <= 0)
						{
							// end the turn
							
							freeze = false;
							animation = false;
							announcement = false; // turn off the attack announcement
							enemyMoveFoward(1);
						}
						else
						{
							// continue attacking
							freeze = true;
							enemyMoveFoward(1);
							enemyUseSkill(1);
						}
					}
					
					else // general use of the timer, set freeze to false
					{
						freeze = false;
						announcement = false;
						
						if (winMessage > 0) // win stuff
						{
							if(winMessage >= winMax)
								battleVictory();
							else
								youWin(winMessage);
						}
					}
				}
			}
			
			// any bonus stuff here
			
			
			// running animation
			
			if (runningAnim == true)
			{
				playerSprite.x += FlxG.elapsed * 32;
				playerSprite.y += FlxG.elapsed * 32;
			}
			
			// game time stuff
			
			StatsTable.PlayTime += FlxG.elapsed;
			
			// actually battle logic
			
			if (freeze == false && victoryFlag == false && lossFlag == false && animation == false)
			{
				if (playerTurn == false && enemyTurn == false)
				{
					// increment the bars and reset the cursor
					
					mainMenuCursor.pos = 0;
					
					playerBar += playerRate;
					enemyBar += enemyRate;
					
					if (playerBar >= 100)
					{
						playerBar = 0;
						playerTurn = true;
						subMenu = 1;
						animationTimer = 8;
					}
					
					if (enemyBar >= 100)
					{
						enemyBar = 0;
						enemyTurn = true;
						animationTimer = 8;
						
						// change enemy's rate 
				
						enemyBar -= (enemyRate * (Math.random() * 7));
					}
					
					// prevent both enemy and player from attacking at same time
					
					if (playerTurn == true && enemyTurn == true)
					{
						enemyTurn = false;
						enemyBar = 80;
					}
					
					// the enemy will issue its attack
					
					if (enemyTurn == true)
					{
						freeze = true;
						enemyDecision();
					}
				}
				
				// z button stuff
				
				if (FlxG.keys.justPressed("Z"))
				{
					if (subMenu == 1)
					{
						if (mainMenuCursor.pos == 0) // fight
						{
							subMenu = 2;
							subMenuType = 1;
							animationTimer = 5;
							FlxG.play(SndSelect);
							
							subMenuCursor.internal_pos = 0;
							subMenuCursor.pos = 0;
							subMenuCursor.internalMax = StatsTable.MonsterSkills[playerMonsterID].length;
							page = 0;
							
							getSkills();
						}
						
						if (mainMenuCursor.pos == 1) // rest
						{
							restBreak();
						}
						
						if (mainMenuCursor.pos == 2) // item
						{
							if (StatsTable.Inventory.length > 0)
							{
								FlxG.play(SndSelect);
								subMenuCursor.internalMax = StatsTable.Inventory.length;
								subMenu = 2;
								subMenuType = 2;
								animationTimer = 5;
								
								subMenuCursor.internal_pos = 0;
								subMenuCursor.pos = 0;
								page = 0;
								
								getItems();
							}
							else
							{
								errorBump();
							}
						}
						
						if (mainMenuCursor.pos == 3) // run~~
						{
							// check if the player can run... do this later
							
							if (myBattleType == 0)
								runFromBattle();
							else
								errorBump();
						}
					}
					
					else if (subMenu == 2)
					{
						if (subMenuType == 1)
						{
							// skill use
							
							useSkill();
						}
						if (subMenuType == 2)
						{
							// item use
							
							useItem();
						}
					}
				}
				
				// x button stuff
				
				if (FlxG.keys.justPressed("X"))
				{
					if (subMenu == 2)
					{
						subMenu = 1;
						animationTimer = 5;
					}
				}
				
				// menu display and handling
				
				if (subMenu == 1)
				{
					mainMenuCursor.visible = true;
					mainMenuCursor.active = true;
					subMenuCursor.visible = false;
					subMenuCursor.active = false;
					
					subMenuBox.visible = false;
					subText.visible = false;
					subText2.visible = false;
					subMenuDisplayCursor.visible = false;
				}
				else if (subMenu == 2)
				{
					mainMenuCursor.visible = true;
					mainMenuCursor.active = false;
					subMenuCursor.visible = true;
					subMenuCursor.active = true;
					
					subMenuBox.visible = true;
					subText.visible = true;
					subMenuDisplayCursor.visible = true;
					
					// additional subtext if you're in the skill submenu... jesus christ
					
					if (subMenuType == 1)
						subText2.visible = true;
					else
						subText2.visible = false;
					
					// item pagination
					
					if (subMenuCursor.internal_pos > end - 2)
					{
						page++;
						subMenuCursor.pos = 0;
						
						if (subMenuType == 1)
							getSkills();
						else
							getItems();
					}
				
					if (subMenuCursor.internal_pos < start && start > 0)
					{
						page--;
						subMenuCursor.pos = per_page - 1;
						
						if (subMenuType == 1)
							getSkills();
						else
							getItems();
					}
				}
				else
				{
					mainMenuCursor.visible = false;
					mainMenuCursor.active = false;
					subMenuCursor.visible = false;
					subMenuCursor.active = false;
					
					subMenuBox.visible = false;
					subText.visible = false;
					subText2.visible = false;
					subMenuDisplayCursor.visible = false;
					
				}
				
				// bar display
				
				if (subMenu == 0)
				{
					playerBarSprite.scale.x = 1 * (playerBar / 100);
					playerBarSprite.origin.x = playerBarSprite.origin.y;
					playerBarSprite.visible = true;
					commandText.visible = false;
				}
				else
				{
					commandText.visible = true;
					playerBarSprite.visible = false;
				}
				
				// announcement display
				
				if (announcement == true)
				{
					announceBox.visible = true;
					announceText.visible = true;
				}
				else
				{
					announceBox.visible = false;
					announceText.visible = false;
				}
			}
			
			super.update();
		}
		
		private function getItems():void
		{
			start = per_page * page;
			end = start + (per_page) + 1;
			itemText();
		}
		
		private function itemText():void
		{
			var i:int = start;
			var temp:int = end;
			subMenuDisplayCursor.myState = 0;
			
			if (temp > StatsTable.Inventory.length)
			{
				temp = StatsTable.Inventory.length + 1; // set the cutoff to the end of inventory + offset of 1
				subMenuDisplayCursor.myState = 1;
			}
			
			subText.text = DataTable.ItemName[StatsTable.Inventory[i]] + "\n\n";
			
			for (i = start + 1; i < temp - 1; i++)
			{
				subText.text += DataTable.ItemName[StatsTable.Inventory[i]] + "\n\n";
			}
		}
		
		private function getSkills():void
		{
			start = per_page * page;
			end = start + (per_page) + 1;
			skillText();
		}
		
		private function skillText():void
		{
			var i:int = start;
			var temp:int = end;
			subMenuDisplayCursor.myState = 0;
			
			if (temp > StatsTable.MonsterSkills[playerMonsterID].length)
			{
				temp = StatsTable.MonsterSkills[playerMonsterID].length + 1; // set the cutoff to the end of inventory + offset of 1
				subMenuDisplayCursor.myState = 1;
			}
			
			subText.text = DataTable.SkillName[StatsTable.MonsterSkills[playerMonsterID][i]] + "\n\n";
			subText2.text = DataTable.SkillBP[StatsTable.MonsterSkills[playerMonsterID][i]] + "\n\n";
			
			for (i = start + 1; i < temp - 1; i++)
			{
				subText.text += DataTable.SkillName[StatsTable.MonsterSkills[playerMonsterID][i]] + "\n\n";
				subText2.text += DataTable.SkillBP[StatsTable.MonsterSkills[playerMonsterID][i]] + "\n\n";
			}
		}
		
		private function useSkill(multipleFlag:int = 0):void
		{
			var mySkillID:int = StatsTable.MonsterSkills[playerMonsterID][subMenuCursor.internal_pos];
			
			if (playerBP < DataTable.SkillBP[mySkillID] && multipleFlag == 0) // if this is the second use, ignore this
				errorBump();
			else
			{
				if(multipleFlag == 0)
					playerBP -= DataTable.SkillBP[mySkillID];
				
				// determine the skill type and act accordingly
				
				if (DataTable.SkillType[mySkillID] == 0)
				{
					meleeAttack(mySkillID, 0, multipleFlag);
				}
				else
				{
					animationTimer = 40;
				}
				
				// stuff all skills share (announcements, etc.)
				announcement = true;
				announceText.text = DataTable.SkillName[mySkillID] + "!";
				subMenu = 0;
				playerTurn = false;
				playerMoveFoward();
				
				if (enemyHP <= 0)
					victoryFlag = true;
			}
		}
		
		private function useItem():void
		{
			// check if the condition is met
			
			var validItem:Boolean;
			var eventItem:Boolean;
			var itemID:int = StatsTable.Inventory[subMenuCursor.internal_pos];
			
			// or if the item is the required one
			
			switch(DataTable.ItemType[itemID])
			{
				default: validItem = true; break;
				case 4: validItem = false; break;
				case 5: validItem = false; break;
				case 6: validItem = false; break;
				case 7: validItem = false; break;
				case 8: validItem = false; break;
			}
			
			if (myCondition == 1) 
			{
				if (itemID == mySubValue)
				{
					validItem = true;
					victoryFlag = true;
					itemFlag = true; // victory by item
					announcement = true;
					announceText.text = DataTable.ItemName[itemID];
					subMenu = 0;
					playerTurn = false;
					playerMoveFoward();
					StatsTable.Inventory.splice(subMenuCursor.internal_pos, 1);
					subMenuCursor.internalMax -= 1;
					FlxG.play(SndRest);
					animationTimer = 60;
				}
			}
			
			if (itemFlag == false)
			{
				if (validItem == true)
				{
					// use
					
					if (DataTable.ItemType[itemID] == 0)
					{
						restoreHP(DataTable.ItemSub[itemID]);
					}
					else if (DataTable.ItemType[itemID] == 1)
					{
						restoreStatus();
					}
					else if (DataTable.ItemType[itemID] == 2)
					{
						restBreak((DataTable.ItemSub[itemID] / 100 ) * playerBPMax);
					}
					else
					{
						animationTimer = 35;
					}
					
					// end use
					
					announcement = true;
					announceText.text = DataTable.ItemName[itemID];
					subMenu = 0;
					playerTurn = false;
					playerMoveFoward();
					StatsTable.Inventory.splice(subMenuCursor.internal_pos, 1);
					subMenuCursor.internalMax -= 1;
					
					if (enemyHP <= 0)
						victoryFlag = true;
				}
				else
				{
					errorBump();
				}
			}
		}
		
		private function youLose():void
		{
			lossVar = 1;
			freeze = true;
			enemyTurn = false;
			playerTurn = false;
			animationTimer = 90;
			announceText.text = DataTable.MonsterNames[playerMonsterID] + " died!";
			announcement = true;
			FlxG.fade.start(0xff000000, 2, returnToTitle);
		}
		
		private function youWin(amountOfWin:int = 0):void
		{
			winMessage++;
			
			// determine whether scripted battle stays or not based on the item thing
		
			StatsTable.scriptedBattle = -1;
			
			if (myCondition == 1 && itemFlag == false)
			{
				StatsTable.scriptedBattle = 1; // something arbitrary just to keep the monster from joining
			}
			
			if (amountOfWin == 0)
			{
				FlxG.music.stop(); // later on, play victory music
				
				if(winMax == 0)
					FlxG.play(SndJingle);
				
				animationTimer = 80;
				
				if(itemFlag == false)
					announceText.text = "You win!";
				else
					announceText.text = DataTable.MonsterNames[enemyMonsterID] + " is pleased!";
					
				announcement = true;
				winMax = 2;
				
				if (myCondition == 1 && itemFlag == false) // if you didn't give the item, no experience for you!
					winMax = 1;
				
			}
			else if (amountOfWin == 1)
			{
				animationTimer = 80;
				
				if (StatsTable.monsterOrbID > -1 && StatsTable.scriptedBattle == -1)
				{
					announcement = true;
					announceText.text = DataTable.MonsterNames[StatsTable.monsterOrbID] + " joined!";
					StatsTable.addMonster(StatsTable.monsterOrbID);
					StatsTable.monsterOrbID = -1;
					
				}
				else
				{
					// generate experience
					
					var amountEXP:int = FormulaTable.requiredPoints(StatsTable.MonsterEXPMod[enemyMonsterID], enemyLevel + 2);
					amountEXP /= 10;
					
					var amountMoney:int = enemyLevel * .75 + Math.random() * 3;
					
					amountMoney = Math.min(amountMoney, 999); // max amount to get is $999
					
					StatsTable.Money += amountMoney;
					
					// find out if the player leveled up, set winMax to 3 and keep things moving
					
					StatsTable.MonsterEXP[playerMonsterID] += amountEXP;
					
					var levelLoop:int = 0;
					var toNextLevel:int = 0;
					
					while (levelLoop == 0)
					{
						levelLoop = 1;
						
						for (var i:int = 0; i < StatsTable.MonsterLevel[playerMonsterID]; i++)
							toNextLevel += FormulaTable.requiredPoints(StatsTable.MonsterEXPMod[playerMonsterID], i);
						
						if (StatsTable.MonsterEXP[playerMonsterID] >= toNextLevel)
						{
							winMax = 3;
							levelLoop = 0;
							StatsTable.levelUp(playerMonsterID);
						}
					}
					
					announceText.text = amountEXP + " EXP! $" + amountMoney + "!";
					announcement = true;
				}
			}
			else if (amountOfWin == 2)
			{
				animationTimer = 60;
				
				FlxG.play(SndJingle);
				
				// find if any new skills were learned
				
				announcement = true;
				announceText.text = "Leveled up to " + StatsTable.MonsterLevel[playerMonsterID].toString();
			}
		}
		
		private function battleVictory():void
		{
			
			StatsTable.handleSwitch();
			
			
			
			freeze = true;
			animationTimer = 0;
			winMessage = -1;
			StatsTable.scriptedBattle = -1; // scripted battle is turned off, which will trigger any post battle text
			
			// if the condition wasn't met, turn off any variables that would reward the player
			
			
			// set the global vars for monster hp to what they are now
						
			FlxG.fade.start(0xff000000, 1.5, returnToMap);
		}
		
		private function runFromBattle():void
		{
			freeze = true;
			runningAnim = true;
			subMenu = 0;
			announceText.text = "Run!!";
			announcement = true;
			FlxG.play(SndEnter);
			FlxG.fade.start(0xff000000, 1, returnToMap);
		}
		
		private function returnToMap():void
		{
			StatsTable.scriptedBattle = -1 ;
			FieldState.freeze = false;
			StatsTable.MonsterHP[playerMonsterID] = playerHP;
			FlxG.state = new FieldState(StatsTable.playerX, StatsTable.playerY, StatsTable.playerMap, StatsTable.playerDir);
		}
		
		private function returnToTitle():void
		{
			// for now, just go back to the title
			
			FlxG.state = new TitleState();
		}
		
		private function restoreStatus():void
		{
			FlxG.play(SndRest);
			animationTimer = 50;
			playerStatus = 0;
			add(new DamageMarker(91, 56, "Cured!"));
		}
		
		private function restBreak(fixedAmount:int = 0):void
		{
			subMenu = 0;
			playerTurn = false;
			
			var amountRestored:int;
			animationTimer = 45;
			FlxG.play(SndRest);
			
			if(fixedAmount == 0) // rest!
				amountRestored = (Math.random() * 4) + (playerBPMax / 2.2);
			
			else
				amountRestored = fixedAmount;
				
			playerBP += amountRestored;
			
			if (playerBP > playerBPMax)
				playerBP = playerBPMax;
			
			if (fixedAmount)
			{
				announcement = true;
				announceText.text = DataTable.MonsterNames[playerMonsterID] + " rested!";
			}
			
			add(new DamageMarker(91, 56, "+" + amountRestored.toString() + " BP!"));
			
		}
		
		private function errorBump():void
		{
			animationTimer = 5;
			mainMenuCursor.timer = 5;
			subMenuCursor.timer = 5;
			FlxG.play(SndBump);
			FlxG.quake.start(.005, .15);
		}
		
		private function playerMoveFoward(forward:int = 0):void
		{
			if (forward == 0)
			{
				playerSprite.x -= 4;
				playerSprite.y -= 4;
				playerMove = true;
			}
			else // move back
			{
				playerSprite.x += 4;
				playerSprite.y += 4;
				playerMove = false;
			}
		}
		
		private function enemyMoveFoward(forward:int = 0):void
		{
			if (forward == 0)
			{
				enemySprite.x += 4;
				enemySprite.y += 4;
				enemyMove = true;
			}
			else // move back
			{
				enemySprite.x -= 4;
				enemySprite.y -= 4;
				enemyMove = false;
			}
		}
		
		private function restoreHP(amount:int, target:int = 0):void
		{
			FlxG.play(SndRest);
			
			if (target == 0) // heal the hero
			{
				playerHP += amount;
				playerHP = Math.min(playerHP, playerHPMax);
				
				add(new DamageMarker(95, 56, "+" + amount.toString()));
				animationTimer = 45;
			}
			else // heal the enemy
			{
				enemyHP += amount;
				Math.min(enemyHP, enemyHPMax);
			}
		}
		
		private function meleeAttack(skillID:int = 0, target:int = 0, multipleFlag:int = 0):void
		{
			var tempAttack:int;
			var myHit:Boolean;
			
			if (target == 0) // player attack
			{
				tempAttack = playerAttack;
				
				if (playerAttackBonus)
					tempAttack *= 1.25; // attack bonus!
				
				myHit = true;
				
				//calculatedDamage = (DataTable.SkillSub[skillID] + (Math.random() * DataTable.SkillSub[skillID] * 3));
				//calculatedDamage *= DataTable.SkillSub[skillID] * StatsTable.MonsterAttack[playerMonsterID];
				
				if(multipleFlag == 0) // to avoid infinite loops
					playerNumberAttacks = DataTable.SkillNumber[skillID];
				
				calculatedDamage = (DataTable.SkillSub[skillID]) + (Math.random() * (DataTable.SkillSubAlt[skillID] * 1.5));
				calculatedDamage *= ((tempAttack / 1.80) - (enemyDefense / 4)) * DataTable.SkillSubAlt[skillID];
				calculatedDamage += Math.random() * ((tempAttack / 6) * DataTable.SkillSubAlt[skillID]);
				calculatedDamage += Math.random() * (calculatedDamage / 10);
				calculatedDamage -= (enemyDefense / 4.5);
				
				if (calculatedDamage < 0)
					calculatedDamage = 0;
				
				animationTimer = DataTable.SkillTime[skillID];
				animationHalf = animationTimer / 1.5;
				animation = true;
				
				if (Math.random() * 100 > DataTable.SkillAccuracy[skillID])
					myHit = false;
				
				// remove the HP
				
				if (myHit == false)
					calculatedDamage = -2;
				else
				{
					FlxG.play(SndMelee);
					add(new BattleAnimation(2, 17, DataTable.SkillAnimation[skillID])); // add the animation
					
					// remove HP
					
					enemyHP -= calculatedDamage;
				}
			}
			else if (target == 1) // enemy attack
			{
				tempAttack = enemyAttack;
				
				if (enemyAttackBonus)
					tempAttack *= 1.25; // attack bonus!
				
				myHit = true;
								
				if(multipleFlag == 0) // to avoid infinite loops
					enemyNumberAttacks = DataTable.SkillNumber[skillID];
				
				calculatedDamage2 = (DataTable.SkillSub[skillID]) + (Math.random() * (DataTable.SkillSubAlt[skillID] * 1.5));
				calculatedDamage2 *= ((tempAttack / 1.80) - (playerDefense / 3.5)) * DataTable.SkillSubAlt[skillID];
				calculatedDamage2 += Math.random() * (tempAttack / 6);
				calculatedDamage2 -= (playerDefense / 4.5);
				calculatedDamage2 -= (calculatedDamage2 / 9);
				
				if (calculatedDamage2 < 0)
					calculatedDamage2 = 0;
				
				animationTimer = DataTable.SkillTime[skillID];
				animationHalf = animationTimer / 1.5;
				animation = true;
				
				if (Math.random() * 100 > DataTable.SkillAccuracy[skillID])
					myHit = false;
				
				// remove the HP
				
				if (myHit == false)
					calculatedDamage2 = -2;
				else
				{
					FlxG.play(SndMelee);
					add(new BattleAnimation(90, 50, DataTable.SkillAnimation[skillID])); // add the animation
					
					// remove HP
					
					playerHP -= calculatedDamage2;
				}
			}
		}
		
		private function enemyDecision():void
		{
			// figure out some skill randomizer.. but for now, something arbitrary
			
				enemySkillChoice = 0;
				enemyUseSkill();
		}
		
		private function enemyUseSkill(multipleFlag:int = 0):void
		{				
			// determine the skill type and act accordingly
				
			var mySkillID:int = enemySkillChoice;
			
			if (DataTable.SkillType[mySkillID] == 0)
			{
				meleeAttack(mySkillID, 1, multipleFlag);
			}
			else
			{
				animationTimer = 40;
			}
				
			// stuff all skills share (announcements, etc.)
			announcement = true;
			announceText.text = DataTable.SkillName[mySkillID] + "!";
				
			enemyTurn = false;
			enemyMoveFoward();
				
			if (playerHP <= 0)
			{
				lossFlag = true;
				playerHP = 0;
			}
		}
		
	}

}