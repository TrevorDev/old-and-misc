package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import serverHandler;
	
	public class activated extends MovieClip {
		public static var activateds:Array = new Array();
		public var moveOn:Boolean = false;

		public var initialX = 0;
		public var initialY = 0;
		public var destinationX = 1;
		public var destinationY = 1;
		public var speed = 1;
		
		public var link:Number = 0;
		public var type:int = 0;
		
		public function activated() {
			activateds.push(this);
			
			this.addEventListener(Event.ENTER_FRAME, makeWall, false, 0, true);
		}
		function makeWall(event:Event):void
		{
		for (var i:Number=0; i<guy.players.length; i++)
			{
				while (this.hitTestObject(guy.players[i].down))
				{
					guy.players[i].ySpeed = 0;
					guy.players[i].jumpState = 0;
					guy.players[i].y--;
				}

				while (this.hitTestObject(guy.players[i].up))
				{
					guy.players[i].ySpeed = 0;

					guy.players[i].y++;
				}

				while (this.hitTestObject(guy.players[i].right))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x--;
				}

				while (this.hitTestObject(guy.players[i].left))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x++;
				}

			}
			if(moveOn)
			{
				if(type == 0)
				{
					if(this.y > destinationY)
					{
						this.y-= speed;
					}
				}
				if(type == 1)
				{
					if (this.x < destinationX)
					{
						this.x+= speed;
					}
				}
			}
			else
			{
				if(type == 0)
				{
					if(this.y < initialY)
					{
						this.y+= speed;
					}
				}
				if(type == 1)
				{
					if (this.x > initialX)
					{
						this.x-= speed;
					}
				}
			}
		}
		
	}
	
}
