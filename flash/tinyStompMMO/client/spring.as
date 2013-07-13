package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;

	public class spring extends MovieClip
	{
		public static var springs:Array = new Array();

		public function spring()
		{
			springs.push(this);
		}

		public static function hit(item:MovieClip):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (item.hitTestObject(guy.players[i].body) && guy.players[i].ySpeed > 0)
				{
					guy.players[i].ySpeed = -25;



				}
			}
		}
	}

}