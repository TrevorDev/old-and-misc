package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class zombie extends MovieClip
	{
		public static var maxZom = 7;
		public static var zombieMC:zombie;
		public static var sWeb:web;
		public static var ar:Array = new Array();
		public static var give = 20;
		public static var swapGive = 10;
		public static var repelForce = 0.5;

		public var health = 100;
		public var spd = 2;
		public var val = 10;
		public var breakSpd = 1;

		public var blockerSpawn:Array = new Array();
		public var dir = 0;
		public var xSpd = 0;
		public var ySpd = 0;

		public var wallHit = false;
		public var roomIn = 0;
		public var realTarget = guy.ar[0];
		public var target = guy.ar[0];
		public var oldRot = 0;
		public var spawnChoice;
		public var out = true;
		public var pastBlock = false;

		public function zombie()
		{
			if(!zombiecash.main.debug){
				zomBox.visible=false;
			}
			ar.push(this);
		}

		public static function zomRmv(item:MovieClip):void
		{
			zombie.ar.splice(zombie.ar.indexOf(item),1);
			item.parent.removeChild(item);
		}
		public static function zomLifeCheck(item:MovieClip):Boolean
		{
			var killed = false;
			if (item.health <= 0)
			{
				zombie.zomRmv(item);
				killed = true;
			}
			return killed;
		}
		public static function spawner(event:Event):void
		{
			if (zombie.ar.length < maxZom)
			{
				zombieMC = new zombie();
				guy.ar[0].parent.addChild(zombieMC);

				for (var i=0; i<room.ar[zombieMC.realTarget.roomIn].posibleWall.length; i++)
				{

					if (blocker.ar[room.ar[zombieMC.realTarget.roomIn].posibleWall[i]].activ)
					{
						zombieMC.blockerSpawn.push(room.ar[zombieMC.realTarget.roomIn].posibleWall[i]);
					}
				}

				zombieMC.target=blocker.ar[zombieMC.blockerSpawn[Math.floor(Math.random()*(zombieMC.blockerSpawn.length))]];
				zombieMC.roomIn = zombieMC.target.roomIn;
				zombieMC.spawnChoice = spawn.ar[zombieMC.target.spawnZone];
				zombieMC.x = zombieMC.spawnChoice.x;
				zombieMC.y = zombieMC.spawnChoice.y;
				for (var j=0; j<zombie.ar.length; j++)
				{
					if (j != zombie.ar.indexOf(zombieMC))
					{
						if (zombieMC.hitTestObject(zombie.ar[j]))
						{
							zomRmv(zombieMC);


							break;
						}
					}
				}
			}
		}
		public static function walker(event:Event):void
		{
			for (var i=0; i<zombie.ar.length; i++)
			{
var oldX=zombie.ar[i].x;
var oldY=zombie.ar[i].y;
				//reachTARGET/////////////////////////////////////////////////////////
				if (Math.abs(zombie.ar[i].x - zombie.ar[i].target.x) < swapGive && Math.abs(zombie.ar[i].y - zombie.ar[i].target.y) < swapGive)
				{
					if (door.ar.indexOf(zombie.ar[i].target) != -1)
					{
						if (zombie.ar[i].target.connect[0] == zombie.ar[i].roomIn)
						{
							zombie.ar[i].roomIn = zombie.ar[i].target.connect[1];
						}
						else
						{
							zombie.ar[i].roomIn = zombie.ar[i].target.connect[0];
						}
					}
					zombie.ar[i].out = false;
					zombie.ar[i].target = zombie.ar[i].realTarget;
					zombie.ar[i].pastBlock = true;
				}
				//check for same room/////////////////////////////////////////////////////////
				if (zombie.ar[i].pastBlock && zombie.ar[i].realTarget.roomIn == zombie.ar[i].roomIn)
				{
					zombie.ar[i].target = zombie.ar[i].realTarget;
					zombie.ar[i].out = false;
				}

				//SEARCHER/////////////////////////////////////////////////////////
				if (! zombie.ar[i].out && zombie.ar[i].roomIn != zombie.ar[i].realTarget.roomIn)
				{

					var locate = zombie.ar[i].roomIn;



					for (var e=0; e<door.ar.length; e++)
					{

						if (!door.ar[e].visible&&(door.ar[e].connect[0] == locate || door.ar[e].connect[1] == locate))
						{
							sWeb = new web();

							sWeb.doorNum = e;

							if (door.ar[e].connect[0] == locate)
							{
								sWeb.rooms.push(door.ar[e].connect[1]);
							}
							else
							{
								sWeb.rooms.push(door.ar[e].connect[0]);
							}
							web.ar.push(sWeb);
						}
					}
					var loops = 0;
					zombie.ar[i].out = false;//make sure
					while (!zombie.ar[i].out)
					{
						for (var g=0; g<web.ar.length; g++)
						{
							if (loops > 0)
							{
								var len = web.ar[g].rooms.length;
								for (var f=0; f<len; f++)
								{
									for (var d=0; d<door.ar.length; d++)
									{
										if (! door.ar[d].visible)
										{
											if (web.ar[g].rooms[f] == door.ar[d].connect[0])
											{
												web.ar[g].rooms.push(door.ar[d].connect[1]);
											}
											else if (web.ar[g].rooms[f]==door.ar[d].connect[1])
											{
												web.ar[g].rooms.push(door.ar[d].connect[0]);
											}
										}
									}
								}
							}

							for (var t=0; t<web.ar[g].rooms.length; t++)
							{
								if (web.ar[g].rooms[t] == zombie.ar[i].realTarget.roomIn)
								{


									zombie.ar[i].target = door.ar[web.ar[g].doorNum];
									zombie.ar[i].out = true;
									web.ar.splice(0,web.ar.length);

									break;
								}
							}
						}
						loops++;
					}



				}



				/////////ZOMBIE COLIDE WALL IN WALL MODE///////////////////////////////////////////////////////////
				if (zombie.ar[i].wallHit)
				{
					var wallCheck = false;
					var oldDir = zombie.ar[i].dir;
					for (j=0; j<wall.ar.length; j++)
					{

						if (zombie.ar[i].zomBox.up.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.down.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.left.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.right.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.cbl.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.cbr.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.cul.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.cur.hitTestObject(wall.ar[j]))
						{
							wallCheck = true;
							if (zombie.ar[i].zomBox.up.hitTestObject(wall.ar[j]))
							{
								if (zombie.ar[i].y - zombie.ar[i].target.y < give)
								{
									wallCheck = false;
									zombie.ar[i].dir = 3;
								}
							}
							if (zombie.ar[i].zomBox.down.hitTestObject(wall.ar[j]))
							{
								if (zombie.ar[i].y - zombie.ar[i].target.y >  -  give)
								{
									wallCheck = false;
									zombie.ar[i].dir = 1;
								}
							}
							if (zombie.ar[i].zomBox.left.hitTestObject(wall.ar[j]))
							{
								if (zombie.ar[i].x - zombie.ar[i].target.x < give)
								{
									wallCheck = false;
									zombie.ar[i].dir = 2;
								}
							}
							if (zombie.ar[i].zomBox.right.hitTestObject(wall.ar[j]))
							{
								if (zombie.ar[i].x - zombie.ar[i].target.x >  -  give)
								{
									wallCheck = false;
									zombie.ar[i].dir = 4;
								}
							}
							break;
						}
					}
					if (! wallCheck)
					{
						zombie.ar[i].wallHit = false;

					}
				}
				else
				{


					/////////CHeck for new direction///////////////////////////////////////////////////////////
					if (zombie.ar[i].dir == 1)
					{
						if (zombie.ar[i].y - zombie.ar[i].target.y < 0)
						{
							zombie.ar[i].dir = 0;
						}
					}
					else if (zombie.ar[i].dir==2)
					{
						if (zombie.ar[i].x - zombie.ar[i].target.x > 0)
						{
							zombie.ar[i].dir = 0;
						}
					}
					else if (zombie.ar[i].dir==3)
					{
						if (zombie.ar[i].y - zombie.ar[i].target.y > 0)
						{
							zombie.ar[i].dir = 0;
						}
					}
					else if (zombie.ar[i].dir==4)
					{
						if (zombie.ar[i].x - zombie.ar[i].target.x < 0)
						{
							zombie.ar[i].dir = 0;
						}
					}


					/////////Set Direction no colision///////////////////////////////////////////////////////////
					if (zombie.ar[i].dir == 0)
					{

						if (Math.abs(zombie.ar[i].x - zombie.ar[i].target.x) > Math.abs(zombie.ar[i].y - zombie.ar[i].target.y))
						{
							if (zombie.ar[i].x - zombie.ar[i].target.x > 0)
							{
								zombie.ar[i].dir = 4;
							}
							else
							{
								zombie.ar[i].dir = 2;
							}
						}
						else
						{
							if (zombie.ar[i].y - zombie.ar[i].target.y > 0)
							{
								zombie.ar[i].dir = 1;
							}
							else
							{
								zombie.ar[i].dir = 3;
							}
						}
					}


					/////////ZOMBIE COLIDE WALL INISIAL///////////////////////////////////////////////////////////

					for (var j=0; j<wall.ar.length; j++)
					{
						if (zombie.ar[i].zomBox.up.hitTestObject(wall.ar[j]) || zombie.ar[i].zomBox.down.hitTestObject(wall.ar[j]))
						{
							zombie.ar[i].wallHit = true;

							if (zombie.ar[i].x - zombie.ar[i].target.x > 0)
							{

								zombie.ar[i].dir = 4;
							}
							else
							{
								zombie.ar[i].dir = 2;
							}


						}
						else if (zombie.ar[i].zomBox.right.hitTestObject(wall.ar[j])||zombie.ar[i].zomBox.left.hitTestObject(wall.ar[j]))
						{
							zombie.ar[i].wallHit = true;

							if (zombie.ar[i].y - zombie.ar[i].target.y > 0)
							{
								zombie.ar[i].dir = 1;
							}
							else
							{
								zombie.ar[i].dir = 3;
							}


						}
					}



				}
				/////////Set DIrection///////////////////////////////////////////////////////////
				zombie.ar[i].oldRot = zombie.ar[i].rotation;
				if (zombie.ar[i].dir == 1)
				{
					zombie.ar[i].ySpd =  -  zombie.ar[i].spd;
					zombie.ar[i].xSpd = 0;
					zombie.ar[i].rotation = 0;

				}
				else if (zombie.ar[i].dir==2)
				{
					zombie.ar[i].xSpd = zombie.ar[i].spd;
					zombie.ar[i].ySpd = 0;
					zombie.ar[i].rotation = 90;

				}
				else if (zombie.ar[i].dir==3)
				{
					zombie.ar[i].ySpd = zombie.ar[i].spd;
					zombie.ar[i].xSpd = 0;
					zombie.ar[i].rotation = 180;

				}
				else if (zombie.ar[i].dir==4)
				{
					zombie.ar[i].xSpd =  -  zombie.ar[i].spd;
					zombie.ar[i].ySpd = 0;
					zombie.ar[i].rotation = 270;

				}

				zombie.ar[i].zomBox.rotation =  -  zombie.ar[i].rotation;
				if (! zombie.ar[i].zomBox.hitTestObject(zombie.ar[i].realTarget.hitBox))
				{
					zombie.ar[i].x +=  zombie.ar[i].xSpd;
					zombie.ar[i].y +=  zombie.ar[i].ySpd;
				}
				else
				{
					zombie.ar[i].rotation = zombie.ar[i].oldRot;
					zombie.ar[i].zomBox.rotation =  -  zombie.ar[i].rotation;
				}
				/////////ZOMBIE COLIDE ZOMBIE///////////////////////////////////////////////////////////
				for (var c=0; c<zombie.ar.length; c++)
				{
					if (c != i)
					{

						var hitCount = 0;

						if (zombie.ar[i].zomBox.hitTestObject(zombie.ar[c].zomBox))
						{
							hitCount++;
							if (zombie.ar[i].dir == zombie.ar[c].dir || zombie.ar[i].dir == zombie.ar[c].dir + 2 || zombie.ar[i].dir || zombie.ar[c].dir - 2)
							{
								zombie.ar[i].xSpd = 0;
								zombie.ar[i].ySpd = 0;
								if (zombie.ar[i].dir == 1 || zombie.ar[i].dir == 3)
								{
									if (zombie.ar[i].x > zombie.ar[c].x)
									{
										zombie.ar[i].xSpd = repelForce;
									}
									else
									{
										zombie.ar[i].xSpd =  -  repelForce;
									}
								}
								else
								{
									if (zombie.ar[i].y > zombie.ar[c].y)
									{
										zombie.ar[i].ySpd = repelForce;
									}
									else
									{
										zombie.ar[i].ySpd =  -  repelForce;
									}
								}
								var wallc = false;
								for (var k=0; k<wall.ar.length; k++)
								{
									if (zombie.ar[i].zomBox.hitTestObject(wall.ar[k]))
									{
										wallc = true;
										break;
									}
								}
								if (! wallc)
								{
									zombie.ar[i].x +=  zombie.ar[i].xSpd;
									zombie.ar[i].y +=  zombie.ar[i].ySpd;
								}
							}



						}

					}

				}
				for (var h=0; h<blocker.ar.length; h++)
				{
					if (zombie.ar[i].zomBox.hitTestObject(blocker.ar[h]) && blocker.ar[h].str > 0)
					{
						zombie.ar[i].x=oldX;
						zombie.ar[i].y=oldY;
						blocker.ar[h].str -=  zombie.ar[i].breakSpd;
						if (blocker.ar[h].str < 0)
						{
							blocker.ar[h].str = 0;
						}
						
					}
				}
			}
		}
	}

}