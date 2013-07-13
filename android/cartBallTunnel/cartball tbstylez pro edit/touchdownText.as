package  {
	
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	
	public class touchdownText extends MovieClip {
		public static var touchDown;
		
		public function touchdownText() {
			touchDown=this;
			this.cacheAsBitmap = true;
			this.visible=false;
		}
	}
	
}
