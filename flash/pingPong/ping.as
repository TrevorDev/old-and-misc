package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class ping extends MovieClip
	{
		public static var ar:Array = new Array();
		public static var grav = 2;
		public var xSpd = 5;
		public var ySpd = 10;
		public function ping()
		{
			ar.push(this);
		}
		public static function spd(event:Event):void
		{
			
			for (var i = 0; i<ping.ar.length; i++)
			{

				ping.ar[i].x +=  ping.ar[i].xSpd;
				ping.ar[i].y +=  ping.ar[i].ySpd;
				
			}
		}
		
		public static function gravity(event:Event):void
		{
			for (var i = 0; i<ping.ar.length; i++)
			{

				
				ping.ar[i].ySpd +=  grav;
				
			}
		}
	}

}