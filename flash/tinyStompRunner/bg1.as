package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;


	public class bg1 extends MovieClip
	{
		public static var bg1MC:bg1;
		public static var ar:Array = new Array();
		public function bg1()
		{
			ar.push(this);
		}
		public static function generateBg1(event:Event):void
		{
			var walls = bg1.ar;
			var maxWalls = 10;
			for (var j=0; j<walls.length; j++)
			{
				walls[j].x +=  guy.ar[0].xSpeed * 0.95;
			}

			while (walls.length<maxWalls)
			{

				bg1MC = new bg1();
				runner.main.game_screen.addChildAt(bg1MC,walls[0].parent.getChildIndex(walls[0]));
				bg1MC.width = walls[walls.length - 2].width;
				bg1MC.x = walls[walls.length - 2].x + walls[walls.length - 2].width - 66-4;
				bg1MC.y = walls[walls.length - 2].y;
			}

			for (var i=0; i<walls.length; i++)
			{
				if (walls[i].x - cam.camera.x <= -1500)
				{
					walls[i].parent.removeChild(walls[i]);
					walls.splice(i,1);
				}
			}

		}
	}

}