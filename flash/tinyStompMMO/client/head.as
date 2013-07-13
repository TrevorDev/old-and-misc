package  {
	
	import flash.display.MovieClip;
	
	
	public class head extends MovieClip {
		
		public static var look:Array = new Array();
		public function head() {
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}
	
}
