package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;

	public class bad1 extends MovieClip
	{
		public static var badGuys:Array = new Array();
		public static var num:Number = -1;
		public static var expVal:Number = 10;
		public var distance = 200;
		var initX;
		public var health = 10;
		public var speed = 1;
		public var link:Number = 0;
		
		private var _width:Number = 0;
		private var _height:Number = 0; 
		
		// move every 50ms
		var timer:Timer = new Timer(50,0);
		
		// false is left, true is right
		
		public var direction:Boolean = false;
		public function bad1()
		{
			initX = this.x;
			this.stop();
			num++;
			link = num;
			badGuys[num] = this;
			this.addEventListener(Event.ENTER_FRAME, hit, false, -10, true);
			timer.addEventListener(TimerEvent.TIMER, timerTick, false, 0, true);
			timer.start();
			if(!this.direction){
			this.scaleX=-1;
			}else{
				this.scaleX=1;
			}
		}
		
		
		function timerTick(e:TimerEvent):void
		{
			//moving right
			if(this.direction)
			{
				if(this.x < initX+(distance/2))
					this.x += speed;
			}
			//moving left
			else
			{
				if(this.x > initX-(distance/2))
					this.x -= speed;
			}
		}
		
		function hit(event:Event):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (this.health>0&&this.hitTestObject(guy.players[i].footBox) && guy.players[i].ySpeed > 0 && this.currentFrame == 1)
				{
					this.health-=guy.players[0].stompDmg;
					serverHandler.serverHand.connection.send("fhit",serverHandler.serverHand.myId,this.link);
					if(this.health<=0){
					guy.players[i].expNum += expVal;
					guy.players[i].checkExp();
					this.play();
					trace("link " + link);
					}
					guy.players[i].ySpeed = -10;
				}else if(this.health>0&&guy.players[i].sprite.weapon.hit1.currentFrame==5&&this.hitTestObject(guy.players[i].sprite.weapon.hit1.wepHitbox)){
					this.health-=guy.players[0].wepDmg;
					serverHandler.serverHand.connection.send("whit",serverHandler.serverHand.myId,this.link);
					if(this.health<=0){
					guy.players[i].expNum += expVal;
					guy.players[i].checkExp();
					this.play();
					trace("link " + link);
					}
				}else if(this.health>0&&this.hitTestObject(guy.players[i].leftHit)&&!guy.players[i].god&&guy.players[i].ySpeed>=-2){
				guy.players[i].god=true;
				guy.players[i].ySpeed=-6;
				guy.players[i].xSpeed=8;
				guy.players[i].healthNum-=1;
				guy.players[i].diedCheck(null);
				healthbox.hBox.checkHeart();
				}else if(this.health>0&&this.hitTestObject(guy.players[i].rightHit)&&!guy.players[i].god&&guy.players[i].ySpeed>=-2){
				guy.players[i].god=true;
				guy.players[i].ySpeed=-6;
				guy.players[i].xSpeed=-8;
				guy.players[i].healthNum-=1;
				guy.players[i].diedCheck(null);
				healthbox.hBox.checkHeart();
				}
			}
			
			if (this.currentFrame == this.totalFrames)
			{
				trace("linktt " + link);
				this.removeEventListener(Event.ENTER_FRAME, hit);
				parent.removeChild(this);
			}


		}
		
	public function setSize(w:Number, h:Number):void {
			_width = w;
			_height = h;
		} 


	}

}