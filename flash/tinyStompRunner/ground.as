package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;




	public class ground extends MovieClip
	{
		public static var timeCounted = 0;
		public static var cashGained = 0;
		public static var trickCashGained = 0;
		public static var ar:Array = new Array();
		static var fric:Number = 2;
		public static var groundMC:ground;
		public function ground()
		{

			this.cacheAsBitmap = true;
			

			ar.push(this);


		}

		public static function generateWalls(event:Event):void
		{
			var walls = ground.ar;
			var maxWalls = 10;
			var minHeight = 300;
			var maxHeight =370;
			var space = 100;
			var maxWid = 450;
			var minWid = 200;
			var minDist = 80 + timeCounted / 2;
			var maxDist = 150 + timeCounted;
			var samehi =0;
			if (! guy.ar[0].dead)
			{
				
				timeCounted++;
				cashGained=Math.floor((runner.cashGain/10)*(timeCounted/3))+trickCashGained;
				cashString.updatescore(String("$"+(cashGained)), runner.main.game_screen.show.totalCash);
			}
			while (walls.length<maxWalls)
			{

				groundMC = new ground();
				runner.main.game_screen.addChildAt(groundMC,walls[0].parent.getChildIndex(walls[0]));
				groundMC.width = minWid + Math.random() * (maxWid - minWid);
				
				groundMC.x = walls[walls.length - 2].x + walls[walls.length - 2].width + minDist + Math.random() * (maxDist - minDist);
				groundMC.y = Math.random()*(maxHeight-minHeight)+minHeight;
				if(timeCounted == 1&&samehi<3){
					samehi++;
					groundMC.y=362.5;
				}
			}

			for (var i=0; i<walls.length; i++)
			{
				if (walls[i].x - cam.camera.x <= -1500)
				{
					walls[i].parent.removeChild(walls[i]);
					walls.splice(i,1);
				}
			}

		}

		public static function makeWall(event:Event):void
		{
			var walls = ground.ar;
			walls=walls.concat(placedGround.ar);
			for (var i:Number=0; i<guy.ar.length; i++)
			{
				guy.ar[i].inAir = true;
				for (var j:Number=0; j<walls.length; j++)
				{

					if (walls[j].hitTestObject(guy.ar[i].boxHit.down))
					{
						guy.ar[i].combo = 0;
						guy.ar[i].inAir = false;
						if (Math.abs(guy.ar[i].xSpeed) <= fric && Math.abs(guy.ar[i].xSpeed) != 0 && ! runner.main.right && ! runner.main.left)
						{
							guy.ar[i].xSpeed = 0;
						}
						if (guy.ar[i].xSpeed>runner.maxSpeed||(guy.ar[i].xSpeed > 0 && ! runner.main.right))
						{
							guy.ar[i].xSpeed +=   -  fric;
						}
						else if (guy.ar[i].xSpeed<-runner.maxSpeed||(guy.ar[i].xSpeed<0&&!runner.main.left))
						{
							guy.ar[i].xSpeed +=  fric;
						}

					}



					while (walls[j].hitTestObject(guy.ar[i].boxHit.down))
					{
						guy.ar[i].ySpeed = 0;
						guy.ar[i].jumpState = 0;
						guy.ar[i].y--;
					}

					while (walls[j].hitTestObject(guy.ar[i].boxHit.up))
					{
						guy.ar[i].ySpeed = 0;

						guy.ar[i].y++;
					}

					while (walls[j].hitTestObject(guy.ar[i].boxHit.right))
					{
						if (guy.ar[i].xSpeed > 0)
						{
							guy.ar[i].xSpeed = 0;
						}
						guy.ar[i].x--;
					}

					while (walls[j].hitTestObject(guy.ar[i].boxHit.left))
					{
						if (guy.ar[i].xSpeed < 0)
						{
							guy.ar[i].xSpeed = 0;
						}
						guy.ar[i].x++;
					}


				}
			}
		}

	}
}