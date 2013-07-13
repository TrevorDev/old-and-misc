package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.display.MovieClip;
    import flash.geom.ColorTransform;

	public class bad1 extends MovieClip
	{
		public var newBad:bad1;
		public static var spawnType = 1;
		public static var badGuy:Array = new Array();
		public static var maxBad = 10;
		public static var badDist=400;;
		public static var deg;
		public var health = 200;
		public var maxHealth = 200;
		public var money = 5;
		public var dmg = 2;
		public var index = 0;
		public var i = 0;
		public var j = 0;
		public static var k = 0;
		public var hit = false;
		
		public var colorVal;
		public function bad1()
		{
			
				
			gotoAndStop(spawnType);
			
			if(spawnType>4){
			var blue:int = int(255-(30*(spawnType)-4));
				var colorVal:Number = Number("0x" + blue.toString(16) + blue.toString(16) + blue.toString(16));
				trace(colorVal);
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = colorVal;
				this.appear.transform.colorTransform = colorTransform;
			}
			health*=spawnType*spawnType;
			dmg*=spawnType*spawnType;
			money*=spawnType*spawnType;
			index = badGuy.push(this) - 1;
			maxHealth=health;
			this.addEventListener(Event.ENTER_FRAME, atkDefEtc, false, 0, true);
			hitBox.visible = false;
		}
		function atkDefEtc(event:Event):void
		{
			if (badGuy.length < maxBad)
			{
				for (i=badGuy.length; i<maxBad; i++)
				{
					newBad = new bad1();
					deg = Math.random() * 2 * Math.PI;

					newBad.x = HUD.hud.x + badDist * Math.sin(deg);
					newBad.y = HUD.hud.y + badDist * Math.cos(deg);
					gameScreen.gamescreen.addChildAt(newBad,10);
					k++;

				}

			}
			for (i=0; i<guy.army.length; i++)
			{
				if (this.hitBox.hitTestObject(guy.army[i].appear))
				{
					guy.army[i].health -=  dmg;
					guy.army[i].healthCheck();
					i = guy.army.length;
				}
			}
			hit = false;
			for (j=0; j<grounder.allGround.length; j++)
			{
				
				if (this.hitTestObject(grounder.allGround[j]))
				{
					hit = true;
					
				}
			}
			
			if (! hit)
			{
				this.removeEventListener(Event.ENTER_FRAME, atkDefEtc);

				parent.removeChild(this);
				for (i=index+1; i<bad1.badGuy.length; i++)
				{
					bad1.badGuy[i].index--;
				}
				badGuy.splice(index, 1);
			}
		}
		function healthCheck()
		{
			if (health <= 0)
			{
gameScreen.gamescreen.addGold(money);
				this.removeEventListener(Event.ENTER_FRAME, atkDefEtc);

				parent.removeChild(this);
				for (i=index+1; i<bad1.badGuy.length; i++)
				{
					bad1.badGuy[i].index--;
				}
				badGuy.splice(index, 1);
			}


		}
	}

}