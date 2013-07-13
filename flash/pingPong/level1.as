package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	
	
	public class level1 extends MovieClip {
		
		
		public function level1() {
			
			this.addEventListener(Event.ENTER_FRAME, ping.spd, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, wall.makeWall, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, mouse.mouser, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, ping.gravity, false, 0, true);
		}
	}
	
}
