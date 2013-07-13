package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.geom.Point;

	public class guy extends MovieClip
	{
		public static var ar:Array = new Array();
		public var cash = 10000;
		public var spd = 5;
		public var health = 2;

		public var diSpd = 0;
		public var xSpd = 0;
		public var ySpd = 0;
		public var oldX = 0;
		public var oldY = 0;
		public var god = false;
		public var godTimer = 0;
		public var godTimerMax = 60;

		public var gunsAr:Array = new Array();
		public var gunOut = 0;
		

		
		
		public var shotTimer = 0;
		public var reloadTimer = 0;
		

		public var bullet:shot;
		public var aCheck = false;
		public var swapCheck = false;
		public var reloading = false;

		public var roomIn = 0;

		public function guy()
		{
			guy.ar.push(this);
			guns.loadGuns(this);
			guns.swapGuns(this, gunOut);
			
			diSpd = Math.sqrt(spd * spd / 2);
			oldX = this.x;
			oldY = this.y;
			if (! zombiecash.main.debug)
			{
				hitBox.visible = false;
			}

		}
		public static function movePlayer(event:Event):void
		{
			guy.ar[0].xSpd = 0;
			guy.ar[0].ySpd = 0;
			guy.ar[0].oldX = guy.ar[0].x;
			guy.ar[0].oldY = guy.ar[0].y;
			if (zombiecash.main.left && zombiecash.main.up)
			{
				guy.ar[0].xSpd =  -  guy.ar[0].diSpd;
				guy.ar[0].ySpd =  -  guy.ar[0].diSpd;
				guy.ar[0].rotation = 315;
			}
			else if (zombiecash.main.left&&zombiecash.main.down)
			{
				guy.ar[0].xSpd =  -  guy.ar[0].diSpd;
				guy.ar[0].ySpd = guy.ar[0].diSpd;
				guy.ar[0].rotation = 225;
			}
			else if (zombiecash.main.right&&zombiecash.main.up)
			{
				guy.ar[0].xSpd = guy.ar[0].diSpd;
				guy.ar[0].ySpd =  -  guy.ar[0].diSpd;
				guy.ar[0].rotation = 45;
			}
			else if (zombiecash.main.right&&zombiecash.main.down)
			{
				guy.ar[0].xSpd = guy.ar[0].diSpd;
				guy.ar[0].ySpd = guy.ar[0].diSpd;
				guy.ar[0].rotation = 135;
			}
			else if (zombiecash.main.up)
			{
				guy.ar[0].ySpd =  -  guy.ar[0].spd;
				guy.ar[0].xSpd = 0;
				guy.ar[0].rotation = 0;
			}
			else if (zombiecash.main.down)
			{
				guy.ar[0].ySpd = guy.ar[0].spd;
				guy.ar[0].xSpd = 0;
				guy.ar[0].rotation = 180;
			}
			else if (zombiecash.main.left)
			{
				guy.ar[0].xSpd =  -  guy.ar[0].spd;
				guy.ar[0].ySpd = 0;
				guy.ar[0].rotation = 270;
			}
			else if (zombiecash.main.right)
			{
				guy.ar[0].xSpd = guy.ar[0].spd;
				guy.ar[0].ySpd = 0;
				guy.ar[0].rotation = 90;
			}
			guy.ar[0].hitBox.rotation =  -  guy.ar[0].rotation;
			guy.ar[0].x +=  guy.ar[0].xSpd;
			guy.ar[0].y +=  guy.ar[0].ySpd;
		}
		public static function healthSystem(event:Event):void
		{
			for (var i=0; i<guy.ar.length; i++)
			{
				if (guy.ar[i].god)
				{
					guy.ar[i].godTimer++;
					if (guy.ar[i].godTimer >= guy.ar[i].godTimerMax)
					{
						guy.ar[i].god = false;
					}
				}
				for (var j=0; j<zombie.ar.length; j++)
				{
					if (guy.ar[i].hitBox.hitTestObject(zombie.ar[j].zomBox))
					{
						if (! guy.ar[i].god)
						{
							guy.ar[i].health--;
							ammoDisplay.ar[i].displayHealth(guy.ar[i]);
						}
						guy.ar[i].god = true;
					}
				}
			}
		}
		public static function shooting(event:Event):void
		{

			var pt1:Point = new Point(guy.ar[0].gunSprite.gunTip.x,guy.ar[0].gunSprite.gunTip.y);
if (zombiecash.main.swap && ! guy.ar[0].swapCheck)
			{
				guns.swapGuns(guy.ar[0], guy.ar[0].gunOut);
				guy.ar[0].swapCheck=true;
			}else if(!zombiecash.main.swap){
				guy.ar[0].swapCheck=false;
			}

			if (zombiecash.main.attack && ! guy.ar[0].aCheck && guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip > 0 && ! guy.ar[0].reloading)
			{
				if(guy.ar[0].gunsAr[guy.ar[0].gunOut].gunShotGun){
					var oldRot=guy.ar[0].rotation;
					for(var l=0;l<guy.ar[0].gunsAr[guy.ar[0].gunOut].gunShotGunBul;l++){
					guy.ar[0].rotation=(oldRot-guy.ar[0].gunsAr[guy.ar[0].gunOut].gunShotGunSpread/2)+Math.random()*guy.ar[0].gunsAr[guy.ar[0].gunOut].gunShotGunSpread;
					guy.ar[0].bullet = new shot(guy.ar[0]);
				guy.ar[0].parent.addChild(guy.ar[0].bullet);
				guy.ar[0].bullet.x = guy.ar[0].gunSprite.gunTip.localToGlobal(pt1).x - zombiecash.main.x;
				guy.ar[0].bullet.y = guy.ar[0].gunSprite.gunTip.localToGlobal(pt1).y - zombiecash.main.y;
				guy.ar[0].rotation=oldRot;
					}
					guy.ar[0].aCheck = true;
				guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip--;
				ammoDisplay.ar[0].displayClip(guy.ar[0]);
				
				}else{
				guy.ar[0].bullet = new shot(guy.ar[0]);
				guy.ar[0].parent.addChild(guy.ar[0].bullet);
				guy.ar[0].bullet.x = guy.ar[0].gunSprite.gunTip.localToGlobal(pt1).x - zombiecash.main.x;
				guy.ar[0].bullet.y = guy.ar[0].gunSprite.gunTip.localToGlobal(pt1).y - zombiecash.main.y;
				guy.ar[0].aCheck = true;
				guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip--;
				ammoDisplay.ar[0].displayClip(guy.ar[0]);
				}
			}
			else if (guy.ar[0].aCheck)
			{
				guy.ar[0].shotTimer++;
				if ((! zombiecash.main.attack||guy.ar[0].gunsAr[guy.ar[0].gunOut].gunRapidFire) && guy.ar[0].shotTimer >= guy.ar[0].gunsAr[guy.ar[0].gunOut].gunShotDelay)
				{
					guy.ar[0].aCheck = false;
					guy.ar[0].shotTimer = 0;
				}
			}
			if ((guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip<=0||zombiecash.main.enterKey)&&!guy.ar[0].reloading&&guy.ar[0].gunsAr[guy.ar[0].gunOut].gunAmmo>0)
			{
				guy.ar[0].reloading = true;
			}
			else if (guy.ar[0].reloading)
			{
				guy.ar[0].reloadTimer++;
				if (guy.ar[0].reloadTimer >= guy.ar[0].gunsAr[guy.ar[0].gunOut].gunReloadDelay)
				{
					guy.ar[0].reloading = false;
					guy.ar[0].reloadTimer = 0;
					guy.ar[0].shotTimer = 0;
					if (guy.ar[0].gunsAr[guy.ar[0].gunOut].gunAmmo >= guy.ar[0].gunsAr[guy.ar[0].gunOut].gunMaxClip)
					{
						guy.ar[0].gunsAr[guy.ar[0].gunOut].gunAmmo -=  guy.ar[0].gunsAr[guy.ar[0].gunOut].gunMaxClip - guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip;
						guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip = guy.ar[0].gunsAr[guy.ar[0].gunOut].gunMaxClip;
					}
					else
					{
						guy.ar[0].gunsAr[guy.ar[0].gunOut].gunClip = guy.ar[0].gunsAr[guy.ar[0].gunOut].gunAmmo;
						guy.ar[0].gunsAr[guy.ar[0].gunOut].gunAmmo = 0;
					}
					ammoDisplay.ar[0].displayClip(guy.ar[0]);
					ammoDisplay.ar[0].displayAmmo(guy.ar[0]);
				}
			}
			for (var i = 0; i<shot.ar.length; i++)
			{
				shot.ar[i].x +=  shot.ar[i].xSpd;
				shot.ar[i].y +=  shot.ar[i].ySpd;
			}
		}
	}

}