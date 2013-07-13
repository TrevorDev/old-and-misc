package  {
	
	import flash.display.MovieClip;
	
	
	public class hats extends MovieClip {
		
		public static var look:Array = new Array();
		public function hats() {
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}
	
}
