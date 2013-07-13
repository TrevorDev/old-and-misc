package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.transitions.Tween;
	
	import fl.motion.easing.*;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.geom.*;
	
	public class mouseFling extends MovieClip {
			var uid:uint;
			var counter:uint = 1;
			var origX:Number;
			var origY:Number;
			var orig1X:Number;
			var orig1Y:Number;
			var orig2X:Number;
			var orig2Y:Number;
			var orig3X:Number;
			var orig3Y:Number;
			var holding:Boolean = false;
			var thrown:Boolean = false;
			var endEvent;
			
			var timeTaken:uint = 0;
			
			var xSpeed:Number = 0;
			var ySpeed:Number = 0;
			
			var finalX:Number = 0;		
			var finalY:Number = 0;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			var fl_DragBounds:Rectangle;
			
		public function mouseFling(uid:uint) {
			this.uid = uid;
			fl_DragBounds = new Rectangle(0, 100, 320, 400);
			this.addEventListener(TouchEvent.TOUCH_BEGIN, fl_TouchBeginHandler);
			this.addEventListener(TouchEvent.TOUCH_END, fl_TouchEndHandler);
			this.addEventListener(Event.ENTER_FRAME, updateCounter);
		}

		function updateCounter(evt:Event):void
		{
			if(!thrown) {
				if(this.x > 320) {
					thrown = true;
				}
			}
			// keep within throwing range
			if(holding) {
				if(this.x >= 320) {
					this.x = 300;
					//xSpeed = 0;
					//ySpeed = 0;
					holding = false;
					fl_TouchEndHandler(endEvent);
				}
				if(this.y <= 100) {
					this.y = 99;
					//xSpeed = 0;
					//ySpeed = 0;
					holding = false;
				}
			}
			
			if(this.hitTestObject(flingScreen.screen.wallwin)) {
				flingScreen.screen.addPoint();
				if(flingScreen.screen.windowGlass.currentFrame == 1) {
					flingScreen.screen.windowGlass.play();
				}
				this.removeEventListener(TouchEvent.TOUCH_BEGIN, fl_TouchBeginHandler);
				this.removeEventListener(TouchEvent.TOUCH_END, fl_TouchEndHandler);
				this.removeEventListener(Event.ENTER_FRAME, updateCounter);
				flingScreen.screen.removeMouse(uid);
			}
			
			if(this.hitTestObject(flingScreen.screen.wall1)) {
				xSpeed *= -0.5;
				ySpeed *= -0.5;
				if(this.x < flingScreen.screen.wall1.x) {
					this.x = 295;
				}
				else
				{
					this.x += 5;
				}
				return;
			}
			if(this.hitTestObject(flingScreen.screen.wall2)) {
				xSpeed *= -0.5;
				ySpeed *= -0.5;
				this.x -= 5;
			}
			if(this.hitTestObject(flingScreen.screen.wall3)) {
				xSpeed *= -0.5;
				ySpeed *= -0.5;
				this.x -= 5;
				this.y += 10;
			}

			if(holding)
			{
				origX = orig2X;
				origY = orig2Y;
				orig1X = orig2X;
				orig1Y = orig2Y;
				orig2X = orig3X;
				orig2Y = orig3Y;
				orig3X = this.x;
				orig3Y = this.y;
			}
			else
			{
				this.y += 10;
				this.rotation += ySpeed;
			}
			counter++;

			this.x -= xSpeed;
			this.y -= ySpeed;
			
			xSpeed *= 0.98;
			ySpeed *= 0.98;
			
			// keep within stage
			if(this.x < 20) {
				this.x = 20;
			}
			if(this.x > 800) {
				this.x = 800;
			}
			if(this.y < -20) {
				this.y = -20;
			}
			if(this.y > 400) {
				this.y = 400;
			}
		}
		
		function fl_TouchBeginHandler(event:TouchEvent):void
		{
			if(this.x < 320 && this.y > 100) {
				holding = true;
				xSpeed = 0;
				ySpeed = 0;
				orig3X = this.x;
				orig3Y = this.y;
				counter = 1;
				event.target.startTouchDrag(event.touchPointID, false, fl_DragBounds);
				endEvent = event;
			}
		}
		
		function fl_TouchEndHandler(event:TouchEvent):void
		{
			holding = false;
			timeTaken = counter;
			finalX = this.x;
			finalY = this.y;
			var distanceX = origX - finalX;
			var distanceY = origY - finalY;
			event.target.stopTouchDrag(event.touchPointID);
			if(abs(distanceX) > 10)
				xSpeed = 2 / (timeTaken / distanceX);
			else
				xSpeed = 0;
			if(abs(distanceY) > 10)
				ySpeed = 2 / (timeTaken / distanceY);
			else
				ySpeed = 0;
		}		
		
		public function abs( value:Number ):Number
		{
			return value < 0 ? -value : value;
		}
		
	}
}
