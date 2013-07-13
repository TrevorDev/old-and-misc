package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	
	
	public class gunPickup extends MovieClip {
		public static var ar:Array = new Array();
		public var gunNum = 0;
		public var gunCost = 0;
		public var ammoCost = 0;
		public function gunPickup() {
			ar.push(this);
			hitBox.visible=false;
		}
		public static function makeStore(event:Event):void
		{
			for (var j = 0; j<guy.ar.length; j++)
			{
				var storeHiter = false;
				for (var i = 0; i<gunPickup.ar.length; i++)
				{
gunPickup.ar[i].gunShow.gotoAndStop(gunPickup.ar[i].gunNum+1);
					if (gunPickup.ar[i].hitTestObject(guy.ar[j].hitBox))
					{
						storeHiter = true;
						
							dialogue.ar[j].displayWords(String("Buy Gun: "+gunPickup.ar[i].gunCost+"    Buy Ammo: "+gunPickup.ar[i].ammoCost));
						
						
						if (zombiecash.main.enterKey)
						{
							if (guy.ar[j].cash >= gunPickup.ar[i].gunCost)
							{
								guns.setGun(guy.ar[j],gunPickup.ar[i].gunNum);
								guy.ar[j].cash -=  gunPickup.ar[i].gunCost;
							}

						}

					}
				}
				if (! storeHiter)
				{
					dialogue.ar[j].hideWords();
				}

			}
		}
	}
	
}
