package 
{

	import flash.display.MovieClip;


	public class guns extends MovieClip
	{
		public static var guner:guns;

		public var gunOut = 0;
		public var gunOwned = false;
		public var gunShotDelay = 0;
		public var gunReloadDelay = 0;
		public var gunClip = 0;
		public var gunMaxClip = 0;
		public var gunAmmo = 0;
		public var gunMaxAmmo = 0;
		public var gunSpd = 0;
		public var gunDmg = 0;
		public var gunPush = 0;
		public var gunRapidFire = false;
		public var gunShotGun = false;
		public var gunShotGunBul = 10;
		public var gunShotGunSpread = 10;

		public function guns()
		{

		}
		public static function setGun(item:MovieClip, curGun:Number):void
		{
			item.gunsAr[curGun].gunOwned = true;
			item.gunOut = curGun;
			item.gunSprite.gotoAndStop(item.gunOut+1);
			var player = guy.ar.indexOf(item);
			ammoDisplay.ar[player].displayClip(guy.ar[player]);
			ammoDisplay.ar[player].displayAmmo(guy.ar[player]);
		}
		public static function swapGuns(item:MovieClip, curGun:Number):void
		{
			for (var i =curGun+1; i<item.gunsAr.length+1; i++)
			{
				
				if (i == item.gunsAr.length)
				{
					i = 0;
				}
				if (item.gunsAr[i].gunOwned == true)
				{
					item.gunOut = item.gunsAr[i].gunOut;
					item.gunSprite.gotoAndStop(item.gunOut+1);

					break;
				}
			}
		}
		public static function loadGuns(item:MovieClip):void
		{

			for (var i=0; i<3; i++)
			{
				guner = new guns();
				item.gunsAr.push(guner);
				if (i == 0)
				{
					guner.gunOut = i;
					guner.gunOwned = true;
					guner.gunShotDelay = 0;
					guner.gunReloadDelay = 90;
					guner.gunClip = 8;
					guner.gunMaxClip = 8;
					guner.gunAmmo = 56;
					guner.gunMaxAmmo = 56;
					guner.gunSpd = 8;
					guner.gunDmg = 20;
					guner.gunPush = 8;
					guner.gunRapidFire = false;
				}
				else if (i == 1)
				{
					guner.gunOut = i;
					guner.gunOwned = false;
					guner.gunShotDelay = 5;
					guner.gunReloadDelay = 60;
					guner.gunClip = 20;
					guner.gunMaxClip = 20;
					guner.gunAmmo = 100;
					guner.gunMaxAmmo = 100;
					guner.gunSpd = 10;
					guner.gunDmg = 15;
					guner.gunPush = 5;
					guner.gunRapidFire = true;
				}
				else if (i == 2)
				{
					guner.gunOut = i;
					guner.gunOwned = false;
					guner.gunShotDelay = 0;
					guner.gunReloadDelay = 90;
					guner.gunClip = 2;
					guner.gunMaxClip = 2;
					guner.gunAmmo = 20;
					guner.gunMaxAmmo = 20;
					guner.gunSpd = 8;
					guner.gunDmg = 10;
					guner.gunPush = 8;
					guner.gunRapidFire = false;
					guner.gunShotGun = true;
				}
			}
		}
	}

}