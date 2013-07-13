package  {
	
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	
	public class button extends MovieClip {
		public static var ar:Array = new Array();
		
		public function button() {
			this.cacheAsBitmap = true;
			button.ar.push(this);
		}
	}
	
}
