package  {
	
	import flash.display.MovieClip;
	
	
	public class expCount extends MovieClip {
		public static var expBar:Array = new Array();
		
		public function expCount() {
			expBar[0]=this;
			this.scaleX=(guy.players[0].expNum-guy.players[0].preLevel)/(guy.players[0].nextLevel-guy.players[0].preLevel);
		}
		public function updateExp(currentExp:Number) {
			this.scaleX=(guy.players[0].expNum-guy.players[0].preLevel)/(guy.players[0].nextLevel-guy.players[0].preLevel);
		}
	}
	
}
