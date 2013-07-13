package  {
	
	import flash.display.MovieClip;
	
	
	public class bad2 extends badGuy {
		
		public var origX;
		public var nextX=0;
		public var right=true;
		public var init = false;
		public function bad2() {
			origX=this.x;
			this.spd=5
			this.gotoAndStop(this.totalFrames);
			this.hit.visible=false;
			
		}
		
		public function revive(){
			activeBad=true;
		}
		
		override public function die(){
			activeBad=false;
			this.gotoAndPlay(0);
			this.x=origX+((nextX)*Math.random());
		}
		
		override public function run(){
			if(!init){
				init=true;
				die();
			}
			if(!activeBad){
				if(this.totalFrames==this.currentFrame){
					activeBad=true;
				}
			}else{
			if(this.x<origX){
				right=true;
			}
			if(this.x>origX+nextX){
				right=false;
			}
			if(right){
				this.x+=spd;
			}else{
				this.x-=spd;
			}
			}
		}
		
	}
	
}
