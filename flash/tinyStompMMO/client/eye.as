package  {
	
	import flash.display.MovieClip;
	
	
	public class eye extends MovieClip {
		
		public static var look:Array = new Array();
		
		
		public function eye() {
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}
	
}
