package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class guy extends MovieClip
	{
		public static var ar:Array = new Array();

		static var fric = 2;


		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		public var xAccel:Number = 0.5;
		public var yAccel:Number = 1;
		public var jumpStr:Number = 0;
		public var jumpState:Number = 0;
		public var inAir = false;
		public var noTrick = true;
		public var trickDisp = 0;
		public var trick = 0;
		public var combo = 0;
		public var dead = false;
		public var fallen = false;

		public var numOfJumps;
		public function guy()
		{
			dead = false;
			guy.ar.push(this);
			stop();
		}

		public static function gravity(event:Event):void
		{
			
			if(guy.ar[0].x>24000&&runner.won!=1){
				transition.addScreen(runner.main.end);	
			}
			if(doneArrow.ar[1].x<=doneArrow.ar[0].x){
			doneArrow.ar[1].x=doneArrow.ar[0].x-((24000-guy.ar[0].x)/24000)*160;
			}
			if (! guy.ar[0].dead && ! guy.ar[0].fallen)
			{
				guy.ar[0].ySpeed +=  guy.ar[0].yAccel;
				guy.ar[0].y +=  guy.ar[0].ySpeed;
			}else{
				guy.ar[0].xSpeed=0;
			}
		}

		public static function movePlayer(event:Event):void
		{
			if(guy.ar[0].hitTestObject(coin.cashBall)){
				ground.trickCashGained+=500;
			}
			
			if (! guy.ar[0].dead && ! guy.ar[0].fallen)
			{
				if (runner.main.stage.focus != guy.ar[0])
				{
					runner.main.stage.focus = guy.ar[0];
				}
				if (Math.abs(guy.ar[0].xSpeed) <= fric && Math.abs(guy.ar[0].xSpeed) != 0 && ! runner.main.right && ! runner.main.left)
				{

				}
				if (guy.ar[0].xSpeed > 0 && ! runner.main.right && runner.main.left)
				{
					guy.ar[0].xSpeed +=   -  fric;
				}
				else if (guy.ar[0].xSpeed<0&&!runner.main.left&&runner.main.right)
				{
					guy.ar[0].xSpeed +=  fric;
				}

				if (runner.main.left)
				{

					if (guy.ar[0].xSpeed - guy.ar[0].xAccel >=  -  runner.maxSpeed)
					{
						guy.ar[0].xSpeed -=  guy.ar[0].xAccel;
					}
					guy.ar[0].animate.scaleX = -1 * Math.abs(guy.ar[0].animate.scaleX);
					if (guy.ar[0].animate.currentFrame == 1)
					{
						if (guy.ar[0].animate.walk.currentFrame + Math.abs(guy.ar[0].xSpeed) > guy.ar[0].animate.walk.totalFrames)
						{
							guy.ar[0].animate.walk.gotoAndStop(guy.ar[0].animate.walk.currentFrame+Math.floor(Math.abs(guy.ar[0].xSpeed)/2)-guy.ar[0].animate.walk.totalFrames);
						}
						else
						{
							guy.ar[0].animate.walk.gotoAndStop(guy.ar[0].animate.walk.currentFrame+Math.floor(Math.abs(guy.ar[0].xSpeed)/2));
						}
					}
				}
				if (runner.main.right)
				{

					if (guy.ar[0].xSpeed + guy.ar[0].xAccel <= runner.maxSpeed)
					{
						guy.ar[0].xSpeed +=  guy.ar[0].xAccel;
					}
					guy.ar[0].animate.scaleX = Math.abs(guy.ar[0].animate.scaleX);
					if (guy.ar[0].animate.currentFrame == 1)
					{
						if (guy.ar[0].animate.walk.currentFrame + Math.abs(guy.ar[0].xSpeed) > guy.ar[0].animate.walk.totalFrames)
						{
							guy.ar[0].animate.walk.gotoAndStop(guy.ar[0].animate.walk.currentFrame+Math.floor(Math.abs(guy.ar[0].xSpeed)/2)-guy.ar[0].animate.walk.totalFrames);
						}
						else
						{
							guy.ar[0].animate.walk.gotoAndStop(guy.ar[0].animate.walk.currentFrame+Math.floor(Math.abs(guy.ar[0].xSpeed)/2));
						}
					}
				}

				if (runner.main.up && guy.ar[0].jumpState % 2 == 0 && guy.ar[0].jumpState < runner.numberJumps * 2 - 1)
				{
					if (guy.ar[0].jumpState == 0)
					{
						guy.ar[0].jumpStr = runner.jumpPow + Math.abs(guy.ar[0].xSpeed) * 0.3;
					}
					guy.ar[0].ySpeed =  -  guy.ar[0].jumpStr;
					guy.ar[0].jumpState++;
				}
				else if (guy.ar[0].jumpState%2==1&&!runner.main.up)
				{
					guy.ar[0].jumpState++;
				}
				if (guy.ar[0].jumpState >= 1)
				{
					guy.ar[0].animate.gotoAndStop(2);
				}
				else if (guy.ar[0].animate.currentFrame==2)
				{
					guy.ar[0].animate.gotoAndStop(1);
				}
				if (runner.main.down)
				{
					guy.ar[0].animate.rotation +=  runner.trickPwr;

				}

				if (guy.ar[0].inAir && guy.ar[0].jumpState < 1)
				{
					guy.ar[0].jumpState = 1;
				}

				if (! guy.ar[0].inAir)
				{
					if ((guy.ar[0].animate.rotation<=60&&guy.ar[0].animate.rotation>=-60))
					{
						guy.ar[0].animate.rotation = 0;
					}
					else
					{
						guy.ar[0].combo = 0;
						guy.ar[0].xSpeed=0;
						guy.ar[0].fallen = true;
						guy.ar[0].ySpeed=0;
						if(!runner.mute){
						var snd= new ouch();
						snd.play();
						}
					}
				}
				if (guy.ar[0].noTrick && guy.ar[0].animate.rotation == 180)
				{
					guy.ar[0].combo++;
					guy.ar[0].noTrick = false;
					guy.ar[0].trickDisp = 20;
					if (guy.ar[0].animate.scaleX == 1)
					{
						guy.ar[0].trick = 0;
					}
					else
					{
						guy.ar[0].trick = 1;
					}

					if (guy.ar[0].trick == 0)
					{
						ground.trickCashGained +=  5 * guy.ar[0].combo;
						cashString.updatescore(String("Front Flip +$5x"+guy.ar[0].combo), runner.main.game_screen.show.trickDisplay);
					}
					else
					{
						ground.trickCashGained +=  10 * guy.ar[0].combo;
						cashString.updatescore(String("Back Flip +$10x"+guy.ar[0].combo), runner.main.game_screen.show.trickDisplay);
					}
				}
				if (guy.ar[0].trickDisp >= 0)
				{
					guy.ar[0].trickDisp--;

				}
				else
				{
					
					cashString.updatescore(String(""), runner.main.game_screen.show.trickDisplay);
				}
				if (! guy.ar[0].noTrick && guy.ar[0].animate.rotation == 0)
				{
					guy.ar[0].noTrick = true;
				}
				
				guy.ar[0].x +=  Math.ceil(guy.ar[0].xSpeed);

			}
			if(guy.ar[0].fallen){
				guy.ar[0].animate.rotation+=(guy.ar[0].animate.rotation/Math.abs(guy.ar[0].animate.rotation))*-5;
				if(guy.ar[0].animate.rotation==0){
					guy.ar[0].fallen=false;
				}
			}
		}


	}

}