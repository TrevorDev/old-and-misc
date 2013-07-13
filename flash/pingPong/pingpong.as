package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	
	public class pingpong extends MovieClip {
		public static var main;
		public var game:level1;
		public function pingpong() {
			showGameScreen();
		}
		public function showGameScreen()
		{
			main = this;
			root.x = 0;
			root.y = 0;
			game = new level1();
			addChild(game);
		}
	}
	
}
