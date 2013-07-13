package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	public class camZone extends MovieClip {
		public static var camZones:Array = new Array();
		public var yVal=0;
		public function camZone() {
			this.visible=false;
			camZones.push(this);
			addEventListener(Event.ENTER_FRAME, hit);
		}
		function hit(event:Event):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
			if (guy.players[0].camY!=yVal&&this.hitTestObject(guy.players[i].body))
				{
					guy.players[0].camY=yVal;
					
					
					
				}
				}
		}
	}
	
}
