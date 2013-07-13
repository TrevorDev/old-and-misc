package 
{


	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.TransformGestureEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;

	public class menu extends MovieClip
	{
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		public static var midDown = false;
		public static var leftDown = false;
		public static var rightDown = false;
		public function menu()
		{

			buttons.ar[0].addEventListener(TouchEvent.TOUCH_BEGIN, touchMid);
			buttons.ar[2].addEventListener(TouchEvent.TOUCH_BEGIN, touchLeft);
			buttons.ar[2].addEventListener(TouchEvent.TOUCH_END, stopTouchLeft);
			buttons.ar[1].addEventListener(TouchEvent.TOUCH_BEGIN, touchRight);
			buttons.ar[1].addEventListener(TouchEvent.TOUCH_END, stopTouchRight);

			addEventListener(Event.ENTER_FRAME, character.movePlayer, false, 0, true);
			addEventListener(Event.ENTER_FRAME, cart.moveCart, false, 0, true);
			addEventListener(Event.ENTER_FRAME, block.blocker, false, 0, true);
			addEventListener(Event.ENTER_FRAME, death.moveDeath, false, 0, true);
			//addEventListener(Event.ENTER_FRAME, keyBoard, false, 0, true);
			

		}
		public static function keyBoard(event:Event)
		{

			if(jumpGame.l==true){
				
				rightDown=true;
			}else{
				rightDown=false;
			}
			
			if(jumpGame.r==true){
				
				leftDown=true;
			}else{
				leftDown=false;
			}

		}
		public static function touchMid(event:TouchEvent)
		{

			midDown = true;

		}
		public static function touchLeft(event:TouchEvent)
		{

			leftDown = true;

		}
		public static function stopTouchLeft(event:TouchEvent)
		{

			leftDown = false;

		}
		public static function touchRight(event:TouchEvent)
		{

			rightDown = true;

		}
		public static function stopTouchRight(event:TouchEvent)
		{

			rightDown = false;

		}
	}

}