package  {
	
	import flash.display.MovieClip;
	
	
	public class weapon extends MovieClip {
		public static var look:Array = new Array();
		
		public function weapon() {
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}
	
}
