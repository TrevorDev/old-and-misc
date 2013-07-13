package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class spawn extends MovieClip {
		public static var ar:Array = new Array();
		public var ref=0;
		
		public function spawn() {
			this.addEventListener(Event.ADDED_TO_STAGE, initHandler);
			// constructor code
		}
		 private function initHandler(evt:Event):void
        {
       this.removeEventListener(Event.ADDED_TO_STAGE, initHandler);
       spawn.ar[ref]=this;
        }
	}
	
}
