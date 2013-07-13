package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;


	public class bg2 extends MovieClip
	{
		public static var bg2MC:bg2;
		public static var ar:Array = new Array();
		public function bg2()
		{
			ar.push(this);
		}
		public static function generateBg2(event:Event):void
		{
			var walls = bg2.ar;
			var maxWalls = 10;
			for (var j=0; j<walls.length; j++)
			{
				walls[j].x +=  guy.ar[0].xSpeed * 0.8;
			}

			while (walls.length<maxWalls)
			{

				bg2MC = new bg2();
				runner.main.game_screen.addChildAt(bg2MC,walls[0].parent.getChildIndex(walls[0]));
				bg2MC.width = walls[walls.length - 2].width;
				bg2MC.x = walls[walls.length - 2].x + walls[walls.length - 2].width - 3-140;
				bg2MC.y = walls[walls.length - 2].y;
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