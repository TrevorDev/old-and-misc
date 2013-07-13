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
			camera.outer.visible=false;
			camera.inner.visible=false;
			camera.x = guy.ar[0].x;
			camera.y = guy.ar[0].y;
			wid=outer.width / 2;
			high=outer.height / 2;
			zombiecash.main.x =  -  this.x + wid;
			zombiecash.main.y =  -  this.y + high;

		}
		public static function makeCam(event:Event):void
		{
			for (var i = 0; i<guy.ar.length; i++)
			{
				ySpd = 0;
				xSpd = 0;
				if (guy.ar[i].y>camera.y+camera.inner.height/2||guy.ar[i].y<camera.y-camera.inner.height/2)
				{

					ySpd = Math.abs(5)*((guy.ar[i].y-camera.y)/125);
					

				}
				if (guy.ar[i].x>camera.x+camera.inner.width/2||guy.ar[i].x<camera.x-camera.inner.width/2)
				{


					xSpd = Math.abs(5)*((guy.ar[i].x-camera.x)/125);
					
				}
				camera.x +=  xSpd;
				camera.y +=  ySpd;
				zombiecash.main.x =  -  camera.x + wid;
			zombiecash.main.y =  -  camera.y + high;
				
			}
		}
	}

}