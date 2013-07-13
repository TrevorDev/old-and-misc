package  {
	
	import flash.display.MovieClip;
		import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class fullPage extends MovieClip {
		
		
		public function fullPage() {
			full_button.addEventListener(MouseEvent.CLICK, runner.goFullScreen);
			//cont.addEventListener(MouseEvent.CLICK, cont);
		}
	}
	
}
