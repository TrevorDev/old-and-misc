package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;

	public class guy extends MovieClip
	{
		public var weaponLook:Number = 2;
		public var otherOneLook:Number = 3;
		public var otherTwoLook:Number = 3;
		public var eyeLook:Number = 2;
		public var hatsLook:Number = 3;
		public var headLook:Number = 3;
		public var shoesLook:Number = 2;
		public var thisRef:Number = 0;

		public var camGiveX:Number = 25;
		public var camY:Number = 0;

		var fric = 2;
		public static var players:Array = new Array();
		public static var num:Number = -1;
		public var i:Number = 0;

		public var coinNum:Number = 0;
		public var expNum:Number = 0;

		public var level:Number = 1;
		public var preLevel:Number = 45*(level-1)+5*(level-1)*(level-1);
		public var nextLevel:Number = 45 * level + 5 * level * level;

		public var stompDmg:Number = 5;
		public var wepDmg:Number = 10;
		public var healthMax:Number = 2;
		public var healthNum:Number = 2;
		public var lives:Number = 3;
		public var god:Boolean = false;
		public var godTimer:Number = 0;
		public var godTimerMax:Number = 37;
		public var checkNum = 0;
		public var emoteOn = false;
		public var emoteTimer = 0;
		public var emoteMax = 50;
		
		public var speed:Number;
		public var maxSpeed:Number = 10;
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		public var xAccel:Number = 0.5;
		public var yAccel:Number = 1;
		public var jumpStr:Number = 15;
		public var jumpState:Number = 0;
		public var radius:Number = 16;
		public var canMove:Boolean = true;
		public var canMoves:Boolean = true;
		public var rand = 0;
		public var deadCount = 0;
		public function guy()
		{
			guySprite.lookPlayer = thisRef;
			weapon.look[guySprite.lookPlayer] = landworld.main.weaponLook;
			back.look[guySprite.lookPlayer] = landworld.main.backLook;
			other1.look[guySprite.lookPlayer] = landworld.main.otherOneLook;
			other2.look[guySprite.lookPlayer] = landworld.main.otherTwoLook;
			eye.look[guySprite.lookPlayer] = landworld.main.eyeLook;
			hats.look[guySprite.lookPlayer] = landworld.main.hatsLook;
			foot.look[guySprite.lookPlayer] = landworld.main.shoesLook;
			head.look[guySprite.lookPlayer] = landworld.main.headLook;
			this.sprite.gotoAndStop(2);
			this.sprite.weapon.gotoAndStop(2);
			this.sprite.backItem.gotoAndStop(back.look[guySprite.lookPlayer]);
			this.sprite.otherOne.gotoAndStop(other1.look[guySprite.lookPlayer]);
			this.sprite.otherTwo.gotoAndStop(other2.look[guySprite.lookPlayer]);
			this.sprite.emotes.gotoAndStop(1);
			speed = 10;
			this.stop();


			
			players[0] = this;

			addEventListener(Event.ENTER_FRAME, emotes, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, movePlayer, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, attacking, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, misc, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, gravity, false, 0, true);
			addEventListener(Event.ENTER_FRAME, makePlat, false, -100, true);
			addEventListener(Event.ENTER_FRAME, makeWall, false, -100, true);
			addEventListener(Event.ENTER_FRAME, springer, false, -100, true);
			addEventListener(Event.ENTER_FRAME, goal, false, -100, true);
			addEventListener(Event.ENTER_FRAME, deathZone, false, -100, true);
			addEventListener(Event.ENTER_FRAME, coins, false, -100, true);
			addEventListener(Event.ENTER_FRAME, checkPoint, false, -100, true);
			addEventListener(Event.ENTER_FRAME, backround, false, -100, true);
			addEventListener(Event.ENTER_FRAME, cams, false, 0, true);


			for (i=0; i<serverHandler.players.length; i++)
			{
				if (this.hitTestObject(serverHandler.players[i].remoteHit))
				{
					this.x -=  100;
				}
			}
		}

		//////////////////CLASS EVENT LISTENERS//////////////////////////////////////////
		function cams(event:Event):void
		{
			while (275 - guy.players[0].x-guy.players[0].xSpeed-root.x<-camGiveX)
			{
				root.x--;
			}
			while (275 - guy.players[0].x-guy.players[0].xSpeed-root.x>camGiveX)
			{
				root.x++;
			}

			if (camY == 1)
			{
				if ( -  guy.players[0].y + stage.stageHeight / 2 - root.y > 10 ||  -  guy.players[0].y + stage.stageHeight / 2 - root.y < 10)
				{

					root.y+=(-guy.players[0].y+stage.stageHeight/2-root.y)/10;

				}




			}
			else
			{
				if ( -  camY - root.y > 10 ||  -  camY - root.y < 10)
				{

					root.y+=(-camY-root.y)/10;

				}
			}



		}
		
		function backround(event:Event):void
		{
			for (var i =0; i<backround1.back.length; i++)
			{
				backround1.follow(backround1.back[i]);

			}

		}
		
		function checkPoint(event:Event):void
		{
			for (var i =0; i<checkpoint.checkPoint.length; i++)
			{
				checkpoint.hit(checkpoint.checkPoint[i]);

			}

		}
		
		function coins(event:Event):void
		{
			for (var i =0; i<coin.coins.length; i++)
			{
				coin.update(coin.coins[i]);

			}

		}
		
		function deathZone(event:Event):void
		{
			for (var i =0; i<death.death.length; i++)
			{
				death.hit(death.death[i]);

			}

		}
		
		function goal(event:Event):void
		{
			for (var i =0; i<ending.endings.length; i++)
			{
				ending.hit(ending.endings[i]);

			}

		}
		
		function springer(event:Event):void
		{
			for (var i =0; i<spring.springs.length; i++)
			{
				spring.hit(spring.springs[i]);

			}

		}
		
		function makeWall(event:Event):void
		{
			for (var i =0; i<ground.allGround.length; i++)
			{
				ground.makeWall(ground.allGround[i]);

			}

		}

		function makePlat(event:Event):void
		{
			for (var i =0; i<platform.allPlat.length; i++)
			{
				platform.makePlat(platform.allPlat[i]);

			}

		}

		/////////////////////////////////////////////////////////////////////////////////////
		function emotes(event:Event):void
		{
			if (landworld(root).one == true)
			{
				this.sprite.emotes.gotoAndStop(2);
				emoteTimer = 0
				emoteOn = true;
			}
			else if (landworld(root).two==true)
			{
				this.sprite.emotes.gotoAndStop(3);
				emoteTimer = 0
				emoteOn = true;
			}
			else if (landworld(root).three==true)
			{
				this.sprite.emotes.gotoAndStop(4);
				emoteTimer = 0
				emoteOn = true;
			}
			if(emoteOn){
			emoteTimer++;
			if(emoteTimer>=emoteMax){
				this.sprite.emotes.gotoAndStop(0);
				emoteOn=false;
			}
			}
		}
		function attacking(event:Event):void
		{
			if (canMoves)
			{
				if (landworld(root).attack && this.sprite.weapon.hit1.currentFrame == 1)
				{
					guySprite.lookPlayer = thisRef;


					if (ySpeed > 0)
					{
						this.sprite.weapon.gotoAndStop(1);
						this.sprite.weapon.hit1.gotoAndPlay(2);
					}
					else if (ySpeed<0)
					{
						this.sprite.weapon.gotoAndStop(2);
						this.sprite.weapon.hit1.gotoAndPlay(2);
					}
					else
					{
						rand = Math.floor(Math.random() * 3 + 1);
						this.sprite.weapon.gotoAndStop(rand);
						this.sprite.weapon.hit1.gotoAndPlay(2);
					}

				}
			}
		}

		function test():Boolean
		{
			return true;
		}
		function diedCheck(event:Event):void
		{
			guySprite.lookPlayer = thisRef;
			if (healthNum <= 0 && this.sprite.currentFrame != 3)
			{
				canMoves = false;
				this.sprite.gotoAndStop(3);
				this.sprite.dead.gotoAndPlay(2);

				this.addEventListener(Event.ENTER_FRAME, diedCheck);
				lives -=  1;
				deadCount = 0;
			}
			else if (this.sprite.currentFrame==3&&deadCount<=50)
			{
				deadCount++;
			}
			else if (healthNum<=0)
			{
				deadCount = 0;
				this.sprite.gotoAndStop(2);
				canMoves = true;
				this.removeEventListener(Event.ENTER_FRAME, diedCheck);
				x = checkpoint.checkPoint[guy.players[i].checkNum].x;
				y = checkpoint.checkPoint[guy.players[i].checkNum].y;
				ySpeed = -10;
				xSpeed = 0;
				healthNum = healthMax;
				healthbox.hBox.checkHeart();
			}
		}

		function checkExp():void
		{
			while (expNum >= nextLevel)
			{
				level++;
				preLevel = 45*(level-1)+5*(level-1)*(level-1);
				nextLevel = 45 * level + 5 * level * level;
				levelCount.level[0].updateLevel(level);
			}

			expCount.expBar[0].updateExp(expNum);
		}

		function movePlayer(event:Event):void
		{
			if (canMoves)
			{
				if (Math.abs(guy.players[i].xSpeed) <= fric && Math.abs(guy.players[i].xSpeed) != 0 && ! landworld(root).right && ! landworld(root).left)
				{

				}
				if (guy.players[i].xSpeed > 0 && ! landworld(root).right && landworld(root).left)
				{
					guy.players[i].xSpeed +=   -  fric;
				}
				else if (guy.players[i].xSpeed<0&&!landworld(root).left&&landworld(root).right)
				{
					guy.players[i].xSpeed +=  fric;
				}

				if (landworld(root).left)
				{

					if (xSpeed - xAccel >=  -  maxSpeed)
					{
						xSpeed -=  xAccel;
					}
					this.sprite.scaleX = -1;
					if (this.sprite.currentFrame == 1)
					{
						if (this.sprite.walking.currentFrame + Math.abs(xSpeed) > this.sprite.walking.totalFrames)
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2)-this.sprite.walking.totalFrames);
						}
						else
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2));
						}
					}
				}
				if (landworld(root).right)
				{

					if (xSpeed + xAccel <= maxSpeed)
					{
						xSpeed +=  xAccel;
					}
					this.sprite.scaleX = 1;
					if (this.sprite.currentFrame == 1)
					{
						if (this.sprite.walking.currentFrame + Math.abs(xSpeed) > this.sprite.walking.totalFrames)
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2)-this.sprite.walking.totalFrames);
						}
						else
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2));
						}
					}
				}

				if (landworld(root).up&&(jumpState==0||jumpState==2))
				{
					if (jumpState == 0)
					{
						jumpStr = 13 + Math.abs(xSpeed) * 0.3;
					}
					ySpeed =  -  jumpStr;
					jumpState++;
				}
				else if (jumpState==1&&!landworld(root).up)
				{
					jumpState++;
				}
				if (jumpState >= 1)
				{
					guySprite.lookPlayer = thisRef;
					this.sprite.gotoAndStop(2);
				}
				else if (this.sprite.currentFrame==2)
				{
					guySprite.lookPlayer = thisRef;
					this.sprite.gotoAndStop(1);
				}
				if (landworld(root).down)
				{

				}
				this.x +=  Math.ceil(xSpeed);
				if (Math.abs(xSpeed) >= maxSpeed)
				{
					this.sprite.dash.visible = true;
				}
				else
				{
					this.sprite.dash.visible = false;

				}
			}
		}
		function gravity(event:Event):void
		{
			if (canMoves)
			{
				ySpeed +=  yAccel;
				this.y +=  ySpeed;
			}
		}

		function misc(event:Event):void
		{
			if (canMoves)
			{
				if (god)
				{
					this.alpha = 0.5;
					godTimer++;
					if (godTimer >= godTimerMax)
					{
						this.alpha=1;;
						godTimer = 0;
						god = false;
					}
				}

			}
		}
	}

}