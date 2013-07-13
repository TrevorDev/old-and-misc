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
			//this.visible=false;
			allGround.push(this);
			
			
		}
		
		public static function makeWall(event:Event):void
		{
			var walls
			for (var i:Number=0; i<allGround.length; i++)
			{
				walls=allGround[i];
				if (walls.hitTestObject(player.guy.down))
				{
					if (Math.abs(player.guy.xSpeed) <= fric && Math.abs(player.guy.xSpeed) != 0 && ! mmogame.main.right && ! mmogame.main.left)
					{
						player.guy.xSpeed = 0;
					}
					if (player.guy.xSpeed>player.guy.maxSpeed||(player.guy.xSpeed > 0 && ! mmogame.main.right))
					{
						player.guy.xSpeed +=   -  fric;
					}
					else if (player.guy.xSpeed<-player.guy.maxSpeed||(player.guy.xSpeed<0&&!mmogame.main.left))
					{
						player.guy.xSpeed +=  fric;
					}

				}



				while (walls.hitTestObject(player.guy.down))
				{
					player.guy.ySpeed = 0;
					player.guy.jumpState = 0;
					player.guy.y--;
				}

				while (walls.hitTestObject(player.guy.up))
				{
					player.guy.ySpeed = 0;

					player.guy.y++;
				}

				while (walls.hitTestObject(player.guy.right))
				{
					player.guy.xSpeed = 0;

					player.guy.x--;
				}

				while (walls.hitTestObject(player.guy.left))
				{
					player.guy.xSpeed = 0;

					player.guy.x++;
				}


			}



		}
	}

}