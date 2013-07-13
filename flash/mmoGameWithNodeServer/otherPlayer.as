package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	
	
	public class otherPlayer extends MovieClip {
		public static var otherPlayerAr:Array = new Array();
		
		public static var oldTime=0;
		public static var splineco=3;
		
		public var pName:String = "";
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		public var xPos:Number = 0;
		public var yPos:Number = 0;
		public var oxSpeed:Number = 0;
		public var oySpeed:Number = 0;
		public var oxPos:Number = 0;
		public var oyPos:Number = 0;
		
		public function otherPlayer() {
			otherPlayerAr.push(this);
		}
		
		public static function setVarPinged(posAr:Array):void
		{
			oldTime = (new Date()).getTime();
			for(var i=posAr.length/4-1;i>=0;i--){
				otherPlayerAr[posAr.length/4-1-i].oxPos=otherPlayerAr[posAr.length/4-1-i].xPos;
				otherPlayerAr[posAr.length/4-1-i].oyPos=otherPlayerAr[posAr.length/4-1-i].yPos;
				otherPlayerAr[posAr.length/4-1-i].oxSpeed=otherPlayerAr[posAr.length/4-1-i].xSpeed;
				otherPlayerAr[posAr.length/4-1-i].oySpeed=otherPlayerAr[posAr.length/4-1-i].ySpeed;
				otherPlayerAr[posAr.length/4-1-i].xPos=posAr[i*4];
				otherPlayerAr[posAr.length/4-1-i].yPos=posAr[i*4+1];
				otherPlayerAr[posAr.length/4-1-i].xSpeed=posAr[i*4+2];
				otherPlayerAr[posAr.length/4-1-i].ySpeed=posAr[i*4+3];
				trace(otherPlayerAr[posAr.length/4-1-i].xPos);
				trace(otherPlayerAr[posAr.length/4-1-i].oxPos);
				
			}
			player.timerTick();
		}
		
		public static function movePlayer(event:Event):void
		{
			var newTime:Number = (new Date()).getTime();
			var splineTime=(newTime-oldTime)/200;
			if(splineTime>1){
				splineTime=1
			}
			if(splineTime<0){
				splineTime=0
			}
			for(var i=0;i<otherPlayerAr.length;i++){
				
				var x1=otherPlayerAr[i].oxPos;
				var x2=otherPlayerAr[i].oxPos+otherPlayerAr[i].oxSpeed*splineco;
				var x3=otherPlayerAr[i].xPos-(otherPlayerAr[i].xSpeed*splineco);
				var x4=otherPlayerAr[i].xPos;
				var y1=otherPlayerAr[i].oyPos;
				var y2=otherPlayerAr[i].oyPos+otherPlayerAr[i].oySpeed*splineco;
				var y3=otherPlayerAr[i].yPos-(otherPlayerAr[i].ySpeed*splineco);
				var y4=otherPlayerAr[i].yPos;
				otherPlayerAr[i].x = splineTime*splineTime*splineTime * (x4 - 3*x3 + 3*x2 - x1) + splineTime*splineTime * (3*x3 - 6*x2 + 3*x1) + splineTime * (3*x2 - 3*x1) + x1;
				otherPlayerAr[i].y = splineTime*splineTime*splineTime * (y4 - 3*y3 + 3*y2 - y1) + splineTime*splineTime * (3*y3 - 6*y2 + 3*y1) + splineTime * (3*y2 - 3*y1) + y1;						
			}
		}
		
	}
	
}
