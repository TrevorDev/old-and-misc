package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import serverHandler;

	public class button extends MovieClip
	{
		public static var buttons:Array = new Array();
		public var link:Number = 0;
		public var sentPacket:Boolean = false;
		public function button()
		{
			buttons.push(this);
			this.addEventListener(Event.ENTER_FRAME, hit, false, 0, true);
		}
		function hit(event:Event):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (this.hitTestObject(guy.players[i].body))
				{
					if(!sentPacket)
					{
						trace("link: " + link);
						serverHandler.serverHand.connection.send("actOn",serverHandler.serverHand.myId,link);
						sentPacket = true;
					}
					// if someone gets off the switch when you're still on
					for (var active in activated.activateds)
					{
						if(link == activated.activateds[active].link)
						{
							if(!activated.activateds[active].moveOn)
							{
								serverHandler.serverHand.connection.send("actOn",serverHandler.serverHand.myId,link);
								sentPacket = true;
							}
						}
					}
				}
				else
				{
					if(sentPacket)
					{
						serverHandler.serverHand.connection.send("actOff",serverHandler.serverHand.myId,link);
						sentPacket = false;
					}
				}

			}

		}
	}

}