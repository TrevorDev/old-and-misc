package  {
	
	import flash.display.MovieClip;
	
	
	public class arcade extends MovieClip {
		public static var main;
		
		public function arcade() {
			main = this;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			trace("hi");
			show_begin();
		}
		
		//INTERFACE==================================================
		public function show_begin()
		{
			root.x = 0;
			root.y = 0;
			var level1 = new level1(this);
			
			addChild(level1);
		}
		
		//KEYBOARD INPUT=============================================
		function keyIsDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 27)
			{
				escKey = true;
			}
			if (event.keyCode == 37)
			{
				left = true;
			}
			if (event.keyCode == 38)
			{
				up = true;
			}
			if (event.keyCode == 39)
			{
				right = true;
			}
			if (event.keyCode == 40)
			{
				down = true;
			}
			if (event.keyCode == 13)
			{
				enterKey = true;
			}
			if (event.keyCode == 116)
			{
				fFive = true;
			}
			if (event.keyCode == 88)
			{
				attack = true;
			}
		if (event.keyCode == 49)
			{
				one = true;
			}
			if (event.keyCode == 50)
			{
				two = true;
			}
			if (event.keyCode == 51)
			{
				three = true;
			}
		}


		function keyIsUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 27)
			{
				escKey = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 38)
			{
				up = false;
			}
			if (event.keyCode == 39)
			{
				right = false;
			}
			if (event.keyCode == 40)
			{
				down = false;
			}
			if (event.keyCode == 13)
			{
				enterKey = false;
			}
			if (event.keyCode == 116)
			{
				fFive = false;
			}
			if (event.keyCode == 88)
			{
				attack = false;
			}
			if (event.keyCode == 49)
			{
				one = false;
			}
			if (event.keyCode == 50)
			{
				two = false;
			}
			if (event.keyCode == 51)
			{
				three = false;
			}
		}

		
	}
	
}
