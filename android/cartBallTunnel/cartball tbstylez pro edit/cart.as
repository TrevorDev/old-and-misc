package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;


	public class cart extends MovieClip
	{
		public static var moving = false;
		public static var ar:Array = new Array();
		public static var cartSpd = 4;
		public static var cartSide = false;
		public static var inX;
		public static var inY;
		public function cart()
		{
			this.cacheAsBitmap = true;
			cart.ar.push(this);
			cart.moving = false;
			inX = this.x;
			inY = this.y;

		}
		public static function moveCart(event:Event):void
		{

			bg1.bgs1.x =  -  cartballTunnel.main.x * 0.1;
			bg2.bgs2.x =  -  cartballTunnel.main.x * 0.2;
			touchdownText.touchDown.x = -(cartballTunnel.main.x-275);
			if (moving)
			{
				cartSpd = 4;

				if (((- cart.ar[0].x + 275)-cartballTunnel.main.x)<=0)
				{
					cartballTunnel.main.x +=  ((- cart.ar[0].x + 275)-cartballTunnel.main.x)*((- cart.ar[0].x + 275)-cartballTunnel.main.x)*-0.01;
				}
				else
				{
					cartballTunnel.main.x -=  ((- cart.ar[0].x + 275)-cartballTunnel.main.x)*((- cart.ar[0].x + 275)-cartballTunnel.main.x)*-0.01;
				}
				cart.ar[0].x +=  cartSpd;
			}
			else if (! character.dead)
			{

				cartSpd = 0;
				if (((- character.ar[0].x + 275)-cartballTunnel.main.x)<=0)
				{
					cartballTunnel.main.x +=  ((- character.ar[0].x + 275)-cartballTunnel.main.x)*((- character.ar[0].x + 275)-cartballTunnel.main.x)*-0.01;
				}
				else
				{
					cartballTunnel.main.x -=  ((- character.ar[0].x + 275)-cartballTunnel.main.x)*((- character.ar[0].x + 275)-cartballTunnel.main.x)*-0.01;
				}
			}

			if (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.down))
			{
				if (! character.dead && ! character.win)
				{
					if (! cart.moving)
					{
						cart.moving = true;

					}


				}

				character.ar[0].surfaceXSpd = cartSpd;
				character.jump = 0;
				while (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.down))
				{
					character.ar[0].y--;
				}
				character.ar[0].ySpd =  -  character.grav;

			}
			if (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.left))
			{
				cartSide = true;
				character.ar[0].surfaceXSpd = cartSpd;
				while (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.left))
				{
					character.ar[0].x++;
				}
			}
			else
			{
				cartSide = false;
			}
			if (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.right))
			{

				while (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.right))
				{
					character.ar[0].x--;
				}
			}
			if (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.up))
			{

				while (cart.ar[0].hitBox.hitTestObject(character.ar[0].hitBox.up))
				{
					character.ar[0].y++;
				}
			}
			
		}
	}

}