package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class cam extends MovieClip
	{
		public static var camera;
		public static var xSpd = 0;
		public static var ySpd = 0;
		public static var wid = 0;
		public static var high = 0;

		public function cam()
		{
			
			camera = this;
			wid = runner.main.stage.width;
			high = this.height / 2;
		}

		public static function makeCam(event:Event):void
		{

			for (var i = 0; i<guy.ar.length; i++)
			{
				
					camera.x = guy.ar[0].x;
					runner.main.x =  -  camera.x+wid/20;
					
				
			}

		}

	}

}