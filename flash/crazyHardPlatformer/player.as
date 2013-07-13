package  {
	
	import flash.display.MovieClip;
		import flash.events.*;
	import flash.events.Event;
	
	public class player extends MovieClip {
		public static var p1;
		
		public var camGiveX:Number = 25;
		public var camY:Number = 1;
		
		var fric = 1;
		
		public var tailLen:Number = 5;
		public var tail = new Array();
		public var projectiles = new Array();
		
		public var reviveX = 0;
		public var reviveY = 0;
		
		public var speed:Number;
		public var powerDownX = 20;
		public var powerDownY = 15;
		public var maxSpeed:Number = 8;
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		public var xAccel:Number = 0.5;
		public var yAccel:Number = 0;
		
		public var grav:Number = 1;
		public var jumpStr:Number = 12;
		public var jumpState:Number = 0;
		
		public var radius:Number = 16;
		
		public var canMove:Boolean = true;
		public var canMoves:Boolean = true;
		public var dead:Number = 0;
		public var invincible:Number = 0;
		public var health:Number = 2;
		public var maxHealth:Number = 2;
		
		
		
		public var wid;
		
		var attacked = false;
		public function player() {
			player.p1=this;
			this.sprite.head.gotoAndStop(1);
			wid =this.width;
			this.hitBox.visible=false;
			for(var i = 0;i<tailLen;i++){
				addTail();
			}
			addEventListener(Event.ENTER_FRAME, movePlayer, false, 0, true);
			addEventListener(Event.ENTER_FRAME, attacking, false, 0, true);
			addEventListener(Event.ENTER_FRAME, projectile, false, 0, true);
			addEventListener(Event.ENTER_FRAME, misc, false, -200, true);
			addEventListener(Event.ENTER_FRAME, badGuyRun, false, 0, true);
			addEventListener(Event.ENTER_FRAME, makeDeath, false, -100, true);
			addEventListener(Event.ENTER_FRAME, makeAmmo, false, -100, true);
			addEventListener(Event.ENTER_FRAME, cams, false, 0, true);
			addEventListener(Event.ENTER_FRAME, backroundMove, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkpointSet, false, 0, true);
			addEventListener(Event.ENTER_FRAME, finishCheck, false, 0, true);
		}
		
		function remove(){
			removeEventListener(Event.ENTER_FRAME, movePlayer, false);
			removeEventListener(Event.ENTER_FRAME, attacking, false);
			removeEventListener(Event.ENTER_FRAME, projectile, false);
			removeEventListener(Event.ENTER_FRAME, misc, false);
			removeEventListener(Event.ENTER_FRAME, badGuyRun, false);
			removeEventListener(Event.ENTER_FRAME, makeDeath, false);
			removeEventListener(Event.ENTER_FRAME, makeAmmo, false);
			removeEventListener(Event.ENTER_FRAME, cams, false);
			removeEventListener(Event.ENTER_FRAME, backroundMove, false);
			removeEventListener(Event.ENTER_FRAME, checkpointSet, false);
			removeEventListener(Event.ENTER_FRAME, finishCheck, false);
			death.ar=new Array();
			ammo.ar=new Array();
			badGuy.ar=new Array();
			checkpoint.ar=new Array();
			backround.ar=new Array();
			wall.ar=new Array();
			death.ar=new Array();
			finish.ar=new Array();
			cameraSwitch.ar=new Array();
		}
		
		function addTail(){
			var tailNode = new playerTail();
				tailNode.x = getTailX();
				tailNode.y = getTailY();
				tail.push(tailNode);
				parent.addChild(tailNode);
		}
		
		function removeProjectile(i){
				parent.removeChild(projectiles[i]);
				projectiles.splice(i, 1);
		}
		
		function getTailX(){
			return this.x+(this.sprite.scaleX*this.wid/-2);
		}
		function getTailY(){
			return this.y-5;
		}
		function projectile(event:Event):void
		{
			
			for (var i =0;i<this.projectiles.length;i++){
				projectiles[i].x+=projectiles[i].xSpd;
				projectiles[i].y+=projectiles[i].ySpd;
				projectiles[i].ySpd+=grav;
			}
			for (var j =0; j<wall.ar.length; j++){
				for (i =this.projectiles.length-1;i>=0;i--){
					if (projectiles[i].hitTestObject(wall.ar[j]))
					{
						removeProjectile(i);
					}
				}
			}
		}
		
		function finishCheck(event:Event):void
		{
			for(var i = finish.ar.length-1;i>=0;i--){
				if(this.hitBox.hitTestObject(finish.ar[i])){
					arcade.main.changeLevel(finish.ar[i].levelNum);
				}
			}
		}
		
		function checkpointSet(event:Event):void
		{
			for(var i = checkpoint.ar.length-1;i>=0;i--){
				if(this.hitBox.hitTestObject(checkpoint.ar[i])){
					this.reviveX=checkpoint.ar[i].x;
					this.reviveY=checkpoint.ar[i].y;
					
				}
			}
		}
		function badGuyRun(event:Event):void
		{
			for(var i = badGuy.ar.length-1;i>=0;i--){
				if(badGuy.ar[i].activeBad){
					if(badGuy.ar[i].hit.hitTestObject(this.hitBox)){
						this.getHit();
					}
				}
				
				var killed = false;
				for (var j =this.projectiles.length-1;j>=0;j--){
					if (projectiles[j].hitTestObject(badGuy.ar[i]))
					{
						removeProjectile(j);
						if(badGuy.ar[i].getHit()){
							killed=true;
							break;
						}
					}
				}
				if(!killed){
				badGuy.ar[i].run();
				}
			}
		}
		function attacking(event:Event):void
		{
			
			if(input.attack){
				if(!attacked){
					this.sprite.hand.gotoAndStop(2);
					this.projectiles.push(this.tail.splice(0, 1)[0])
					this.projectiles[this.projectiles.length-1].y-=this.height/2;
					this.projectiles[this.projectiles.length-1].x=getTailX();
					this.projectiles[this.projectiles.length-1].xSpd=this.projectiles[this.projectiles.length-1].xSpd*this.sprite.scaleX+this.xSpeed;
					this.projectiles[this.projectiles.length-1].visible=true;
				attacked=true;
				}
			}
			if(this.sprite.hand.currentFrame==2){
				if (this.sprite.hand.clip.currentFrame==this.sprite.hand.clip.totalFrames){
					if(this.tail.length>0){
					this.sprite.hand.gotoAndStop(1);
					}
				}
			}else if(this.sprite.hand.currentFrame==1){
				if (this.sprite.hand.clip.currentFrame==this.sprite.hand.clip.totalFrames){
					attacked=false;
				}else if(this.sprite.hand.clip.currentFrame==7){
					if(this.tail.length>0){
						this.tail[0].visible=false;
					}
				}
			}
		}
		function backroundMove(event:Event):void
		{
			for(var i = 0;i<backround.ar.length;i++){
				backround.ar[i].follow();
			}
		}
		function cams(event:Event):void
		{
			while (275 - this.x-this.xSpeed-root.x<-camGiveX)
			{
				root.x--;
			}
			while (275 - this.x-this.xSpeed-root.x>camGiveX)
			{
				root.x++;
			}

			if (camY == 1)
			{
				if ( -  this.y + stage.stageHeight / 2 - root.y > 10 ||  -  this.y + stage.stageHeight / 2 - root.y < 10)
				{

					root.y+=(-this.y+stage.stageHeight/2-root.y)/10;

				}
			}
			else
			{
				if ( -  camY - root.y > 10 ||  -  camY - root.y < 10)
				{

					root.y+=(-camY-root.y)/10;

				}
			}
			
			for(var i=0;i<cameraSwitch.ar.length;i++){
				if(this.hitBox.hitTestObject(cameraSwitch.ar[i])){
					this.camY=cameraSwitch.ar[i].yVal;
				}
			}



		}
		
		function misc(event:Event):void
		{
			if(invincible){
				
				this.sprite.alpha=0.5;
				invincible++;
				if(invincible>=50){
					invincible=0;
				}
			}else{
				this.sprite.alpha=1;
			}
			
			if(dead){
				dead++;
				if(dead>=50){
					revive();
				}
			}
		}
		
		function getHit(){
			if(!invincible&&!dead){
				health--;
				this.sprite.head.gotoAndStop(2);
				this.ySpeed=-10;
				invincible=1;
				if(health<=0){
					kill();
				}
			}
		}
		
		function kill(){
			invincible=0;
			dead=1;
			canMoves=false;
			this.sprite.head.gotoAndStop(3);
			
		}
		
		function revive(){
			health=maxHealth;
			dead=0;
			canMoves=true;
			this.sprite.head.gotoAndStop(1);
			this.x=reviveX;
			this.y=reviveY;
			arcade.main.startGame();
		}
		function makeDeath(event:Event):void
		{
			for (var i =0; i<death.ar.length; i++)
			{
				if (death.ar[i].hitTestObject(this.hitBox)){
					getHit();
				}
			}
		}
		
		function makeAmmo(event:Event):void
		{
			for (var i =0; i<ammo.ar.length; i++)
			{
				if (ammo.ar[i].hitTestObject(this.hitBox))
				{
					while(this.tail.length<5){
						addTail();
					}
				}
			}
		}
		
		function makeWall():void
		{
			for (var i =0; i<wall.ar.length; i++)
			{
				if (wall.ar[i].hitTestObject(this.hitBox.down))
				{
					if (Math.abs(this.xSpeed) <= fric && Math.abs(this.xSpeed) != 0 && ! input.right && ! input.left)
					{
						this.xSpeed = 0;
					}
					if (this.xSpeed>this.maxSpeed||(this.xSpeed > 0 && ! input.right))
					{
						this.xSpeed +=   -  fric;
					}
					else if (this.xSpeed<-this.maxSpeed||(this.xSpeed<0&&!input.left))
					{
						this.xSpeed +=  fric;
					}

				}



				while (wall.ar[i].hitTestObject(this.hitBox.down))
				{
					if(this.ySpeed>0){
						this.ySpeed = 0;
					}
					this.jumpState = 0;
					this.y--;
				}

				while (wall.ar[i].hitTestObject(this.hitBox.up))
				{
					if(this.ySpeed<0){
						this.ySpeed = 0;
					}

					this.y++;
				}

				while (wall.ar[i].hitTestObject(this.hitBox.right))
				{
					if(this.xSpeed>0){
						this.xSpeed = 0;
					}
					this.x--;
				}

				while (wall.ar[i].hitTestObject(this.hitBox.left))
				{
					if(this.xSpeed<0){
						this.xSpeed = 0;
					}
					

					this.x++;
				}

			}

		}
		
		function gravity():void
		{
			if (canMoves)
			{
				ySpeed +=  grav;
			}
		}
		
		function moveFeet(){
			if(this.sprite.feet.currentFrame==this.sprite.feet.totalFrames-1){
				this.sprite.feet.gotoAndStop(0);
			}
			this.sprite.feet.gotoAndStop(this.sprite.feet.currentFrame+1);
		}
		
		function movePlayer(event:Event):void
		{
			
			if(tail.length>0){
			for (var i = 0;i<tail.length-1;i++){
				tail[i].x=tail[i+1].x;
				tail[i].y=tail[i+1].y;
				
			}
			tail[tail.length-1].x=getTailX();
			tail[tail.length-1].y=getTailY();
			}
			if (canMoves)
			{
				if (Math.abs(this.xSpeed) <= fric && Math.abs(this.xSpeed) != 0 && ! input.right && ! input.left)
				{

				}
				if (this.xSpeed > 0 && ! input.right && input.left)
				{
					this.xSpeed +=   -  fric;
				}
				else if (this.xSpeed<0&&!input.left&&input.right)
				{
					this.xSpeed +=  fric;
				}

				if (input.left)
				{
					moveFeet();
					if (xSpeed - xAccel >=  -  maxSpeed)
					{
						xSpeed -=  xAccel;
					}
					this.sprite.scaleX = -1;
					/*if (this.sprite.currentFrame == 1)
					{
						if (this.sprite.walking.currentFrame + Math.abs(xSpeed) > this.sprite.walking.totalFrames)
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2)-this.sprite.walking.totalFrames);
						}
						else
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2));
						}
					}*/
				}
				if (input.right)
				{
					moveFeet();
					if (xSpeed + xAccel <= maxSpeed)
					{
						xSpeed +=  xAccel;
					}
					this.sprite.scaleX = 1;
					/*if (this.sprite.currentFrame == 1)
					{
						if (this.sprite.walking.currentFrame + Math.abs(xSpeed) > this.sprite.walking.totalFrames)
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2)-this.sprite.walking.totalFrames);
						}
						else
						{
							this.sprite.walking.gotoAndStop(this.sprite.walking.currentFrame+Math.floor(Math.abs(xSpeed)/2));
						}
					}*/
				}

				if (input.up&&(jumpState==0||jumpState==2))
				{
					if (jumpState == 0)
					{
						jumpStr = Math.floor(13 + Math.abs(xSpeed) * 0.3);
					}
					ySpeed =  -  jumpStr;
					jumpState++;
				}
				else if (jumpState==1&&!input.up)
				{
					jumpState++;
				}
				if (jumpState >= 1)
				{
					/*guySprite.lookPlayer = thisRef;
					this.sprite.gotoAndStop(2);*/
				}
				else if (this.sprite.currentFrame==2)
				{
					/*guySprite.lookPlayer = thisRef;
					this.sprite.gotoAndStop(1);*/
				}
				if (input.down)
				{
					input.down=false;
					this.ySpeed = powerDownX;
					this.xSpeed=powerDownY*this.sprite.scaleX;
				}
				var hx = Math.ceil(xSpeed)/2;
				var hy = ySpeed/2;
				
				var oldy = this.y;
				this.x +=  hx;
				this.y +=  hy;
				gravity();
				makeWall();
				this.x +=  hx;
				this.y +=  hy;
				makeWall();
				if(jumpState!=0){
					this.sprite.feet.gotoAndStop(this.sprite.feet.totalFrames);
				}else{
					if(this.sprite.feet.currentFrame==this.sprite.feet.totalFrames){
						this.sprite.feet.gotoAndStop(0);
					}
				}
				/*if (Math.abs(xSpeed) >= maxSpeed)
				{
					this.sprite.dash.visible = true;
				}
				else
				{
					this.sprite.dash.visible = false;

				}*/
			}
		}
		
	}
	
}
