package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.display.MovieClip;


	public class gameScreen extends MovieClip
	{
		public static var gamescreen;
		public static var gold = 0;
			public static var cost = 5;
		public var newGuy:guy;
		public var aCheck = false;
		public var sCheck = false;
		public var dCheck = false;
		public var fCheck = false;

		public function gameScreen()
		{
			gamescreen = this;
			HUD.hud.goldNum.text = String(gold);
			this.addEventListener(Event.ENTER_FRAME, hotkeys, false, 0, true);
		}
		function hotkeys(event:Event):void
		{
			if (! aCheck && mousebattle(root).aKey)
			{
				cost=5;
				guy.create=1;
				if(gold>=cost){
					addGold(-cost);
				newGuy = new guy();
				newGuy.x = mouse.mice.x;
				newGuy.y = mouse.mice.y + 350;
				this.addChild(newGuy);
				}
				aCheck = true;
			}
			else if (!mousebattle(root).aKey)
			{
				aCheck = false;
			}
			if (! sCheck && mousebattle(root).sKey)
			{
				cost=50;
				guy.create=2;
				if(gold>=cost){
					addGold(-cost);
				newGuy = new guy();
				newGuy.x = mouse.mice.x;
				newGuy.y = mouse.mice.y + 350;
				this.addChild(newGuy);
				}
				sCheck = true;
			}
			else if (!mousebattle(root).sKey)
			{
				sCheck = false;
			}
			if (! dCheck && mousebattle(root).dKey)
			{
				cost=200;
				guy.create=3;
				if(gold>=cost){
					addGold(-cost);
				newGuy = new guy();
				newGuy.x = mouse.mice.x;
				newGuy.y = mouse.mice.y + 350;
				this.addChild(newGuy);
				}
				dCheck = true;
			}
			else if (!mousebattle(root).dKey)
			{
				dCheck = false;
			}
			if (! fCheck && mousebattle(root).fKey)
			{
				cost=1000;
				guy.create=4;
				if(gold>=cost){
					addGold(-cost);
				newGuy = new guy();
				newGuy.x = mouse.mice.x;
				newGuy.y = mouse.mice.y + 350;
				this.addChild(newGuy);
				}
				fCheck = true;
			}
			else if (!mousebattle(root).fKey)
			{
				fCheck = false;
			}
		}
		function addGold(goldPlus:Number):void
		{
			gold +=  goldPlus;
			HUD.hud.goldNum.text = String(gold);
		}
	}

}