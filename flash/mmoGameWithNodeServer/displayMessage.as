package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class displayMessage extends MovieClip {
		public static var disp;
		public static var len=100;
		public static var cur=0;
		public function displayMessage() {
			disp=this;
			disp.visible=false;
		}
		
		public static function displayMsg(textDisp){
			disp.displayed.text=textDisp;
			disp.visible=true;
			cur=0;
			mmogame.main.stage.addEventListener(Event.ENTER_FRAME, display);
		}
		
		public static function display(event:Event):void
		{
			cur++;
			if(cur>=len){
				disp.visible=false;
				mmogame.main.stage.removeEventListener(Event.ENTER_FRAME, display);
			}
		}
	}
	
}
