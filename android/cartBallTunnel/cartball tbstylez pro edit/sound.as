package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound;
import flash.media.SoundChannel;
	
	public class sound extends MovieClip {
		public static var snd:Sound = new Sound();

		
		public function sound() {
			
		}
		public static function bgMusic(){
			var snd:gameMusic= new gameMusic();
		snd.play(0, 99999);
		}
	}
	
}
