package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.engine.TextElement;
	
	public class cashString extends MovieClip {
		
		public static var cashStr;
		public function cashString() {
			
		}
		public static function updatescore(score:String,txt:TextField) {
			txt.text = score;
		}
	}
	
}
