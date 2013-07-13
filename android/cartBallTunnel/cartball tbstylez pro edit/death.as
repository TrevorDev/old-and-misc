package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;
	
	public class death extends MovieClip {
		public static var ar:Array = new Array();
		public static var grav=0;
		public var ySpd=0;
		public function death() {
			this.cacheAsBitmap = true;

			death.ar.push(this);
		}
		public static function moveDeath(event:Event):void
		{
			
			for(var i=0;i<death.ar.length;i++){
				if(death.ar[i].hitTestObject(character.ar[0].hitBox)){
					character.dead=true;
					
					cart.moving=false;
				}
			}
		}
	}
	
}
