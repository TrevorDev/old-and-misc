package  {
	
		import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	import fl.transitions.easing.None;
	
	
	public class arcade extends MovieClip {
		public static var main;
		public static var page;
		
		public function arcade() {
			main = this;
			new input(stage);
			show_begin();
		}
		
		//INTERFACE==================================================
		public function show_begin()
		{
			root.x = 0;
			root.y = 0;
			page = new startMenu();
			addChild(page);
		}
		
		public function unloadPage()
		{
			root.x = 0;
			root.y = 0;
			page.remove();
			removeChild(page);
		}
		
		public function startGame()
		{
			unloadPage();
			page = new level1();
			addChild(page);
			player.p1.cams(null);
		}
		
		public function changeLevel(levelNum)
		{
			unloadPage();
			if(levelNum==2){
				page = new level2();
			}else if(levelNum==3){
				page = new level3();
			}else if(levelNum==4){
				page = new level4();
			}else if(levelNum==5){
				page = new level5();
			}else{
				page = new level1();
			}
			addChild(page);
			player.p1.cams(null);
		}
		
		

		
	}
	
}
