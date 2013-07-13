package 
{

	import flash.display.MovieClip;
	import flash.events.Event;

	public class mouse extends MovieClip
	{
		var goPosY = 0;
		var goPosX = 0;
		var posX = 0;
		var posY = 0;
		var nextPosX = 0;
		var nextPosY = 0;
		var nextPosGridX = 0;
		var nextPosGridY = 0;
		var secondStepPosX = 0;
		var secondStepPosY = 0;
		var secondMove = false;
		var moveX = false;
		var moveY = false;
		var moveSpot = false;
		var moving = false;
		var frame = 0;
		var frameMax = 20;
		var moveDist = 0;
		var moveList:Array;
		var moveListPos = 0;
		var hasCheese = false;
		var leavePosX=0;
		var leavePosY=0;
		static var spawnFrame = 0;
		static var maxSpawnFrame = 200;
		static var ar:Array=new Array();
		public function mouse()
		{
			ar.push(this);
			var genRand = Math.random();
			if(genRand<0.25){
				leavePosX=Math.floor(Math.random()*playingScreen.xDim);
				leavePosY=-1;
			}else if(genRand<0.5){
				leavePosX=Math.floor(Math.random()*playingScreen.xDim);;
				leavePosY=6;
			}else if(genRand<0.75){
				leavePosX=12;
				leavePosY=Math.floor(Math.random()*playingScreen.yDim);
			}else {
				leavePosX=-1;
				leavePosY=Math.floor(Math.random()*playingScreen.yDim);
			}
			this.x = playingScreen.xGrid(leavePosX);
			this.y = playingScreen.yGrid(leavePosY);
			this.posX = leavePosX;
			this.posY = leavePosY;
			var ch = cheese.ch;
			var goX = ch.posX;
			var goY = ch.posY;
			this.goPosX = goX;
			this.goPosY = goY;
			playingScreen.screen.mouseL.addChild(this);
			moveList = new Array();
			this.stop();
			moving=true;
			this.addEventListener(Event.ENTER_FRAME, doMouseStuff);
		}

		static public function reload()
		{
			ar = new Array();
			spawnFrame=0;
			maxSpawnFrame=200;
		}

		public static function spawner(event:Event)
		{
			if(spawnFrame==0){
				new mouse();
				trace("spawned");
			}else if(spawnFrame>=maxSpawnFrame){
				
				new mouse();
				trace("spawned");
				spawnFrame = 1;
				if(maxSpawnFrame>50){
					maxSpawnFrame-=10;
				}
			}
			spawnFrame++;
			trace(spawnFrame);
			
			
			if(cheese.ch.gameEnd){
				cheese.ch.endFrame++;
				//trace(endFrame);
				if(cheese.ch.endFrame>=cheese.ch.maxFrame){
					catGame.main.showStartScreen();
				}
			}
			
		}
		public function doMouseStuff(event:Event)
		{

			if(playingScreen.getArValGen(playingScreen.grid,posX,posY)==3||
			   playingScreen.getArValGen(playingScreen.grid,posX+1,posY)==3||
			   playingScreen.getArValGen(playingScreen.grid,posX,posY-1)==3||
			   playingScreen.getArValGen(playingScreen.grid,posX-1,posY)==3||
			   playingScreen.getArValGen(playingScreen.grid,posX,posY+1)==3){
				if(!hasCheese){
				//trace("got");
				cheese.ch.loseLife();
				}
				hasCheese=true;
				
				goPosX=leavePosX;
				goPosY=leavePosY;
			}else{
				/*trace("pos");
				trace(posX);
				trace(posY);
				trace("go");
				trace(goPosX);
				trace(goPosY);
				trace("val");*/
				//trace(playingScreen.getArValGen(playingScreen.grid,goPosX,goPosY))
			}
			
			if (moveSpot)
			{
				var spriteOff;
				if(hasCheese){
					spriteOff=2;
				}else{
					spriteOff=0;
				}
				if (moveX)
				{
					this.x +=  moveDist;
					if (moveDist>0)
					{
						if (this.currentFrame <= 0+spriteOff || this.currentFrame > 2+spriteOff)
						{
							this.gotoAndStop(1+spriteOff);
						}
						this.nextFrame();
					}
					else
					{
						if (this.currentFrame <= 4+spriteOff || this.currentFrame > 6+spriteOff)
						{
							this.gotoAndStop(5+spriteOff);
						}
						this.nextFrame();
					}

				}
				else
				{
					this.y +=  moveDist;
					if (moveDist>0)
					{
						if (this.currentFrame <= 8+spriteOff || this.currentFrame > 10+spriteOff)
						{
							this.gotoAndStop(9+spriteOff);
						}
						this.nextFrame();
					}
					else
					{
						if (this.currentFrame <= 12+spriteOff || this.currentFrame > 14+spriteOff)
						{
							this.gotoAndStop(13+spriteOff);
						}
						this.nextFrame();
					}
				}
				frame++;
				if (frame==frameMax)
				{
					this.posX = nextPosGridX;
					this.posY = nextPosGridY;
					frame = 0;
					moveSpot = false;
				}
			}
			else if (!secondMove)
			{
				this.gotoAndStop(1);
			}
			if (moving&&!moveSpot)
			{
				if (secondMove)
				{
					//trace(moveList[moveListPos]);
					if (moveList[moveListPos] == 1)
					{
						if (moveListPos==moveList.length-1)
						{
							nextPosGridX = posX;
						}
						else
						{
							nextPosGridX = posX + 1;
						}
						nextPosX = playingScreen.xGrid(nextPosGridX);
						moveDist = (nextPosX - this.x) / frameMax;
						moveSpot = true;
						moveX = true;
						moveY = false;
					}
					else if (moveList[moveListPos]==3)
					{
						if (moveListPos==moveList.length-1)
						{
							nextPosGridX = posX;
						}
						else
						{
							nextPosGridX = posX - 1;
						}
						nextPosX = playingScreen.xGrid(nextPosGridX);
						moveDist = (nextPosX - this.x) / frameMax;
						moveSpot = true;
						moveX = true;
						moveY = false;
					}
					else if (moveList[moveListPos]==4)
					{
						if (moveListPos==moveList.length-1)
						{
							nextPosGridX = posX;
						}
						else
						{
							nextPosGridY = posY + 1;
						}
						nextPosY = playingScreen.yGrid(nextPosGridY);
						moveDist = (nextPosY - this.y) / frameMax;
						moveSpot = true;
						moveY = true;
						moveX = false;
					}
					else if (moveList[moveListPos]==2)
					{
						if (moveListPos==moveList.length-1)
						{
							nextPosGridX = posX;
						}
						else
						{
							nextPosGridY = posY - 1;
						}
						nextPosY = playingScreen.yGrid(nextPosGridY);
						moveDist = (nextPosY - this.y) / frameMax;
						moveSpot = true;
						moveY = true;
						moveX = false;
					}
					else
					{
						secondMove = false;
					}
					moveListPos++;
					if (moveListPos>=moveList.length)
					{
						secondMove = false;
						//trace(moveX);
						//trace(moveY);
						moveListPos = 0;
						moveList = new Array();
						//trace("end");
					}
				}
				else
				{

					if (! moveX && ! moveY && posX == goPosX && posY == goPosY)
					{
						moving = false;
					}
					else
					{
						var difX2= Math.abs(goPosX-posX);
						var difY2= Math.abs(goPosY-posY);
						if (difX2>=difY2)
						{
							moveX = true;
						}
						else
						{
							moveY = true;
						}
					}

					if (moveX)
					{
						var difX = goPosX - posX;
						if (difX==0)
						{
							moveX = false;
						}
						else
						{
							nextPosGridX = posX + (difX / Math.abs(difX));
							nextPosGridY = posY;
							if (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY) != 0&&playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY) != 3)
							{
								moveX = false;
								moveY = false;
								var countPos = 1;
								var countNeg = 1;
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY+(countPos))!=0&&playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY+(countPos))!=3)
								{
									countPos++;
								}
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY-(countNeg))!=0&&playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY-(countNeg))!=3)
								{
									countNeg++;
								}

								secondStepPosX = goPosX;
								secondStepPosY = goPosY;

								var goToY1 = posY + countPos;
								var goToY2 = posY - countNeg;
								if (Math.abs(goToY1-goPosY)<=Math.abs(goToY2-goPosY))
								{
									for (var i =0; i<countPos; i++)
									{
										moveList.push(4);
										//trace("down");
									}
								}
								else
								{
									for (var i =0; i<countNeg; i++)
									{
										moveList.push(2);
										//trace("up");
									}
								}
								if (nextPosGridX<posX)
								{
									moveList.push(1);
								}
								else
								{
									moveList.push(3);
								}
								secondMove = true;
							}
							else
							{
								nextPosX = playingScreen.xGrid(nextPosGridX);
								moveDist = (nextPosX - this.x) / frameMax;
								moveSpot = true;
							}
						}
					}
					else if (moveY)
					{
						var difY = goPosY - posY;
						if (difY==0)
						{
							moveY = false;
						}
						else
						{
							nextPosGridY = posY + (difY / Math.abs(difY));
							nextPosGridX = posX;
							if (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY) != 0&&playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY) != 3)
							{
								moveX = false;
								moveY = false;
								var countPos = 1;
								var countNeg = 1;
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX+(countPos),nextPosGridY)!=0&&playingScreen.getArVal(playingScreen.grid,nextPosGridX+(countPos),nextPosGridY)!=3)
								{
									countPos++;
								}
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX-(countNeg),nextPosGridY)!=0&&playingScreen.getArVal(playingScreen.grid,nextPosGridX-(countNeg),nextPosGridY)!=3)
								{
									countNeg++;
								}

								secondStepPosX = goPosX;
								secondStepPosY = goPosY;

								var goToX1 = posX + countPos;
								var goToX2 = posX - countNeg;
								if (Math.abs(goToX1-goPosX)<=Math.abs(goToX2-goPosX))
								{
									for (var i =0; i<countPos; i++)
									{
										moveList.push(1);
										//trace("right");
									}
								}
								else
								{
									for (var i =0; i<countNeg; i++)
									{
										moveList.push(3);
										//trace("left");
									}
								}
								if (nextPosGridY<posY)
								{
									moveList.push(4);
								}
								else
								{
									moveList.push(2);
								}
								secondMove = true;
							}
							else
							{
								nextPosY = playingScreen.yGrid(nextPosGridY);
								moveDist = (nextPosY - this.y) / frameMax;
								moveSpot = true;
							}
						}
					}
				}
			}
		}

	}
}