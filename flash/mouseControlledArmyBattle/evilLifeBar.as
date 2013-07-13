package  {
	
	import flash.display.MovieClip;
	
	
	public class evilLifeBar extends MovieClip {
		
		
		public function evilLifeBar() {
			// constructor code
		}
		public function checkHealth(badItem:MovieClip) {
			this.scaleX=badItem.health/badItem.maxHealth;
		}
	}
	
}
