package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class room extends MovieClip
	{

		public static var ar:Array = new Array();
		public var activeWall:Array = new Array();
		public var posibleWall:Array = new Array();
		public var activ = false;
		public var ref = 0;

		public function room()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initHandler);
			this.visible = false;
		}

		private function initHandler(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initHandler);
			room.ar[ref] = this;
		}

		public static function activate(event:Event):void
		{
			for (var i = 0; i<room.ar.length; i++)
			{

				for (var j=0; j<guy.ar.length; j++)
				{
					if (guy.ar[j].hitTestObject(room.ar[i]))
					{
						guy.ar[j].roomIn=i;
						
						if (! room.ar[i].activ)
						{
							room.ar[i].activ = true;
if(room.ar[i].activeWall[0]!=-1){
							for (var k=0; k<room.ar[i].activeWall.length; k++)
							{
								blocker.ar[room.ar[i].activeWall[k]].roomIn = i;
								
								blocker.ar[room.ar[i].activeWall[k]].activ = true;

							}
}
						}
					}
				}
			}
		}

	}

}