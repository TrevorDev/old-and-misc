package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;


	public class block extends MovieClip
	{
		public static var ar:Array = new Array();
		public var xSpd = 0;

		public function block()
		{
			this.cacheAsBitmap = true;
			
			block.ar.push(this);
		}
		public static function blocker(event:Event):void
		{
			var item=new Array();
			item = block.ar;
			for (var i=0; i<item.length; i++)
			{
				if (item[i].hitTestObject(character.ar[0].hitBox.down))
				{
					while (item[i].hitTestObject(character.ar[0].hitBox.down))
					{
						character.ar[0].y--;
					}
					character.jump=0;
					character.ar[0].surfaceXSpd = item[i].xSpd;
					character.ar[0].ySpd =  -  character.grav;
				}else if (item[i].hitTestObject(character.ar[0].hitBox.right))
				{
					while (item[i].hitTestObject(character.ar[0].hitBox.right))
					{
						character.ar[0].x--;
					}
					if(!cart.cartSide){
					character.ar[0].surfaceXSpd = item[i].xSpd;
					}
				}else if (item[i].hitTestObject(character.ar[0].hitBox.left))
				{
					while (item[i].hitTestObject(character.ar[0].hitBox.left))
					{
						character.ar[0].x++;
					}
					if(!cart.cartSide){
					character.ar[0].surfaceXSpd = item[i].xSpd;
					}
				}
				else if (item[i].hitTestObject(character.ar[0].hitBox.up))
				{
					while (item[i].hitTestObject(character.ar[0].hitBox.up))
					{
						character.ar[0].y++;
					}
				}
				
			}
		}
	}

}