package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.events.MouseEvent;
	import flash.system.Security;
	
	
	public class mmogame extends MovieClip {
		public static var connection;
		public static var main;
		
		public var left,right,up,down,enterKey,attack = false,fFive:Boolean = false, escKey = false, one, two, three;
		
		public static var gameMoney=0;
		
		public var login_screen:loginScreen;
		public var acc_screen:newAccScreen;
		public var logedIn_screen:logedInScreen;
		public var level_screen:levelScreen;
		public function mmogame() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			
			
			main=this;
			connection= new connect();
			show_login();
		}
		
		
		
		
		public function removeAllScreens()
		{
			remove_newAccScreen();
			remove_login();
			remove_logedIn();
			remove_level();
			
		}
//ADDING CLIPS=============================================
		public function show_login()
		{
			login_screen = new loginScreen();
			mmogame.main.removeAllScreens();
			mmogame.main.addChildAt(login_screen, 0);
		}
		
		public function show_accCreate()
		{
			acc_screen = new newAccScreen();
			mmogame.main.removeAllScreens();
			mmogame.main.addChildAt(acc_screen, 0);
		}
		
		public function show_logedIn()
		{
			logedIn_screen = new logedInScreen();
			mmogame.main.removeAllScreens();
			mmogame.main.addChildAt(logedIn_screen, 0);
		}
		
		
		public function show_level()
		{
			level_screen = new levelScreen();
			mmogame.main.removeAllScreens();
			mmogame.main.addChildAt(level_screen, 0);
		}
//REMOVING CLIPS=============================================
		public function remove_level()
		{
			if (level_screen)
			{
				if (main.contains(level_screen))
				{
					removeChild(level_screen);
					level_screen = null;
				}
			}
		}
		
		public function remove_logedIn()
		{
			if (logedIn_screen)
			{
				if (main.contains(logedIn_screen))
				{
					removeChild(logedIn_screen);
					logedIn_screen = null;
				}
			}
		}


		public function remove_login()
		{
			if (login_screen)
			{
				if (main.contains(login_screen))
				{

					login_screen.removeEventListener(MouseEvent.CLICK, login_screen.loginButton_clicked);
					login_screen.removeEventListener(MouseEvent.CLICK, login_screen.newAccButton_clicked);
					removeChild(login_screen);
					login_screen = null;
				}
			}
		}
		
		public function remove_newAccScreen()
		{
			if (acc_screen)
			{
				if (main.contains(acc_screen))
				{

					acc_screen.removeEventListener(MouseEvent.CLICK, acc_screen.backButton_clicked);
					acc_screen.removeEventListener(MouseEvent.CLICK, acc_screen.createButton_clicked);
					removeChild(acc_screen);
					acc_screen = null;
				}
			}
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
