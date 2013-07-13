package  {
	
import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class mouse extends MovieClip {
		public static var mice;
		public  var xStr=0;
		public  var yStr=0;
		public static  var hitReduce=0.6;
		public function mouse() {
			
			mice=this;
			
		}
		public static function mouser(event:Event):void
		{
			mouse.mice.xStr=mouse.mice.x-pingpong.main.mouseX;
			mouse.mice.yStr=mouse.mice.y-pingpong.main.mouseY;
			mouse.mice.x=pingpong.main.mouseX;
			mouse.mice.y=pingpong.main.mouseY;
			
			for (var i = 0; i<wall.ar.length; i++)
			{
				for (var j = 0; j<ping.ar.length; j++)
				{
					
					if (mouse.mice.hitTestObject(ping.ar[j].down))
					{
						
						while (mouse.mice.hitTestObject(ping.ar[j].down))
						{
							ping.ar[j].y--;
						}
						
						
						
						ping.ar[j].ySpd *=  -1;
						
						ping.ar[j].ySpd-=mouse.mice.yStr*hitReduce;
							
						
					}
					if (mouse.mice.hitTestObject(ping.ar[j].up))
					{
						while (mouse.mice.hitTestObject(ping.ar[j].up))
						{
							ping.ar[j].y++;
						}
						
						ping.ar[j].ySpd *=  -1;
						ping.ar[j].ySpd+=mouse.mice.yStr*hitReduce;
					}
					if (mouse.mice.hitTestObject(ping.ar[j].right))
					{
						while (mouse.mice.hitTestObject(ping.ar[j].right))
						{
							ping.ar[j].x--;
						}
						ping.ar[j].xSpd *=  -1;
						ping.ar[j].xSpd-=mouse.mice.xStr*hitReduce;
					}
					if (mouse.mice.hitTestObject(ping.ar[j].left))
					{
						while (mouse.mice.hitTestObject(ping.ar[j].left))
						{
							ping.ar[j].x++;
						}
						ping.ar[j].xSpd *=  -1;
						ping.ar[j].xSpd+=mouse.mice.xStr*hitReduce;
					}
				}}
		}
	}
	
}