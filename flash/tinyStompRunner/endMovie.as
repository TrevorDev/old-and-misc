package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class endMovie extends MovieClip {
		public static var ends;
		
		public function endMovie() {
			ends=this;
			runner.menuSong();
			this.gotoAndPlay(0);
			addEventListener(Event.ENTER_FRAME, done, false,  -1,  false);
			runner.won=1;
		}
		
		public function done(event:Event){
			if(ends.currentFrame==ends.totalFrames){
				ends.stop();
				transition.addScreen(runner.main.show_preScreen);
			}
		}
	}
	
}
