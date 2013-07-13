package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	
	
	public class level1 extends MovieClip {
		
		
		public function level1() {
			
			addEventListener(Event.ENTER_FRAME, guy.movePlayer, false, 0, true);
			addEventListener(Event.ENTER_FRAME, guy.shooting, false, 0, true);
			addEventListener(Event.ENTER_FRAME, guy.healthSystem, false, 0, true);
			addEventListener(Event.ENTER_FRAME, shot.bulletHit, false, 0, true);
			addEventListener(Event.ENTER_FRAME, wall.makeWall, false, 0, true);
			addEventListener(Event.ENTER_FRAME, zombie.walker, false, 0, true);
			addEventListener(Event.ENTER_FRAME, room.activate, false, 0, true);
			addEventListener(Event.ENTER_FRAME, zombie.spawner, false, 0, true);
			addEventListener(Event.ENTER_FRAME, door.makeDoor, false, 0, true);
			addEventListener(Event.ENTER_FRAME, door.makeDoor, false, 0, true);
			addEventListener(Event.ENTER_FRAME, gunPickup.makeStore, false, 0, true);
			addEventListener(Event.ENTER_FRAME, cam.makeCam, false, 0, true);
		}
	}
	
}
