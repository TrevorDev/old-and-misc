package  {
	
import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class mouse extends MovieClip {
		public static var mice;
		
		public function mouse() {
			mice=this;
			this.addEventListener(Event.ENTER_FRAME, mouser, false, 0, true);
		}
		function mouser(event:Event):void
		{
			this.x=root.mouseX;
			this.y=root.mouseY;
		}
	}
	
}
