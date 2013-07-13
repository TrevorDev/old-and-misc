package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class checkpoint extends MovieClip {
		public static var checkPoint:Array = new Array();
		public var index:Number = 0;
		public function checkpoint() {
			index=checkPoint.push(this)-1;
			
		}
		public static function hit(item:MovieClip):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (item.hitTestObject(guy.players[i]))
				{
					guy.players[i].checkNum=item.index;
				}
			}

		}
	}
	
}
