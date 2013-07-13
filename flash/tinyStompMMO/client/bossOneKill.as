package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class bossOneKill extends MovieClip {
		public static var expVal:Number = 100;
		
		public function bossOneKill() {
			this.stop();
			this.addEventListener(Event.ENTER_FRAME, hit, false, 0, true);
		}
		function hit(event:Event):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (this.hitTestObject(guy.players[i].footBox) && guy.players[i].ySpeed > 0 && this.currentFrame == 1)
				{
					guy.players[i].expNum +=  expVal;
					guy.players[i].checkExp();
					guy.players[i].ySpeed = -10;
					guy.players[i].xSpeed = -40;
					
				}
			}
			
			


		}
	}
	
}
