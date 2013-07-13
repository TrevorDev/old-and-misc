package  {
	
	import flash.display.MovieClip;
	
	
	public class bad3 extends badGuy {
		
		public var shotCounter = 0;
		public function bad3() {
			maxHealth = 10;
			health=maxHealth;
			this.stop();
			this.hit.visible=false;
		}
		
		override public function run(){
			if(this.currentFrame==this.totalFrames){
				this.gotoAndStop(0);
			}
			if(shotCounter++ > 25){
				if(player.p1.x>this.x-600){
					var shot = new bad1();
					shot.x=this.x;
					shot.y=this.y+100;
					var rand = Math.ceil(Math.random()*3);
					if(rand==1){
						shot.y+=0;
					}else if(rand==2){
						shot.y+=(360/3)*1;
					}else{
						shot.y+=(360/3)*2;
					}
					parent.addChild(shot);
					shotCounter=0;
				}
			}
		}
		
		override public function getHit(){
			this.gotoAndPlay(0);
			health--;
			trace();
			if(health<=0){
				die();
				return true;
			}
			return false;
		}
	}
	
}
