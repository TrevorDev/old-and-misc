package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.display.MovieClip;


	public class guy extends MovieClip
	{
		public static var army:Array = new Array();
		public var index = 0;

		public var health = 200;
		public var dmg = 3;
public static var create = 1;
		public static var mGive = 10;
		public var spd = 5;
		public var xSpd = 0;
		public var ySpd = 0;
		public var xChange = 0;
		public var yChange = 0;
		public var similar = 0;
		public var i = 0;
		public function guy()
		{
			
			this.gotoAndStop(create);
			spd+=create-1;
			dmg*=create*create*create;
			health*=create*create;
			this.addEventListener(Event.ENTER_FRAME, movePlayer, false, 0, true);
			index = army.push(this) - 1;
			hitBox.visible=false;
		}
		function movePlayer(event:Event):void
		{
			
			if (((stage.mouseX-root.x)>(this.x+mGive)||(stage.mouseX-root.x)<(this.x-mGive)||((stage.mouseY-root.y)>(this.y+mGive)||(stage.mouseY-root.y)<(this.y-mGive))))
			{
				xChange = (stage.mouseX-root.x) - this.x;
				yChange = (stage.mouseY-root.y) - this.y;
				similar = spd / Math.sqrt(xChange * xChange + yChange * yChange);
				xSpd = similar * xChange;
				ySpd = similar * yChange;
				this.x +=  xSpd;
				this.y +=  ySpd;

				for (i=0; i<guy.army.length; i++)
				{
					if (i != index)
					{
						while (this.appear.hitTestObject(army[i].appear))
						{
							this.x -=  xSpd;
							this.y -=  ySpd;
						}
					}
				}

			}
			for (i=0; i<bad1.badGuy.length; i++)
				{
					if (this.hitBox.hitTestObject(bad1.badGuy[i].appear))
						{
							bad1.badGuy[i].health-=dmg;
							bad1.badGuy[i].healthCheck();
							bad1.badGuy[i].hBar.checkHealth(bad1.badGuy[i]);
							i=bad1.badGuy.length;
							
						}
				}

		}
		function healthCheck()
		{
			if (health <= 0)
			{
				
				this.removeEventListener(Event.ENTER_FRAME, movePlayer);
				parent.removeChild(this);
				for (i=index+1; i<guy.army.length; i++)
				{
					guy.army[i].index--;
				}
				army.splice(index, 1);
			}
		}
	}

}