package  {
	
	import flash.display.MovieClip;
	
	
	public class endlives extends MovieClip {
		
		public var liver;
		public function endlives() {
			liver=this;// constructor code
			cashString.updatescore(String(runner.day)+"  LIVES", liver.totalLives);
		}
	}
	
}
