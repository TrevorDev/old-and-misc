package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class wall extends MovieClip
	{
		public static var ar:Array = new Array();

		public function wall()
		{
			ar.push(this);
			if(!zombiecash.main.debug){
				this.visible=false;
			}
			
		}
		public static function makeWall(event:Event):void
		{
			
			var wallar=wall.ar;
			for(var t=0;t<2;t++){
				if(t==1){
					wallar=blocker.ar;
				}
			for (var i = 0; i<wallar.length; i++)
			{
				for (var j = 0; j<guy.ar.length; j++)
				{
					if (wallar[i].hitTestObject(guy.ar[j].hitBox.up))
					{
						if (guy.ar[j].oldY > guy.ar[j].y)
						{
							guy.ar[j].y = guy.ar[j].oldY;
						}


					}
					if (wallar[i].hitTestObject(guy.ar[j].hitBox.down))
					{

						if (guy.ar[j].oldY < guy.ar[j].y)
						{
							guy.ar[j].y = guy.ar[j].oldY;
						}
					}
					if (wallar[i].hitTestObject(guy.ar[j].hitBox.left))
					{
						if (guy.ar[j].oldX > guy.ar[j].x)
						{
							guy.ar[j].x = guy.ar[j].oldX;
						}

					}
					if (wallar[i].hitTestObject(guy.ar[j].hitBox.right))
					{
						if (guy.ar[j].oldX < guy.ar[j].x)
						{
							guy.ar[j].x = guy.ar[j].oldX;
						}

					}
				}
			}
			}
		}
	}

}