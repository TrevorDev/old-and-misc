package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class shot extends MovieClip
	{
		public static var ar:Array = new Array();
		public static var maxShots = 50;
		public var user;
		public var pushBack = 0;
		public var dmg = 0;
		public var spd = 0;
		public var xSpd = 0;
		public var ySpd = 0;


		public function shot(player:MovieClip)
		{
			user = player;
			pushBack = player.gunsAr[guy.ar[0].gunOut].gunPush;
			dmg = player.gunsAr[guy.ar[0].gunOut].gunDmg;
			spd = player.gunsAr[guy.ar[0].gunOut].gunSpd;
			this.gotoAndStop(player.gunSprite);
			this.rotation = player.rotation;
			xSpd=player.gunsAr[guy.ar[0].gunOut].gunSpd*Math.cos((this.rotation-90)/180*Math.PI);
			ySpd=player.gunsAr[guy.ar[0].gunOut].gunSpd*Math.sin((this.rotation-90)/180*Math.PI);
			if (ar.length > maxShots)
			{
				ar[0].parent.removeChild(ar[0]);
				ar.splice(0,1);
			}
			ar.push(this);
		}
		public static function shotRmv(item:MovieClip):void
		{
			shot.ar.splice(shot.ar.indexOf(item),1);
			item.parent.removeChild(item);
		}
		public static function bulletHit(event:Event):void
		{
			for (var i=0; i<shot.ar.length; i++)
			{
				var gone = false;
				for (var j=0; j<wall.ar.length&&!gone; j++)
				{
					if (shot.ar[i].hitTestObject(wall.ar[j]))
					{
						shotRmv(shot.ar[i]);
						gone = true;
					}
				}
				for (j=0; j<zombie.ar.length&&!gone; j++)
				{
					if (shot.ar[i].hitTestObject(zombie.ar[j]))
					{
						var gold = zombie.ar[j].val;
						var zomAndWall = false;
						for (var l=0; l<wall.ar.length; l++)
						{
							if (zombie.ar[j].zomBox.hitTestObject(wall.ar[l]))
							{
								zomAndWall = true;
								break;
							}
						}
						if (! zomAndWall)
						{
							zombie.ar[j].x +=  shot.ar[i].pushBack * shot.ar[i].xSpd / shot.ar[i].spd;
							zombie.ar[j].y +=  shot.ar[i].pushBack * shot.ar[i].ySpd / shot.ar[i].spd;
						}
						zombie.ar[j].health -=  shot.ar[i].dmg;
						if (zombie.zomLifeCheck(zombie.ar[j]))
						{
							shot.ar[i].user.cash +=  gold;
							ammoDisplay.ar[guy.ar.indexOf(shot.ar[i].user)].displayCash(shot.ar[i].user);
						}
						shotRmv(shot.ar[i]);
						gone = true;
					}
				}
			}
		}
	}

}