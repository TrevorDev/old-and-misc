package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.MovieClip;
	
	public class levelCount extends MovieClip {
		public static var level:Array = new Array();
		
		
		public function levelCount() {
			level[0]=this;
			updateLevel(guy.players[0].level);
		}
		public function updateLevel(level:Number) {
			// updating the score
			this.levelText.text = String(level);
		}
	}
	
}
