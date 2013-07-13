package  {
	
	import flash.display.MovieClip;
	
	
	public class backround extends MovieClip {
		public static var ar = new Array();
		public static var mid;
		public static var left;
		public static var right;
		public static var middle;
		public static var extra;
		public var depth=0.3;
		public var img=0;
		public var offset=0;
		
		public function backround() {
			ar.push(this);
			if(ar.length==1){
				mid=this;
			}else if(ar.length==2){
				left=this;
			}else{
				right=this;
			}
		}
		public function follow():void
		{
			if(left==this){
				this.y=backround.mid.y;
				this.x=backround.mid.x+this.width/2;
			}else if(right==this){
				this.y=backround.mid.y;
				this.x=backround.mid.x-this.width/2;
			}else{
				var wid = this.width/2;
			while(!((this.x-wid<player.p1.x)&&(this.x+wid>player.p1.x))){
				
				if(player.p1.x>this.x){
					this.x+=this.width;
					offset+=this.width;
				}else{
					this.x-=this.width;
					offset-=this.width;
				}
			}
			this.x=offset+(-root.x*this.depth);
			this.y=-root.y*this.depth;
			}
		}
	}
	
}
