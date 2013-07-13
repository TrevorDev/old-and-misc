package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Point;
	import flash.geom.Matrix;

	public class character extends MovieClip
	{
		public static var ar:Array = new Array();
		public static var grav = 1;
		public var ySpd = 0;
		public var xSpd = 0;
		public static var jumps = false;
		public var surfaceXSpd = 0;
		public static var lefter = false;
		public static var righter = false;
		public static var leftC = 0;
		public static var rightC = 0;
		public static var jump = 0;
		public static var inX;
		public static var inY;
		public static var dead = false;
		public static var win = false;
		public static var winC = 0;
		public static var walk = false;
		public static var deadStart = false;
		public function character()
		{
			winC = 0;
			this.cacheAsBitmap = true;

			character.ar.push(this);
			inX = this.x;
			inY = this.y;
			dead = false;
			win = false;
		}
		public static function movePlayer(event:Event):void
		{

			if (dead)
			{
				win = false;
				walk = false;
				if (! deadStart)
				{
					character.ar[0].sprite.gotoAndPlay(40);
					deadStart = true;
				}
				if (character.ar[0].sprite.currentFrame == 80)
				{
					deadStart = false;
					dead = false;
					character.ar[0].sprite.gotoAndStop(1);
					character.ar[0].x = cart.inX;
					character.ar[0].y = cart.inY - 100;
					cart.ar[0].x = cart.inX;
					cart.ar[0].y = cart.inY;
					cartballTunnel.main.x=-cart.inX+275;;
					cart.moving = false;
				}
			}
			else if (jump!=0)
			{
				if (lefter)
				{
					character.ar[0].sprite.scaleX = -1;
				}
				else
				{
					character.ar[0].sprite.scaleX = 1;
				}
				character.ar[0].sprite.gotoAndStop(25);
				walk = false;
			}
			else if (cartballTunnel.leftDown)
			{
				character.ar[0].sprite.scaleX = -1;
				if (! walk)
				{
					character.ar[0].sprite.gotoAndPlay(1);
				}
				else
				{
					if (character.ar[0].sprite.currentFrame >= 20)
					{
						character.ar[0].sprite.gotoAndPlay(1);
					}
				}
				walk = true;
			}
			else if (cartballTunnel.rightDown)
			{
				character.ar[0].sprite.scaleX = 1;
				if (! walk)
				{
					character.ar[0].sprite.gotoAndPlay(1);
				}
				else
				{
					if (character.ar[0].sprite.currentFrame >= 20)
					{
						character.ar[0].sprite.gotoAndPlay(1);
					}
				}
				walk = true;
			}
			else
			{
				character.ar[0].sprite.gotoAndStop(1);
				walk = false;
			}
			var movSpd = 7;
			character.ar[0].xSpd = character.ar[0].surfaceXSpd;
			character.ar[0].ySpd +=  grav;

			if (cartballTunnel.midDown)
			{
				character.ar[0].ySpd = -10;
			}

			if (cartballTunnel.leftDown && cartballTunnel.rightDown && jump <= 1 && ! jumps)
			{

				jumps = true;
				jump++;
				character.ar[0].ySpd = -10;

			}
			else
			{
				if (!(cartballTunnel.leftDown && cartballTunnel.rightDown))
				{
					jumps = false;
				}
			}

			if (jump&&(cartballTunnel.leftDown && cartballTunnel.rightDown))
			{
				trace("left   "+lefter);
				if (lefter)
				{
					character.ar[0].xSpd -=  movSpd;
				}
				trace("right   "+righter);
				if (righter)
				{
					character.ar[0].xSpd +=  movSpd;
				}
			}
			if (!(cartballTunnel.leftDown && cartballTunnel.rightDown))
			{
				if (cartballTunnel.leftDown)
				{
					character.ar[0].xSpd -=  movSpd;
					leftC++;
					if (! righter && leftC >= 5)
					{
						lefter = true;
					}

				}
				else
				{
					leftC = 0;
					lefter = false;
				}
				if (cartballTunnel.rightDown)
				{
					character.ar[0].xSpd +=  movSpd;
					rightC++;
					if (! lefter && rightC >= 5)
					{
						righter = true;
					}
				}
				else
				{
					rightC = 0;
					righter = false;
				}
			}

			cartballTunnel.midDown = false;
			character.ar[0].y +=  character.ar[0].ySpd;
			character.ar[0].x +=  character.ar[0].xSpd;
			//wining is in touchdown
		}
	}

}