package  {
	
	import flash.display.MovieClip;
	
	
	public class checkpoint extends MovieClip {
		public static var ar = new Array();
		
		public function checkpoint() {
			ar.push(this);
			this.visible=false;
		}
	}
	
}
