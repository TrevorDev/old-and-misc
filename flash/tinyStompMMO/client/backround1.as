package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	public class backround1 extends MovieClip {
		
		public static var back:Array = new Array();
		public var depth=0;
		public var img=0;
		public function backround1() {

			back.push(this);
		}
		public static function follow(item:MovieClip):void
		{
			item.gotoAndStop(item.img);
			item.x=-landworld.main.x*item.depth;
			item.y=-landworld.main.y*item.depth;
		}
	}
	
}
