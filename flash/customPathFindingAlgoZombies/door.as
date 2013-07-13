package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class door extends MovieClip
	{
		public static var ar:Array = new Array();
		public var connect:Array = new Array();
		public var ref = 0;
		public var cost = 0;
		public function door()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, initHandler);


			this.doorHit.visible = false;

			wall.ar.push(this.wallBox);
		}

		private function initHandler(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, initHandler);
			door.ar[ref] = this;

		}

		public static function makeDoor(event:Event):void
		{
			for (var j = 0; j<guy.ar.length; j++)
			{
				var doorHiter = false;
				for (var i = 0; i<door.ar.length; i++)
				{



					if (door.ar[i].hitTestObject(guy.ar[j].hitBox))
					{
						doorHiter = true;
						if (door.ar[i].visible)
						{
							dialogue.ar[j].displayWords(String("Open Door:"+door.ar[i].cost));
						}
						else
						{
							dialogue.ar[j].hideWords();
						}
						if (zombiecash.main.enterKey)
						{
							if (door.ar[i].visible && guy.ar[j].cash >= door.ar[i].cost)
							{
								wall.ar.splice(wall.ar.indexOf(door.ar[i].wallBox), 1);
								guy.ar[j].cash -=  door.ar[i].cost;
								ammoDisplay.ar[j].displayCash(guy.ar[j]);
								door.ar[i].visible = false;
							}

						}

					}
				}
				if (! doorHiter)
				{
					dialogue.ar[j].hideWords();
				}

			}
		}
	}

}