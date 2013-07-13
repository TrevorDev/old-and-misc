package 
{

	import flash.display.MovieClip;


	public class back extends MovieClip
	{
		public static var look:Array = new Array();

		public function back()
		{
			this.gotoAndStop(look[guySprite.lookPlayer]);
		}
	}

}