package  {
	
	import flash.display.MovieClip;
	
	public class lobby_message extends MovieClip {

		
		public function lobby_message(msg:String,button:String) {
			this.msgtext.text = msg;
			this.buttonTxt.text = button;
		}
	}
	
}
