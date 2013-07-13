package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class registerMenu extends MovieClip {
		
		
		public function registerMenu() {
			cancelButton.addEventListener(MouseEvent.CLICK, cancelReg);
			regButton.addEventListener(MouseEvent.CLICK, registerME);
		}
		
		function registerME(event:MouseEvent)
		{
			var username, thePassword, email;
			usernameReg.borderColor = 0x000000;
			passwordReg.borderColor = 0x000000;
			if(usernameReg.text == "")
			{
				usernameReg.borderColor = 0xFF0000;
				return;
			}
			else
			{
				username = usernameReg.text;
			}
			if(passwordReg.text == "")
			{
				passwordReg.borderColor = 0xFF0000;
				return;
			}
			else
			{
				thePassword = passwordReg.text;
			}
			email = emailReg.text;
			
			landworld.main.registerConnect(username,thePassword,email);
		}
		
		function cancelReg(event:MouseEvent)
		{
			(parent as loginMenu).removeRegister();
		}
		
		public function removeMe()
		{
			cancelButton.removeEventListener(MouseEvent.CLICK, cancelReg);
			regButton.removeEventListener(MouseEvent.CLICK, registerME);
		}
	}
	
}
