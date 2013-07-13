package  {
	
	import flash.display.MovieClip;
		import flash.events.*;
	import flash.events.Event;
	
	public class worldIcon extends MovieClip {
		
		public var world=0;
		public var level = 0;
		public static var ar:Array = new Array();
		public function worldIcon() {
			worldIcon.ar.push(this);
		}
		public function selectLevel(event:MouseEvent) {
			
			cartballTunnel.main.loadLevel(world,level);
		}
	}
	
}
