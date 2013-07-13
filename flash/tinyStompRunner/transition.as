package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundTransform;

	public class transition extends MovieClip
	{
		
		public static var trans;
		public static var func;
		public static var loaded = false;
		public static var soundOut=0;
		public var posX = 1939;
		public var posy = 158;
		public function transition()
		{
			trans = this;
			stop();
			this.x = posX;

		}

		public static function addScreen(newFunc:Object, soundType:Number=0)
		{
			soundOut=soundType;
			trans.visible = true;
			func = newFunc;
			trans.play();
			trans.x = trans.posX;
			trans.y = 158;
			loaded = false;
			runner.main.stage.addEventListener(Event.ENTER_FRAME, showTime, false,  -1,  false);
		}
		

		public static function showTime(event:Event):void
		{
			if(soundOut==1){
				var transform:SoundTransform = runner.sndChan.soundTransform;
				transform.volume = 1-((trans.currentFrame)/trans.totalFrames);
				runner.sndChan.soundTransform = transform;
			}
			
			if (trans.currentFrame == 15)
			{
				runner.main.root.x = 0;
				runner.main.root.y = 0;
				func();
				
			}
			else if (trans.currentFrame==trans.totalFrames)
			{
				trans.gotoAndStop(1);
				trans.visible = false;
				trans.stop();
				runner.main.stage.removeEventListener(Event.ENTER_FRAME, showTime);
				if(soundOut==1){
				transform.volume = 1;
				runner.sndChan.soundTransform = transform;
				}
			}
			if (trans.currentFrame > 15)
			{
				loaded = true;
				
			}
			else
			{
				loaded = false;
			}
			transition.trans.x = -runner.main.x+ transition.trans.posX;
			
		}

	}

}