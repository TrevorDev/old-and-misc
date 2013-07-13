package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class wall extends MovieClip
	{
		public static var ar:Array = new Array();
		public static var damp = 0.8;
		public static var min = 1;

		public function wall()
		{
			ar.push(this);
		}

		public static function makeWall(event:Event):void
		{

			for (var i = 0; i<wall.ar.length; i++)
			{
				for (var j = 0; j<ping.ar.length; j++)
				{
					
					if (wall.ar[i].hitTestObject(ping.ar[j].down) && ping.ar[j].ySpd > 0)
					{
						
						while (wall.ar[i].hitTestObject(ping.ar[j].down))
						{
							ping.ar[j].y--;
						}
						
						
						if(ping.ar[j].ySpd<3){
							ping.ar[j].ySpd=0;
						}
						ping.ar[j].ySpd *=  -1*damp;
						
						
							
						
					}
					if (wall.ar[i].hitTestObject(ping.ar[j].up) && ping.ar[j].ySpd < 0)
					{
						while (wall.ar[i].hitTestObject(ping.ar[j].up))
						{
							ping.ar[j].y++;
						}
						
						ping.ar[j].ySpd *=  -1*damp;
					}
					if (wall.ar[i].hitTestObject(ping.ar[j].right) && ping.ar[j].xSpd > 0)
					{
						while (wall.ar[i].hitTestObject(ping.ar[j].right))
						{
							ping.ar[j].x--;
						}
						ping.ar[j].xSpd *=  -1*damp;
					}
					if (wall.ar[i].hitTestObject(ping.ar[j].left) && ping.ar[j].xSpd < 0)
					{
						while (wall.ar[i].hitTestObject(ping.ar[j].left))
						{
							ping.ar[j].x++;
						}
						ping.ar[j].xSpd *=  -1*damp;
					}
				}
			}
		}
	}

}