package 
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;


	public class logedInScreen extends MovieClip
	{


		public function logedInScreen()
		{
			joinServerButton.addEventListener(MouseEvent.CLICK, joinServer_clicked);
		}

		public function joinServer_clicked(event:MouseEvent) {
			//mmogame.main.show_level();
			mmogame.connection.sendUserJoin(0);
			//connect.onReceive(mmogame.main.show_logedIn);
		}
	}

}