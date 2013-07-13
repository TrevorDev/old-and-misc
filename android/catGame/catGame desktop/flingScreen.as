package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Bitmap;

	
	public class flingScreen extends MovieClip {
		static var screen;
		var mice:Array = new Array;
		var myTimer:Timer = new Timer(1600); // 1.6 seconds
		var checkDoneTimer:Timer = new Timer(5000); // 5 seconds
		var infoCounter = 0;
		var doneFlag:Boolean = false;
		var onepointsymbol;
		var pointCounter = 0;
		var score = 0;
		var totalMice;
		
		public function flingScreen(mouseAmount:int) {
			finishedText.visible = false;
			screen = this;
			totalMice = mouseAmount;
			var i:int;
			for (i = 0; i < mouseAmount; i++) 
			{
				addMouse();
			}
			myTimer.addEventListener(TimerEvent.TIMER, showinfo);
			myTimer.start();
			checkDoneTimer.addEventListener(TimerEvent.TIMER, checkDone);
			checkDoneTimer.start();
		}
		
		public function addMouse() {
			var guy = new mouseFling(mice.length);
			guy.x = (Math.random()*200)+50;
			guy.y = (Math.random()*100)+150;
			mouselayer.addChild(guy);
			mice.push(guy);
		}
		
		public function removeMouse(uid:uint) {
			if(mice[uid] != null) {
				mouselayer.removeChild(mice[uid]);
				mice[uid] = null;
			}
		}
		
		function showinfo(event:TimerEvent):void {
			if(flinginfo.visible) {
				flinginfo.visible = false;
			}
			else {
				flinginfo.visible = true;
			}
			infoCounter++;
			if(infoCounter >= 6) {
				flinginfo.alpha = 0.3;
				removeTimer();
			}
		}
		function removeTimer() {
			if(myTimer) {
				myTimer.stop();
				myTimer.removeEventListener(TimerEvent.TIMER, showinfo);
				myTimer = null;
			}
		}
		
		function unloadScreen() {
			removeTimer();
			if(checkDoneTimer) {
				checkDoneTimer.stop();
				checkDoneTimer.removeEventListener(TimerEvent.TIMER, showinfo);
				checkDoneTimer = null;
			}
			var i:int; 
			for (i = 0; i < mice.length; i++) 
			{
				removeMouse(i);
			}
			removePoint();
		}
		
		function checkDone(event:TimerEvent):void {
			if(doneFlag == true) {
				catGame.main.unloadFlingScreen();
				catGame.main.showFlingScore(score,totalMice);
				return;
			}
			var i:int; 
			for (i = 0; i < mice.length; i++) 
			{
				if(mice[i] && mice[i].thrown == false) {
					return;
				}
			}
			doneFlag = true;
			finishedText.visible = true;
		}
		
		public function addPoint() {
			removePoint();
			score += 1;
			if(catGame.getVol() > 0) {
				catGame.windowSound.play();
			}
			onepointsymbol = new AddPointMC();
			onepointsymbol.x = 600;
			onepointsymbol.y = 100;
			mouselayer.addChild(onepointsymbol);
			pointCounter = 0;
			this.addEventListener(Event.ENTER_FRAME, pointFrameUpdater);
		}
		
		function pointFrameUpdater(evt:Event) {
			onepointsymbol.x -= 1;
			onepointsymbol.y -= 1;
			onepointsymbol.alpha -= 0.02;
			pointCounter += 1;
			if(pointCounter >= 200) {
				pointCounter = 0;
				removePoint();
			}
		}
		
		public function removePoint() {
			if(onepointsymbol) {
				mouselayer.removeChild(onepointsymbol);
				this.removeEventListener(Event.ENTER_FRAME, pointFrameUpdater);
				onepointsymbol = null;
			}
		}
		
	}
	
}
