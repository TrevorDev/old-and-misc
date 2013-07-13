package  {
	import flash.text.TextField;
	import flash.display.MovieClip;
	public class coinCount extends MovieClip {
		public static var coinScore:Array = new Array();
		
		public function coinCount() {
			coinScore[0]=this;
			this.scoretext.text = String(0);
		}
		
		public function updatescore(score:Number) {
			// updating the score
			this.scoretext.text = String(score);
		}
	}
	
}
