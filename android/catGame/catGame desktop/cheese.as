package  {
	
	import flash.display.MovieClip;
	
	
	public class cheese extends MovieClip {
		var posX=0;
		var posY=0;
		var life = 3;
		var scorer = 0;
		static var ch;
		var gameEnd=false;
		var endFrame = 0;
		var maxFrame = 70;
		public function cheese() {
			ch=this;
			stop();
		}
		
		public function loseLife(){
			life--;
			this.gotoAndStop(4-life)
			
			if(!gameEnd&&this.life<=0){
				playingScreen.screen.gOver.play();
				gameEnd=true;
			}
		}
	}
	
}
