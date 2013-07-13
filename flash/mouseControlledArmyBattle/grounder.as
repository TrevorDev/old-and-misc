package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class grounder extends MovieClip
	{
		public static var allGround:Array = new Array();
		public static var varX = 0;
		public static var varY = 0;
		public static var wid = 0;
		public static var hight;
		public static var j;
		public var index = 0;
		public var newGround:grounder;
		public function grounder()
		{
			index = allGround.push(this) - 1;
			this.addEventListener(Event.ENTER_FRAME, ground, false, 0, true);
		}
		function ground(event:Event):void
		{
			if (index != 4)
			{
				if (allGround.length < 2)
				{
					wid = this.width;
					hight = this.height;
					varX = this.x - wid;
					varY = this.y - hight;

					for (var i=allGround.length-1; i>=0; i--)
					{
						allGround[i].removeEventListener(Event.ENTER_FRAME, ground);
						gameScreen.gamescreen.removeChild(allGround[i]);
						allGround.splice(allGround[i].index, 1);
					}

					for (i=0; i<3; i++)
					{
						for (j=0; j<3; j++)
						{
							newGround = new grounder();
							newGround.x=varX+(j*wid);
							newGround.y=varY+(i*hight);
							gameScreen.gamescreen.addChildAt(newGround,0);
						}
					}
				}

				if (this.hitTestObject(mouse.mice.point))
				{
					if (index == 0)
					{
						varX =  -  wid;
						varY =  -  hight;
					}
					else if (index ==1)
					{
						varX = 0;
						varY =  -  hight;
					}
					else if (index ==2)
					{
						varX = wid;
						varY =  -  hight;
					}
					else if (index ==3)
					{
						varX =  -  wid;
						varY = 0;
					}
					else if (index ==5)
					{
						varX = wid;
						varY = 0;
					}
					else if (index ==6)
					{
						varX =  -  wid;
						varY = hight;
					}
					else if (index ==7)
					{
						varX = 0;
						varY = hight;
					}
					else if (index ==8)
					{
						varX = wid;
						varY = hight;
					}
					for (i=0; i<allGround.length; i++)
					{
						allGround[i].x +=  varX;
						allGround[i].y +=  varY;
					}
				}
			}

		}
	}

}