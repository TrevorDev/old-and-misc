package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class newAccScreen extends MovieClip {
		
		
		public function newAccScreen() {
			backButton.addEventListener(MouseEvent.CLICK, backButton_clicked);
			createButton.addEventListener(MouseEvent.CLICK, createButton_clicked);
		}
		
		public function createButton_clicked(event:MouseEvent) {
			mmogame.connection.sendNewAccount(usrName.text, pw.text, email.text);
		}
		
		public function backButton_clicked(event:MouseEvent) {
			mmogame.main.show_login();
		}
	}
	
}
