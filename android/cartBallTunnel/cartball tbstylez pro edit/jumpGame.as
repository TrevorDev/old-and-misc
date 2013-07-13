package  {
	
	import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class jumpGame extends MovieClip {
		public static var l;
		public static var r;
		public var menu_screen:menu;
		public static var main;
		public function jumpGame() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			main= this;
			
			show_begin();
		}
		public function show_begin()
		{
			
			menu_screen = new menu();
			addChild(menu_screen);
		}
		function keyIsDown(event:KeyboardEvent):void
		{
			
			if (event.keyCode == 39)
			{
				l = true;
			}
			if (event.keyCode == 37)
			{
				r = true;
			}
		}
		function keyIsUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 39)
			{
				l = false;
			}
			if (event.keyCode == 37)
			{
				r = false;
			}
		}
	}
	
}
