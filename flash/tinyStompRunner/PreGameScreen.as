package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
		import flash.events.*;
	import flash.events.Event;
	
	public class PreGameScreen extends MovieClip {
		public static var screen;
		
		public function PreGameScreen() {
			runner.menuSong();
			screen=this;
			back_button.addEventListener(MouseEvent.CLICK, back_button_clicked);
			startRun_button.addEventListener(MouseEvent.CLICK, startRun_button_clicked);
			runner.saving();
		}
		
		public function back_button_clicked(event:MouseEvent) {
			transition.addScreen(runner.main.show_begin);
			runner.saving();
		}
		
		public function startRun_button_clicked(event:MouseEvent) {
			transition.addScreen(runner.main.show_game);
			runner.saving();
		}
		
		public function nextGame(event:Event):void
		{
			if(runner.main.attack){
			startRun_button_clicked(null);
			}
		}
		
	}
	
}
