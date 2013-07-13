package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	
	
	public class endDeath extends MovieClip {
		
		public static var moveSpd=19;
		public static var endGame;
		public function endDeath() {
			
			endGame=this;
			endGame.x=-runner.deathDist;
		}
		public static function deathChase(event:Event):void
		{
			endGame.x+=moveSpd;
		}
	}
	
}
