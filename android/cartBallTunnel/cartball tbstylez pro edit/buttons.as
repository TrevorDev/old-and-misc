package  {
	
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	
	public class buttons extends MovieClip {
		
		public static var ar:Array = new Array();
		public function buttons() {
			this.cacheAsBitmap = true;
			buttons.ar.push(this);
		}
	}
	
}
