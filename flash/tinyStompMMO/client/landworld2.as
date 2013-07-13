package 
{
	import flash.display.MovieClip;
	public class landworld extends MovieClip
	{
		public var begin_screen:begin;
		public var levelone_screen:level_one;

		public function landworld()
		{
			trace("works");
			show_begin();
		}
		public function show_begin()
		{
			trace("works");
			begin_screen = new begin(this);
			addChild(begin_screen);
		}
	}
}