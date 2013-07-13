package  {
	
	import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	import fl.transitions.easing.None;
	
	public class input extends MovieClip {
		
		public static var left,right,up,down,enterKey,attack = false,fFive:Boolean = false, escKey = false, one, two, three;
		public static var stageHold;
		public function input(stage) {
			stageHold=stage;
			stage.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
		}
		
		public static function goFullScreen():void
		{
			trace("full");
			stageHold["displayState"] = "fullScreen";

		}
		
		//KEYBOARD INPUT=============================================
		function keyIsDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 70){
				goFullScreen();
			}
			if (event.keyCode == 27)
			{
				input.escKey = true;
			}
			if (event.keyCode == 37)
			{
				input.left = true;
			}
			if (event.keyCode == 38)
			{
				input.up = true;
			}
			if (event.keyCode == 39)
			{
				input.right = true;
			}
			if (event.keyCode == 40)
			{
				input.down = true;
			}
			if (event.keyCode == 13)
			{
				input.enterKey = true;
			}
			if (event.keyCode == 116)
			{
				input.fFive = true;
			}
			if (event.keyCode == 32)
			{
				input.attack = true;
			}
		if (event.keyCode == 49)
			{
				input.one = true;
			}
			if (event.keyCode == 50)
			{
				input.two = true;
			}
			if (event.keyCode == 51)
			{
				input.three = true;
			}
		}


		function keyIsUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 27)
			{
				input.escKey = false;
			}
			if (event.keyCode == 37)
			{
				input.left = false;
			}
			if (event.keyCode == 38)
			{
				input.up = false;
			}
			if (event.keyCode == 39)
			{
				input.right = false;
			}
			if (event.keyCode == 40)
			{
				input.down = false;
			}
			if (event.keyCode == 13)
			{
				input.enterKey = false;
			}
			if (event.keyCode == 116)
			{
				input.fFive = false;
			}
			if (event.keyCode == 32)
			{
				input.attack = false;
			}
			if (event.keyCode == 49)
			{
				input.one = false;
			}
			if (event.keyCode == 50)
			{
				input.two = false;
			}
			if (event.keyCode == 51)
			{
				input.three = false;
			}
		}
	}
	
}
