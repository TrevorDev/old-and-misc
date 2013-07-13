package  {
	
	import flash.display.MovieClip;
	
	
	public class other2 extends MovieClip {
		public static var look:Array = new Array();
		
		public function other2() {
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}
	
}
