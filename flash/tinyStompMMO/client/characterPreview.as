package  {
	
	import flash.display.MovieClip;
	
	
	public class characterPreview extends MovieClip {
		
		public var thisRef:Number = 0;
		
		public function characterPreview() {
			charPreview.visible = false;
			if(landworld.main.eyeLook != 0)
			{
				guySprite.lookPlayer=thisRef;
				eye.look[guySprite.lookPlayer]=landworld.main.eyeLook;
				hats.look[guySprite.lookPlayer]=landworld.main.hatsLook;
				foot.look[guySprite.lookPlayer]=landworld.main.shoesLook;
				head.look[guySprite.lookPlayer]=landworld.main.headLook;
				charPreview.gotoAndStop(2);
				charPreview.gotoAndStop(1);
				charPreview.visible = true;
			}
		}
		
		public function showCharacter(eyeLook:int, headLook:int, shoesLook:int, hatsLook:int)
		{
			guySprite.lookPlayer=thisRef;
			eye.look[guySprite.lookPlayer]=eyeLook;
			hats.look[guySprite.lookPlayer]=hatsLook;
			foot.look[guySprite.lookPlayer]=shoesLook;
			head.look[guySprite.lookPlayer]=headLook;
			charPreview.gotoAndStop(2);
			charPreview.gotoAndStop(1);
			charPreview.visible = true;
		}
	}
	
}
