package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.events.MouseEvent;
	import flash.system.Security;

	public class money extends MovieClip
	{
		public static var connection;
		public static var main;
		
		public static var gameMoney=0;
		public static var stocks:Array = new Array();
		
		public var login_screen:loginScreen;
		public var acc_screen:newAccScreen;
		public var logedIn_screen:logedInScreen;
		public function money()
		{
			main=this;
			connection= new connect();
			show_login();
		}

		public function removeAllScreens()
		{
			remove_newAccScreen();
			remove_login();
			remove_logedIn();
		}

		public function show_login()
		{
			login_screen = new loginScreen();
			money.main.removeAllScreens();
			money.main.addChildAt(login_screen, 0);
		}
		
		public function show_accCreate()
		{
			acc_screen = new newAccScreen();
			money.main.removeAllScreens();
			money.main.addChildAt(acc_screen, 0);
		}
		
		public function show_logedIn()
		{
			logedIn_screen = new logedInScreen();
			money.main.removeAllScreens();
			money.main.addChildAt(logedIn_screen, 0);
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


	}

}