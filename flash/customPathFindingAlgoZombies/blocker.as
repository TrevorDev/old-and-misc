package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class blocker extends MovieClip
	{
		public static var ar:Array = new Array();
		public var ref = 0;
		public var spawnZone=0;
		public var activ=false;
		public var roomIn=0;
		public var str=100;

		public function blocker()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initHandler);

		}
		private function initHandler(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initHandler);
			blocker.ar[ref] = this;
		}
	}

}