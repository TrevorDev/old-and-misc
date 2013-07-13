package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class HUD extends MovieClip
	{
		public static var hud;
		public var spd = 7;
		public var xChange = 0;
		public var yChange = 0;
		public var similar = 0;
		public function HUD()
		{
			hud = this;
			this.addEventListener(Event.ENTER_FRAME, cams, false, 0, true);
		}
		function cams(event:Event):void
		{
			if (mouse.mice.point.hitTestObject(side1) || mouse.mice.point.hitTestObject(side2) || mouse.mice.point.hitTestObject(side3) || mouse.mice.point.hitTestObject(side4))
			{
				xChange = (stage.mouseX-root.x) - this.x;
				yChange = (stage.mouseY-root.y) - this.y;
				similar = spd / Math.sqrt(xChange * xChange + yChange * yChange);
				this.x +=  similar * xChange;
				root.x =  -this.x+(this.width/2);
				
				if (similar * yChange < 0 || root.y > -100)
				{
					this.y +=  similar * yChange;
					root.y =  -this.y+(this.height/2);
					
				}
				
				
					bad1.spawnType=Math.floor((root.y+500)/500);
				if(bad1.spawnType<=0){
					bad1.spawnType=1;
				}
				trace(bad1.spawnType);
			}
		}
	}

}