package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class HelpScreen extends MovieClip {
		
		
		public function HelpScreen() {
			back_button.addEventListener(MouseEvent.CLICK, back_button_clicked);
		}
		
		public function back_button_clicked(event:MouseEvent) {
			transition.addScreen(runner.main.show_begin);
			
		}
	}
	
}
