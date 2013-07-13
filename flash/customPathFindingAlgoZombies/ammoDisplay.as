package 
{

	import flash.display.MovieClip;
	import flash.text.TextField;

	public class ammoDisplay extends MovieClip
	{
		public static var clipMC:clipAmmo;
		public static var heartMC:heart;
		public static var ar:Array = new Array();
		public var clipAr:Array = new Array();
		public var heartAr:Array = new Array();
		public function ammoDisplay()
		{
			ar.push(this);
			displayClip(guy.ar[0]);
			displayAmmo(guy.ar[0]);
			displayCash(guy.ar[0]);
			displayHealth(guy.ar[0]);
		}
		public function displayClip(item:MovieClip)
		{
			for (var i =0; i<clipAr.length; i++)
			{
				clipAr[i].parent.removeChild(clipAr[i]);
			}
			clipAr.splice(0,clipAr.length);
			for (i =0; i<item.gunsAr[guy.ar[0].gunOut].gunClip; i++)
			{
				clipMC = new clipAmmo();
				this.parent.addChild(clipMC);
				clipMC.x = this.x;
				clipMC.y =  this.y+(-i * 4);
				clipAr.push(clipMC);
			}
		}
		public function displayAmmo(item:MovieClip)
		{
			this.ammoText.text = String(item.gunsAr[guy.ar[0].gunOut].gunAmmo);
		}
		public function displayCash(item:MovieClip)
		{
			this.cashText.text = String(item.cash);
		}
		public function displayHealth(item:MovieClip)
		{
			for (var i =0; i<heartAr.length; i++)
			{
				heartAr[i].parent.removeChild(heartAr[i]);
			}
			heartAr.splice(0,heartAr.length);
			for (i =0; i<item.health; i++)
			{
				heartMC = new heart();
				this.parent.addChild(heartMC);
				heartMC.x = this.x;
				heartMC.y =  this.y-355+(i * 10);
				heartAr.push(heartMC);
			}
		}
	}

}