package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class platform extends MovieClip {
		public static var allPlat:Array = new Array();
		static var fric:Number = 2;
		
		public function platform() {
					this.visible=false;
			allPlat.push(this);
		}
		public static function makePlat(plats:MovieClip):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (plats.hitTestObject(guy.players[i].down))
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
				
				while (plats.hitTestObject(guy.players[i].down)&&guy.players[i].ySpeed>=0&&(guy.players[i].down.y+guy.players[i].y)<=plats.y+guy.players[i].ySpeed)
				{
					guy.players[i].ySpeed = 0;
					guy.players[i].jumpState = 0;
					while (plats.hitTestObject(guy.players[i].down)){
					guy.players[i].y--;
					}
				}

				

			}



		}
	}
	
}
