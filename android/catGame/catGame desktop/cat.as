package 
{

	import flash.display.MovieClip;
	import flash.events.Event;

	public class cat extends MovieClip
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
		var frameMax = 10;
		var moveDist = 0;
		var moveList:Array;
		var moveListPos = 0;
		static var catThis;
		public function cat()
		{
			catThis = this;
			moveList = new Array();
			this.stop();
			addEventListener(Event.ENTER_FRAME, doCatStuff);
		}
		public function doCatStuff(event:Event)
		{
			for(var u = 0;u< mouse.ar.length;u++){
				if(Math.abs(this.x-mouse.ar[u].x)<playingScreen.blockWid/2&&Math.abs(this.y-mouse.ar[u].y)<playingScreen.blockHigh/2){
					mouse.ar[u].removeEventListener(Event.ENTER_FRAME, mouse.ar[u].doMouseStuff);
					playingScreen.screen.mouseL.removeChild(mouse.ar[u]);
					mouse.ar.splice(u,1);
					cheese.ch.scorer++;
					if(catGame.getVol() > 0) {
						catGame.hitSound.play();
					}
					playingScreen.screen.score.text = (cheese.ch.scorer+"");
				}
			}
			if (moveSpot)
			{
				if (moveX)
				{
					this.x +=  moveDist;
					if (moveDist>0)
					{
						if (this.currentFrame <= 1 || this.currentFrame > 3)
						{
							this.gotoAndStop(2);
						}
						this.nextFrame();
					}
					else
					{
						if (this.currentFrame <= 5 || this.currentFrame > 7)
						{
							this.gotoAndStop(6);
						}
						this.nextFrame();
					}

				}
				else
				{
					this.y +=  moveDist;
					if (moveDist>0)
					{
						if (this.currentFrame <= 11 || this.currentFrame > 13)
						{
							this.gotoAndStop(12);
						}
						this.nextFrame();
					}
					else
					{
						if (this.currentFrame <= 8 || this.currentFrame > 10)
						{
							this.gotoAndStop(9);
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
			else if(!secondMove)
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
							if (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY) != 0)
							{
								moveX = false;
								moveY = false;
								var countPos = 1;
								var countNeg = 1;
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY+(countPos))!=0)
								{
									countPos++;
								}
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY-(countNeg))!=0)
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
							if (playingScreen.getArVal(playingScreen.grid,nextPosGridX,nextPosGridY) != 0)
							{
								moveX = false;
								moveY = false;
								var countPos = 1;
								var countNeg = 1;
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX+(countPos),nextPosGridY)!=0)
								{
									countPos++;
								}
								while (playingScreen.getArVal(playingScreen.grid,nextPosGridX-(countNeg),nextPosGridY)!=0)
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