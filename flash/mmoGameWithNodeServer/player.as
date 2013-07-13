package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	
	
	public class player extends MovieClip {
		static var guy;
		
		public var speed:Number;
		public var maxSpeed:Number = 10;
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		public var xAccel:Number = 0.5;
		public var yAccel:Number = 1;
		public var jumpStr:Number = 15;
		public var jumpState:Number = 0;
		public var radius:Number = 16;
		
		var fric = 2;
		
		public var canMove:Boolean = true;
		public var canMoves:Boolean = true;
		
		//var timer:Timer = new Timer(200,0);
		public function player() {
			guy=this;
			this.addEventListener(Event.ENTER_FRAME, movePlayer, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, gravity, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, ground.makeWall, false, -100, true);
			this.addEventListener(Event.ENTER_FRAME, otherPlayer.movePlayer, false, -100, true);
			//timer.addEventListener(TimerEvent.TIMER, timerTick);
			//timer.start();
		}
		
		public static function timerTick():void
		{
			mmogame.connection.sendPos(guy.x, guy.y, guy.xSpeed, guy.ySpeed);
		}
		
		function movePlayer(event:Event):void
		{
			
			if (canMoves)
			{
				if (Math.abs(guy.xSpeed) <= fric && Math.abs(guy.xSpeed) != 0 && ! mmogame.main.right && ! mmogame.main.left)
				{

				}
				if (guy.xSpeed > 0 && ! mmogame.main.right && mmogame.main.left)
				{
					guy.xSpeed +=   -  fric;
				}
				else if (guy.xSpeed<0&&!mmogame.main.left&&mmogame.main.right)
				{
					guy.xSpeed +=  fric;
				}

				if (mmogame.main.left)
				{
					if (xSpeed - xAccel >=  -  maxSpeed)
					{
						xSpeed -=  xAccel;
					}
					/*this.sprite.scaleX = -1;
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
					}*/
				}
				if (mmogame.main.right)
				{

					if (xSpeed + xAccel <= maxSpeed)
					{
						xSpeed +=  xAccel;
					}
					/*
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
					*/
				}

				if (mmogame.main.up&&(jumpState==0||jumpState==2))
				{
					if (jumpState == 0)
					{
						jumpStr = 13 + Math.abs(xSpeed) * 0.3;
					}
					ySpeed =  -  jumpStr;
					jumpState++;
				}
				else if (jumpState==1&&!mmogame.main.up)
				{
					jumpState++;
				}
				/*
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
				if (mmogame.main.down)
				{

				}*/
				this.x +=  Math.ceil(xSpeed);
				/*if (Math.abs(xSpeed) >= maxSpeed)
				{
					this.sprite.dash.visible = true;
				}
				else
				{
					this.sprite.dash.visible = false;

				}*/
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
		
	}
	
}
