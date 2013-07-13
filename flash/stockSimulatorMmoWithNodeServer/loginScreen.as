package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class loginScreen extends MovieClip {
		var texter:TextField;
		
		public function loginScreen() {
			loginButton.addEventListener(MouseEvent.CLICK, loginButton_clicked);
			newAccButton.addEventListener(MouseEvent.CLICK, newAccButton_clicked);
		}
		public function loginButton_clicked(event:MouseEvent) {
			money.connection.sendUserLogin(usrName.text, pw.text);
		}
		
		public function newAccButton_clicked(event:MouseEvent) {
			money.main.show_accCreate();
		}
		
		
		
	}
	
}
