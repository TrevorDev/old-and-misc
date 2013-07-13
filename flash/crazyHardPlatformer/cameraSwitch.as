package  {
	
	import flash.display.MovieClip;
	
	
	public class cameraSwitch extends MovieClip {
		public static var ar = new Array();
		public var yVal = 0;
		public function cameraSwitch() {
			this.visible=false;
			ar.push(this);
		}
	}
	
}
