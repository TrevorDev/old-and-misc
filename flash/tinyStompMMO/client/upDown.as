package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class upDown extends MovieClip {
		public static var upDowns:Array = new Array();
		static var fric:Number = 2;
		var max:Number = 300;
		var pos:Number = 0;
		var down:Boolean = true;
		var speed:Number = 5;
		var fall:Number = 1;
		var sep:Number = 100;
		static var i:Number =0;
		public function upDown() {
			i=upDowns.push(this);
			this.y+=i*sep;
			pos+=i*sep;
			addEventListener(Event.ENTER_FRAME, makeWall, false, -10, true);
			addEventListener(Event.ENTER_FRAME, mover, false, 0, true);
		}
		function mover(event:Event):void
		{
			
			if(down){
				if(pos<max){
					speed+=fall;
					this.y+=speed;
					pos+=speed;
				}else{
					down=false;
					speed=5;
				}
			}else{
				if(pos>0){
					this.y-=speed;
					
					pos-=speed;
				}else{
					down=true;
					speed=0;
				}
			}
		}
		function makeWall(event:Event):void
		{
			for (var i:Number=0; i<guy.players.length; i++)
			{
				if (this.hitTestObject(guy.players[i].down))
				{
					if (Math.abs(guy.players[i].xSpeed) <= fric && Math.abs(guy.players[i].xSpeed) != 0 && ! landworld(root).right && ! landworld(root).left)
					{
						guy.players[i].xSpeed = 0;
					}
					if (guy.players[i].xSpeed > 0 && ! landworld(root).right)
					{
						guy.players[i].xSpeed +=   -  fric;
					}
					else if (guy.players[i].xSpeed<0&&!landworld(root).left)
					{
						guy.players[i].xSpeed +=  fric;
					}

				}



				while (this.hitTestObject(guy.players[i].down))
				{
					guy.players[i].ySpeed = 0;
					guy.players[i].jumpState = 0;
					guy.players[i].y--;
				}

				while (this.hitTestObject(guy.players[i].up))
				{
					guy.players[i].ySpeed = 0;

					guy.players[i].y++;
				}

				while (this.hitTestObject(guy.players[i].right))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x--;
				}

				while (this.hitTestObject(guy.players[i].left))
				{
					guy.players[i].xSpeed = 0;

					guy.players[i].x++;
				}


			}



		}
	}
	
}
