package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Matrix;


	public class touchDown extends MovieClip
	{
		public static var ar:Array = new Array();

		public function touchDown()
		{
			this.visible = false;
			this.cacheAsBitmap = true;
			touchDown.ar.push(this);
		}
		public static function winSpot(event:Event):void
		{
			for (var i=0; i<touchDown.ar.length; i++)
			{
				if (touchDown.ar[i].hitTestObject(character.ar[0].hitBox))
				{
					character.win = true;
					touchdownText.touchDown.visible = true;

				}
				if (touchDown.ar[i].hitTestObject(cart.ar[0]))
				{
					cart.moving = false;
				}

			}
			if (character.win)
			{
				character.winC++;
				if (character.winC>=80)
				{
					cartballTunnel.main.exitGames(null);
				}
			}
		}
	}

}