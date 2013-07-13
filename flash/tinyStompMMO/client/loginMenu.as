package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class loginMenu extends MovieClip {
		
		var regMenu:registerMenu;
		
		public function loginMenu() {
			buttonGuest.addEventListener(MouseEvent.CLICK, guestConnect );
			regButtonMenu.addEventListener(MouseEvent.CLICK, showRegister);
			loginButton.addEventListener(MouseEvent.CLICK,doLogin);
			quickplay.addEventListener(MouseEvent.CLICK,starter);
		}
		
		function starter(event:MouseEvent) {
			var guestName = "11";
			
			landworld.main.guestConnect(guestName);
			serverHandler.serverHand.inGame = true;
					serverHandler.serverHand.inRoom = false;
					serverHandler.serverHand.mainMenu.show_level_one();	
		}
		
		function showRegister(event:MouseEvent) {
			regMenu = new registerMenu();
			addChild(regMenu);
		}
		
		function removeRegister()
		{
			regMenu.removeMe();
			removeChild(regMenu);
			regMenu = null;
		}
		
		function doLogin(event:MouseEvent)
		{
			usernameInput.borderColor = 0x000000;
			passwordInput.borderColor = 0x000000;
			var username = usernameInput.text;
			if(username == "")
			{
				usernameInput.borderColor = 0xFF0000;
				return;
			}
			var thePassword = passwordInput.text;
			if(thePassword == "")
			{
				passwordInput.borderColor = 0xFF0000;
				return;
			}
			landworld.main.simpleConnect(username,thePassword);
		}
		
		function guestConnect(event:MouseEvent)
		{
			var guestName = guestInput.text;
			if(guestName == "")
			{
				guestName = "Guest-" + (Math.floor(10000 + (Math.random() * (99999 - 10000 + 1))));
			}
			else
			{
				guestName = "Guest-" + guestInput.text;
			}
			landworld.main.guestConnect(guestName);
		}
	}
	
}
