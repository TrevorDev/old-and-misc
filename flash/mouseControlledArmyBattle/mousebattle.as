package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.ui.Mouse;


	public class mousebattle extends MovieClip
	{

		public var game:gameScreen;
		public var aKey = false;
		public var sKey = false;
		public var dKey = false;
		public var fKey = false;
		public function mousebattle()
		{
			Mouse.hide();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			showGameScreen();

		}
		//KEYBOARD INPUT=============================================
		function keyIsDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 65)
			{
				aKey = true;
			}
			if (event.keyCode == 83)
			{
				sKey = true;
			}
			if (event.keyCode == 68)
			{
				dKey = true;
			}
			if (event.keyCode == 70)
			{
				fKey = true;
			}
		}


		function keyIsUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 65)
			{
				aKey = false;
			}
			if (event.keyCode == 83)
			{
				sKey = false;
			}
			if (event.keyCode == 68)
			{
				dKey = false;
			}
			if (event.keyCode == 70)
			{
				fKey = false;
			}

		}
		public function showGameScreen()
		{
			root.x = 0;
			root.y = 0;
			game = new gameScreen();
			addChild(game);
		}
	}

}