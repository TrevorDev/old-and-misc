package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class introMovie extends MovieClip {
		public static var intros;
		
		public function introMovie() {
			intros=this;
			runner.stopMusic();
			this.gotoAndPlay(0);
			addEventListener(Event.ENTER_FRAME, done, false,  -1,  false);
		}
		public function done(event:Event){
			if(intros.currentFrame==intros.totalFrames){
				intros.stop();
				transition.addScreen(runner.main.show_preScreen);
			}
		}
	}
	
}
