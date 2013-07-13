package  {
	
import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	
	
	public class ending extends MovieClip {
		public static var endings:Array = new Array();
		public var health =5;
		
		public function ending() {
			endings.push(this);
		}
		public static function hit(item:MovieClip):void
		{
			if(item.health>0&&guy.players[0].sprite.weapon.hit1.currentFrame==5&&item.hitTestObject(guy.players[0].sprite.weapon.hit1.wepHitbox)){
					item.health-=1;
					if(item.health>0){
					item.gotoAndPlay(1);
					}else{
						item.gotoAndPlay(16);
					}
			}
		}
	}
	
}
