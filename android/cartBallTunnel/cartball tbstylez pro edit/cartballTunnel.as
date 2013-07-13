package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class cartballTunnel extends MovieClip
	{
		public static var main;
		public var splash_screen:menuBeginScene;
		public var begin_screen:menuSelectionScene;
		public var level_screen:menuLevelSelectScene;
		public var options_screen:menuOptionsScene;
		public static var pause_screen:pauseMenu;
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		public static var midDown = false;
		public static var leftDown = false;
		public static var rightDown = false;
		public static var pauseStart = false;
		public static var level_select;

		public function cartballTunnel()
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			main = this;
			//sound.bgMusic();
			
			showStartMenu();
		}

		

		

		public function showStartMenu()
		{
			splash_screen = new menuBeginScene  ;
			splash_screen.menuStartBtnInt.addEventListener(MouseEvent.CLICK, start_button_clicked);
			addChild(splash_screen);
			splash_screen.x = 400;
			splash_screen.y = 240;
		}

		public function start_button_clicked(event:MouseEvent)
		{
			splash_screen.menuStartBtnInt.removeEventListener(MouseEvent.CLICK,start_button_clicked);
			removeChild(splash_screen);
			showMenuBeginScene();
		}

		public function showMenuBeginScene()
		{
			begin_screen = new menuSelectionScene  ;
			begin_screen.menuLevelSelect.addEventListener(MouseEvent.CLICK, levelMenu_button_clicked);
			begin_screen.menuOptionsMenu.addEventListener(MouseEvent.CLICK, optionsMenu_button_clicked);
			addChild(begin_screen);
			begin_screen.x = 400;
			begin_screen.y = 240;
		}
		public function levelMenu_button_clicked(event:MouseEvent)
		{
			begin_screen.menuLevelSelect.removeEventListener(MouseEvent.CLICK, levelMenu_button_clicked);
			begin_screen.menuOptionsMenu.removeEventListener(MouseEvent.CLICK, optionsMenu_button_clicked);
			removeChild(begin_screen);
			begin_screen = null;
			showMenuLevelSelectionScene();
		}

		public function optionsMenu_button_clicked(event:MouseEvent)
		{
			begin_screen.menuLevelSelect.removeEventListener(MouseEvent.CLICK, levelMenu_button_clicked);
			begin_screen.menuOptionsMenu.removeEventListener(MouseEvent.CLICK, optionsMenu_button_clicked);
			removeChild(begin_screen);
			showOptionScene();
		}

		public function showMenuLevelSelectionScene()
		{
			level_screen = new menuLevelSelectScene  ;
			addChild(level_screen);
			level_screen.x = 400;
			level_screen.y = 240;
			for (var i=0; i<worldIcon.ar.length; i++)
			{
				worldIcon.ar[i].addEventListener(MouseEvent.CLICK, worldIcon.ar[i].selectLevel);
			}
		}

		public function loadLevel(world:int, level:int)
		{
			if (world==1&&level==1)
			{
				level_select=new level_one();
			}
			if (world==1&&level==2)
			{
				level_select = new level_two();
			}
			for (var i=0; i<worldIcon.ar.length; i++)
			{
				worldIcon.ar[i].removeEventListener(MouseEvent.CLICK, worldIcon.ar[i].selectLevel);
			}

			worldIcon.ar.splice(0,worldIcon.ar.length);

			removeChild(cartballTunnel.main.level_screen);
			flash.system.System.gc();
			addChild(level_select);
			addGameListeners();
			cartballTunnel.main.x =  -  character.ar[0].x + 275;
			

		}

		public function addGameListeners()
		{
			

			addEventListener(Event.ENTER_FRAME, character.movePlayer, false, 0, true);
			addEventListener(Event.ENTER_FRAME, cart.moveCart, false, 0, true);
			addEventListener(Event.ENTER_FRAME, block.blocker, false, 0, true);
			addEventListener(Event.ENTER_FRAME, death.moveDeath, false, 0, true);
			addEventListener(Event.ENTER_FRAME,touchDown.winSpot,false,0,true);
		}
		public function rmvGameListeners()
		{

			
			removeEventListener(Event.ENTER_FRAME, character.movePlayer);
			removeEventListener(Event.ENTER_FRAME, cart.moveCart);
			removeEventListener(Event.ENTER_FRAME, block.blocker);
			removeEventListener(Event.ENTER_FRAME, death.moveDeath);
			removeEventListener(Event.ENTER_FRAME, touchDown.winSpot);
		}
		public function addGameListenersPause()
		{

			
			addEventListener(Event.ENTER_FRAME, character.movePlayer, false, 0, true);
			addEventListener(Event.ENTER_FRAME, cart.moveCart, false, 0, true);
			addEventListener(Event.ENTER_FRAME, block.blocker, false, 0, true);
			addEventListener(Event.ENTER_FRAME, death.moveDeath, false, 0, true);
			addEventListener(Event.ENTER_FRAME, touchDown.winSpot,false,0,true);
		}
		public function rmvGameListenersPause()
		{

			
			removeEventListener(Event.ENTER_FRAME, character.movePlayer);
			removeEventListener(Event.ENTER_FRAME, cart.moveCart);
			removeEventListener(Event.ENTER_FRAME, block.blocker);
			removeEventListener(Event.ENTER_FRAME, death.moveDeath);
			removeEventListener(Event.ENTER_FRAME, touchDown.winSpot);
		}
		public static function pauseFunction(event:TouchEvent)
		{
			if (pauseStart)
			{
				// game is resumed
				main.addGameListenersPause();
				pauseStart = false;
			}
			else
			{
				// game is paused
				pauseStart = true;
				main.rmvGameListenersPause();
				showPauseMenu();
			}
		}

		public static function showPauseMenu()
		{
			pause_screen = new pauseMenu  ;
			pause_screen.resumeBtnInt.addEventListener(MouseEvent.CLICK,main.resumeGame);
			pause_screen.exitBtnInt.addEventListener(MouseEvent.CLICK,main.exitGame);
			buttonLayer.ar[0].addChild(pause_screen);
			pause_screen.x = 150;
			pause_screen.y = 0;
		}

		public function resumeGame(event:MouseEvent)
		{
			pause_screen.resumeBtnInt.removeEventListener(MouseEvent.CLICK,main.resumeGame);
			pause_screen.exitBtnInt.removeEventListener(MouseEvent.CLICK,main.exitGame);
			addGameListenersPause();
			buttonLayer.ar[0].removeChild(pause_screen);
		}

		public function exitGame(event:MouseEvent)
		{
			main.x = 0;
			main.y = 0;
			pause_screen.resumeBtnInt.removeEventListener(MouseEvent.CLICK,main.resumeGame);
			pause_screen.exitBtnInt.removeEventListener(MouseEvent.CLICK,main.exitGame);
			buttonLayer.ar[0].removeChild(pause_screen);
			pause_screen = null;
			rmvGameListeners();
			character.ar.splice(0,character.ar.length);
			cart.ar.splice(0,cart.ar.length);
			block.ar.splice(0,block.ar.length);
			death.ar.splice(0,block.ar.length);
			buttons.ar.splice(0,buttons.ar.length);
			button.ar.splice(0,button.ar.length);
			buttonLayer.ar.splice(0,buttonLayer.ar.length);
			touchDown.ar.splice(0,touchDown.ar.length);

			removeChild(level_select);
			flash.system.System.gc();
			main.showMenuBeginScene();
		}
		public function exitGames(event:MouseEvent)
		{
			leftDown = false;
			rightDown = false;
			main.x = 0;
			main.y = 0;


			rmvGameListeners();
			character.ar.splice(0,character.ar.length);
			cart.ar.splice(0,cart.ar.length);
			block.ar.splice(0,block.ar.length);
			death.ar.splice(0,block.ar.length);
			buttons.ar.splice(0,buttons.ar.length);
			button.ar.splice(0,button.ar.length);
			buttonLayer.ar.splice(0,buttonLayer.ar.length);
			touchDown.ar.splice(0,touchDown.ar.length);

			removeChild(level_select);
			
			main.showMenuBeginScene();
		}

		public static function touchMid(event:TouchEvent)
		{
			midDown = true;
		}
		function keyIsDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 37)
			{
				leftDown = true;
			}

			if (event.keyCode == 39)
			{
				rightDown = true;
			}
		}


		function keyIsUp(event:KeyboardEvent):void
		{

			if (event.keyCode == 37)
			{
				leftDown = false;
			}

			if (event.keyCode == 39)
			{
				rightDown = false;
			}

		}
		public static function touchLeft(event:TouchEvent)
		{

			leftDown = true;

		}
		public static function stopTouchLeft(event:TouchEvent)
		{

			leftDown = false;

		}
		public static function touchRight(event:TouchEvent)
		{
			rightDown = true;

		}
		public static function stopTouchRight(event:TouchEvent)
		{
			rightDown = false;

		}
		public function showOptionScene()
		{
			options_screen = new menuOptionsScene  ;
			options_screen.optionsBackBtnInt.addEventListener(MouseEvent.CLICK,optionsBack_button_clicked);
			addChild(options_screen);
			options_screen.x = 400;
			options_screen.y = 240;
		}

		public function optionsBack_button_clicked(event:MouseEvent)
		{
			options_screen.optionsBackBtnInt.removeEventListener(MouseEvent.CLICK,optionsBack_button_clicked);
			removeChild(options_screen);
			showMenuBeginScene();
		}

	}

}