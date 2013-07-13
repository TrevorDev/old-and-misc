package  {
	
	import flash.display.MovieClip;
	
	
	public class foot extends MovieClip {
		
		public static var look:Array = new Array();
		public function foot() {
			this.gotoAndStop(look[guySprite.lookPlayer]);		}
	}
	
}
