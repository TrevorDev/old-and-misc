package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class death extends MovieClip
	{
		public static var death:Array = new Array();

		public function death()
		{
			this.visible=false;
			death.push(this);
			
		}
		public static function hit(item:MovieClip):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (item.hitTestObject(guy.players[i].body))
				{
					guy.players[i].healthNum=0;
					healthbox.hBox.checkHeart();
					guy.players[i].diedCheck(null);
				}
			}

		}
	}

}