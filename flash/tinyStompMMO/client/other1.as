package  {
	
	import flash.display.MovieClip;
	
	
	public class other1 extends MovieClip {
		public static var look:Array = new Array();
		
		public function other1() {
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}
	
}
