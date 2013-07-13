package  {
	
	import flash.display.MovieClip;
	
	
	public class death extends MovieClip {
		public static var ar = new Array();
		
		public function death() {
			this.visible=false;
			death.ar.push(this);
		}
	}
	
}
