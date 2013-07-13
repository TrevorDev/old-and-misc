package  {
	
		import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;
	
	
	public class placedGround extends MovieClip {
		
		public static var ar:Array = new Array();
		public function placedGround() {
			this.cacheAsBitmap = true;
			

			ar.push(this);

		}
	}
	
}
