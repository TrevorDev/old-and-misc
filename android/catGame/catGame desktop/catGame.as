package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Keyboard;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
    import flash.media.SoundTransform;
	import flash.desktop.SystemIdleMode;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;

	public class catGame extends MovieClip
	{
		Multitouch.inputMode = MultitouchInputMode.NONE;
		public static var main;
		public var start_screen:startScreen;
		public var level_select_screen:levelSelectScreen;
		public var playing_screen:playingScreen;
		public var fling_screen:flingScreen;
		public var fling_score_screen:flingScore;
		//public var level_screen:menuLevelSelectScene;
		//public var options_screen:menuOptionsScene;
		
		//public static var pause_screen:pauseMenu;
		public static var midDown = false;
		public static var leftDown = false;
		public static var rightDown = false;
		public static var upDown = false;
		public static var pauseStart = false;
		public static var level_select;

		public static var snd:Sound = new Sound();
		public static var soundChannel:SoundChannel;
		
		public static var hitSound:Sound;
		public static var windowSound:Sound;
		public static var menuSound:Sound;

		public function catGame()
		{
			hitSound = new hitS();
			windowSound = new winS();
			menuSound = new menuS();
			main = this;
			bgMusic();
			showStartScreen();
		}
		
		public static function bgMusic(){
			var snd:gameMusic= new gameMusic();
			soundChannel = snd.play(0, 99999);
            var transform:SoundTransform = soundChannel.soundTransform;
            transform.volume = 0;
            soundChannel.soundTransform = transform;
			volAudio(0.5);
		}
		
		public static function panAudio(dir) {
			var transform:SoundTransform = soundChannel.soundTransform;
            transform.pan = dir;
            soundChannel.soundTransform = transform;
		}
		
		public static function volAudio(volume) {
            var transform:SoundTransform = soundChannel.soundTransform;
            transform.volume = volume;
            soundChannel.soundTransform = transform;
		}
		
		public static function getVol() {
			return soundChannel.soundTransform.volume;
		}
		
		public function unloadScreen()
		{
			if(start_screen!=null&&this.contains(start_screen)){
				start_screen.start_button.removeEventListener(MouseEvent.MOUSE_DOWN,start_button_clicked);
				start_screen.mute_button.removeEventListener(MouseEvent.MOUSE_DOWN, sound_toggle_clicked);
				removeChild(start_screen);
				start_screen=null;
				
				if(catGame.getVol() > 0) {
						catGame.menuSound.play();
				}
			}
			if(level_select_screen!=null&&this.contains(level_select_screen)){
				level_select_screen.level_screen_back_button.removeEventListener(MouseEvent.MOUSE_DOWN, level_screen_back_button_clicked);
				level_select_screen.arcade_button.removeEventListener(MouseEvent.MOUSE_DOWN, arcade_button_clicked);
				//level_select_screen.world_1_button.removeEventListener(TouchEvent.TOUCH_TAP, world_1_button_clicked);
				//level_select_screen.world_2_button.removeEventListener(TouchEvent.TOUCH_TAP, world_2_button_clicked);
				level_select_screen.mouseFlingButton.removeEventListener(MouseEvent.MOUSE_DOWN, fling_mouse_button_clicked);
				removeChild(level_select_screen);
				level_select_screen=null;
				if(catGame.getVol() > 0) {
						catGame.menuSound.play();
				}
			}
			if(fling_screen!=null&&this.contains(fling_screen)){
				unloadFlingScreen();
			}
			if(playing_screen!=null&&this.contains(playing_screen)){
				playingScreen.unloader();
				removeChild(playing_screen);
				
			}
			if(fling_score_screen!=null&&this.contains(fling_score_screen)) {
				unloadFlingScore();
				if(catGame.getVol() > 0) {
						catGame.menuSound.play();
				}
			}
		}
		public function showStartScreen()
		{
			unloadScreen();
			start_screen = new startScreen;
			start_screen.start_button.addEventListener(MouseEvent.MOUSE_DOWN, start_button_clicked);
			start_screen.mute_button.addEventListener(MouseEvent.MOUSE_DOWN, sound_toggle_clicked);
			addChild(start_screen);
			start_screen.x = 0;
			start_screen.y = 0;
		}
		
		public function sound_toggle_clicked(event:MouseEvent)
		{
			if(getVol() > 0) {
				volAudio(0);
			}
			else
			{
				volAudio(0.5);
			}
		}

		public function start_button_clicked(event:MouseEvent)
		{
			showLevelSelectScreen();
		}

		public function showLevelSelectScreen()
		{
			unloadScreen();
			level_select_screen = new levelSelectScreen  ;
			//level_select_screen.menuLevelSelect.addEventListener(MouseEvent.CLICK, levelMenu_button_clicked);
			level_select_screen.level_screen_back_button.addEventListener(MouseEvent.MOUSE_DOWN, level_screen_back_button_clicked);
			level_select_screen.arcade_button.addEventListener(MouseEvent.MOUSE_DOWN, arcade_button_clicked);
			//level_select_screen.world_1_button.addEventListener(TouchEvent.TOUCH_TAP, world_1_button_clicked);
			//level_select_screen.world_2_button.addEventListener(TouchEvent.TOUCH_TAP, world_2_button_clicked);
			level_select_screen.mouseFlingButton.addEventListener(MouseEvent.MOUSE_DOWN, fling_mouse_button_clicked);
			addChild(level_select_screen);
			level_select_screen.x = 0;
			level_select_screen.y = 0;
		}
		
		public function level_screen_back_button_clicked(event:MouseEvent)
		{
			showStartScreen();
		}
		
		public function arcade_button_clicked(event:MouseEvent)
		{
			showPlayingScreen(0);
		}
		
		public function world_1_button_clicked(event:MouseEvent)
		{
			showPlayingScreen(1);
		}
		
		public function world_2_button_clicked(event:MouseEvent)
		{
			showPlayingScreen(2);
		}
		
		public function fling_mouse_button_clicked(event:MouseEvent)
		{
			showPlayingScreen(3);
		}
		
		public function showPlayingScreen(gameType:Number)
		{
			unloadScreen();
			if(gameType == 0) {
				playing_screen = new playingScreen;
				addChild(playing_screen);
				playing_screen.x = 0;
				playing_screen.y = 0;
			}
			else if(gameType == 3) {
				fling_screen = new flingScreen(15);
				addChild(fling_screen);
				fling_screen.x = 0;
				fling_screen.y = 0;
			}

		}
		
		public function unloadFlingScreen()
		{
			fling_screen.unloadScreen();
			removeChild(fling_screen);
			fling_screen = null;
		}
		
		public function showFlingScore(score:Number, total:Number) {
				fling_score_screen = new flingScore(score, total);
				addChild(fling_score_screen);
				fling_score_screen.x = 0;
				fling_score_screen.y = 0;
		}
		
		public function unloadFlingScore() {
			fling_score_screen.unloadScore();
			removeChild(fling_score_screen);
			fling_score_screen = null;
		}
	}

}