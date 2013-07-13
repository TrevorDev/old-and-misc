package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	public class startMenu extends MovieClip {
		
		
		public function startMenu() {
			this.addEventListener(Event.ENTER_FRAME, starter, false, 0, true);
		}
		function starter(event:Event):void
		{
			if(input.attack){
				input.attack=false;
				arcade.main.startGame();
			}
		}
		public function remove(){
			this.removeEventListener(Event.ENTER_FRAME,starter,false);
		}
	}
	
}
