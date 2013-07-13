package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	

	public class coin extends MovieClip
	{
		public static var coins:Array = new Array();
public static var num:Number = -1;
public var indexs = 0;
		public static var score:Number = 0;
		public function coin()
		{
			this.stop();
			num++;
			coins[num] = this;
			indexs = num;
			
		}

		public static function update(item:MovieClip):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{

				if (item.hitTestObject(guy.players[i].body) && item.currentFrame == 1)
				{
					guy.players[i].coinNum++;
					item.play();
					coinCount.coinScore[0].updatescore(guy.players[i].coinNum);
				}

			}


			if (item.currentFrame == item.totalFrames)
			{
				for(i=item.indexs+1;i<coin.coins.length;i++){
					coin.coins[i].indexs--;
				}
				coin.coins.splice(item.indexs, 1);
				item.parent.removeChild(item);
			}

		}

	}

}