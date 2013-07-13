package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class ground extends MovieClip
	{
		public static var allGround:Array = new Array();
		static var fric:Number = 2;

		public function ground()
		{
			this.visible=false;
			allGround.push(this);
			
			
		}
		
		public static function makeWall(walls:MovieClip):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (walls.hitTestObject(guy.players[i].down))
				{
					if (Math.abs(guy.players[i].xSpeed) <= fric && Math.abs(guy.players[i].xSpeed) != 0 && ! landworld.main.right && ! landworld.main.left)
					{
						guy.players[i].xSpeed = 0;
					}
					if (guy.players[i].xSpeed>guy.players[i].maxSpeed||(guy.players[i].xSpeed > 0 && ! landworld.main.right))
					{
						guy.players[i].xSpeed +=   -  fric;
					}
					else if (guy.players[i].xSpeed<-guy.players[i].maxSpeed||(guy.players[i].xSpeed<0&&!landworld.main.left))
					{
						guy.players[i].xSpeed +=  fric;
					}

				}



				while (walls.hitTestObject(guy.players[i].down))
				{
					guy.players[i].ySpeed = 0;
					guy.players[i].jumpState = 0;
					guy.players[i].y--;
				}

				while (walls.hitTestObject(guy.players[i].up))
				{
					guy.players[i].ySpeed = 0;

					guy.players[i].y++;
				}

				while (walls.hitTestObject(guy.players[i].right))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x--;
				}

				while (walls.hitTestObject(guy.players[i].left))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x++;
				}


			}



		}
	}

}