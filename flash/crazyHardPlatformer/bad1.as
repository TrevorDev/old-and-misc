package  {
	
	import flash.display.MovieClip;
	
	
	public class bad1 extends badGuy {
		
		public function bad1() {
			spd=10;
		}
		
		override public function run(){
			if(player.p1.x>this.x-600){
				this.x-=spd;
			}
		}
	}
	
}
