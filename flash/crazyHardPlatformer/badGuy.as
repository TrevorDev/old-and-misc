package  {
	
	import flash.display.MovieClip;
	
	
	public class badGuy extends MovieClip {
		public static var ar = new Array();
		public var health;
		public var maxHealth = 1;
		public var spd = 3;
		public var activeBad=true;
		
		public function badGuy() {
			badGuy.ar.push(this);
			health=maxHealth;
		}
		public function getHit(){
			health--;
			if(health<=0){
				die();
				return true;
			}
			return false;
		}
		public function die(){
			parent.removeChild(this);
			ar.splice(ar.indexOf(this), 1);
		}
		public function run(){
			
		}
	}
	
}