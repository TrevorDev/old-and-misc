package 
{

	import flash.display.MovieClip;


	public class healthbox extends MovieClip
	{
		public static var hBox;
		var health:Array = new Array  ;
		public function healthbox()
		{
			hBox = this;
			checkHeart();

		}
		public function checkHeart()
		{
			

			for (var i=health.length-1; i>=0; i--)
			{
				removeChild(health[i]);
				health[i] = null;
				health.splice(i,1);
			}

			for (i=0; i<guy.players[0].healthNum; i++)
			{

				var newHeart:heart = new heart  ;
				newHeart.x = 50 * i;
				newHeart.y = 10;
				addChild(newHeart);
				health[i] = newHeart;


			}
		}
	}

}