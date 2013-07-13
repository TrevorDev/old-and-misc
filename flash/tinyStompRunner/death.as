package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;


	public class death extends MovieClip
	{
		public static var ar:Array = new Array();

		public function death()
		{
			ar.push(this);
		}

		public static function makeDeath(event:Event):void
		{
			var deaths = death.ar;
			if (! guy.ar[0].dead && guy.ar[0].y >= 432.5)
			{
				guy.ar[0].dead = true;
				guy.ar[0].animate.gotoAndStop(3);
				guy.ar[0].animate.died.play();
				runner.cash+=ground.cashGained;
				if(!runner.mute){
				var snd= new ouch();
						snd.play();
				}
			}
			for (var j:Number=0; j<deaths.length; j++)
			{
				for (var i:Number=0; i<guy.ar.length; i++)
				{
					if ((!guy.ar[0].dead&&deaths[j].hitTestObject(guy.ar[i].boxHit.body)))
					{
						guy.ar[0].dead = true;
						guy.ar[i].animate.gotoAndStop(3);
						
						guy.ar[i].animate.died.play();
						runner.cash+=ground.cashGained;
						if(!runner.mute){
						snd= new ouch();
						snd.play();
						}
					}


				}
			}
			if (guy.ar[0].dead)
			{
				guy.ar[0].animate.rotation=0;
				if (guy.ar[0].animate.died.currentFrame == guy.ar[0].animate.died.totalFrames)
				{
					guy.ar[0].animate.died.stop();
					transition.addScreen(runner.main.show_preScreen, 1);

				}
			}
		}

	}
}