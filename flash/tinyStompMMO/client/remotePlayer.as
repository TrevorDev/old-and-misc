package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;

	public class remotePlayer extends MovieClip
	{
		public var weaponLook:Number = 1;
		public var eyeLook:Number = 1;
		public var hatsLook:Number = 1;
		public var headLook:Number = 1;
		public var shoesLook:Number = 1;
		public static var remoteCount:Number = 0;
		public var playerRef:Number = 0;

		static var fric:Number = 2;
		public var newPacket,start,keyUp,keyDown,keyRight,keyLeft:Boolean;
		public var messageTimeout,oldX,oldY,toX,toY,offStepX,offStepY,speed,maxSpeed,xAccel,yAccel,oldTime,buffSize,timeStart,curTime,timeChange,splineTime,curPacket,curPacketPlus,packetBuf,x1,x2,x3,x4,y1,y2,y3,y4,speedPack;
		public var oldestX, oldestY, newestX, newestY, oldestXS, oldestYS, newestXS, newestYS;
		public var timeDif:Array = new Array();

		public var nextX:Array = new Array();
		public var nextY:Array = new Array();
		public var xSpeed:Array = new Array();
		public var ySpeed:Array = new Array();
		public var newTime:Array = new Array();
		var touchGround:Boolean = false;
		var i;
		public var hatID,torsoID,feetID;
		public function remotePlayer(initialX,initialY)
		{
			remoteCount++;
			playerRef = remoteCount;
			guySprite.lookPlayer = playerRef;

			eye.look[guySprite.lookPlayer] = eyeLook;
			hats.look[guySprite.lookPlayer] = hatsLook;
			foot.look[guySprite.lookPlayer] = shoesLook;
			head.look[guySprite.lookPlayer] = headLook;
			this.sprite.gotoAndStop(2);
			buffSize = 10;
			newPacket = true;
			start = false;

			x = initialX;
			y = initialY;
			messageTimeout = 0;
			oldX = 0;
			oldY = 0;
			toX = 0;
			toY = 0;
			offStepX = 0;
			offStepY = 0;
			speed = 10;
			maxSpeed = 10;

			xAccel = 1;
			yAccel = 1;
			hatID = 1;
			torsoID = 1;
			feetID = 1;

			oldTime = 0;

			hatObj.gotoAndStop(1);
			curPacket = 0;
			curPacketPlus = 1;
			packetBuf = -1;
			speedPack = 0;
			//this.addEventListener(Event.ENTER_FRAME, makeWall);
			this.addEventListener(Event.ENTER_FRAME, changeLook);
		}
		
		function updateChar(eyeID:int, bodyID:int, footID:int)
		{
			eye.look[guySprite.lookPlayer] = eyeID;
			//hats.look[guySprite.lookPlayer] = bodyID;
			foot.look[guySprite.lookPlayer] = footID;
			head.look[guySprite.lookPlayer] = bodyID;
			this.sprite.gotoAndStop(2);
			this.sprite.gotoAndStop(1);
		}
		
		function changeLook(event:Event):void
		{
			touchGround = false;
			for (i=0; i<ground.allGround.length; i++)
			{
				if (this.remoteHit.hitTestObject(ground.allGround[i]))
				{
					if (this.sprite.currentFrame == 1)
					{

						if (this.sprite.walking.currentFrame + Math.abs(xSpeed[speedPack]) > this.sprite.walking.totalFrames)
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed[speedPack])/2)-this.sprite.walking.totalFrames);
						}
						else
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed[speedPack])/2));
						}
					}
					i = ground.allGround.length;
					touchGround = true;
				}
			}
			
			for (i=0; i<platform.allPlat.length; i++)
			{
				if (this.remoteHit.hitTestObject(platform.allPlat[i]))
				{
					if (this.sprite.currentFrame == 1)
					{

						if (this.sprite.walking.currentFrame + Math.abs(xSpeed[speedPack]) > this.sprite.walking.totalFrames)
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed[speedPack])/2)-this.sprite.walking.totalFrames);
						}
						else
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed[speedPack])/2));
						}
					}
					i = platform.allPlat.length;
					touchGround = true;
				}
			}
			
			if (! touchGround)
			{
				guySprite.lookPlayer = playerRef;
				this.sprite.gotoAndStop(2);
			}
			else if (this.sprite.currentFrame!=1)
			{
				guySprite.lookPlayer = playerRef;
				this.sprite.gotoAndStop(1);
			}
		}

		function makeWall(event:Event):void
		{
			for (i=0; i<guy.players.length; i++)
			{
				if (this.remoteHit.hitTestObject(guy.players[i].down))
				{
					if (Math.abs(guy.players[i].xSpeed) <= fric && Math.abs(guy.players[i].xSpeed) != 0 && ! landworld(root).right && ! landworld(root).left)
					{
						guy.players[i].xSpeed = 0;
					}
					if (guy.players[i].xSpeed > 0 && ! landworld(root).right)
					{
						guy.players[i].xSpeed +=   -  fric;
					}
					else if (guy.players[i].xSpeed<0&&!landworld(root).left)
					{
						guy.players[i].xSpeed +=  fric;
					}

				}



				while (this.remoteHit.hitTestObject(guy.players[i].down))
				{
					guy.players[i].ySpeed = 0;
					guy.players[i].jumpState = 0;
					guy.players[i].y--;
				}

				while (this.remoteHit.hitTestObject(guy.players[i].up))
				{
					guy.players[i].ySpeed = 0;

					guy.players[i].y++;
				}

				while (this.remoteHit.hitTestObject(guy.players[i].right))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x--;
				}

				while (this.remoteHit.hitTestObject(guy.players[i].left))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x++;
				}


			}



		}


	}

}