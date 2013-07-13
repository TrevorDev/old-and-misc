package  {
	
		import flash.display.StageDisplayState;

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class zombiecash extends MovieClip {
		public var menu_screen:menu;
		public var level_one:level1;
		public static var main;
		public var debug=false;
		public var left,right,up,down,enterKey,attack = false,fFive:Boolean = false, escKey = false, swap, two, three;
		public function zombiecash() {
			main= this;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			show_begin();
			//stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		//INTERFACE==================================================
		public function show_begin()
		{
			
			menu_screen = new menu();
			addChild(menu_screen);
		}
		public function remove_begin()
		{
			if (menu_screen)
			{
				menu_screen.removeEventListener(MouseEvent.CLICK, menu_screen.start_button_clicked);
				removeChild(menu_screen);
				menu_screen = null;
			}
		}
		public function show_game()
		{
			remove_begin();
			level_one = new level1();
			addChild(level_one);
		}
		
		//KEYBOARD INPUT=============================================
		function keyIsDown(event:KeyboardEvent):void
		{
			
			if (event.keyCode == 27)
			{
				escKey = true;
			}
			if (event.keyCode == 37)
			{
				left = true;
			}
			if (event.keyCode == 38)
			{
				up = true;
			}
			if (event.keyCode == 39)
			{
				right = true;
			}
			if (event.keyCode == 40)
			{
				down = true;
			}
			if (event.keyCode == 75)
			{
				enterKey = true;
			}
			if (event.keyCode == 116)
			{
				fFive = true;
			}
			if (event.keyCode == 222)
			{
				attack = true;
			}
		if (event.keyCode == 76)
			{
				swap = true;
			}
			if (event.keyCode == 50)
			{
				two = true;
			}
			if (event.keyCode == 51)
			{
				three = true;
			}
		}


		function keyIsUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 27)
			{
				escKey = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 38)
			{
				up = false;
			}
			if (event.keyCode == 39)
			{
				right = false;
			}
			if (event.keyCode == 40)
			{
				down = false;
			}
			if (event.keyCode == 75)
			{
				enterKey = false;
			}
			if (event.keyCode == 116)
			{
				fFive = false;
			}
			if (event.keyCode == 222)
			{
				attack = false;
			}
			if (event.keyCode == 76)
			{
				swap = false;
			}
			if (event.keyCode == 50)
			{
				two = false;
			}
			if (event.keyCode == 51)
			{
				three = false;
			}
		}
	}
	
}
