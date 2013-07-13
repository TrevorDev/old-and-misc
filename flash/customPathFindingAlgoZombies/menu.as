package 
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;


	public class menu extends MovieClip
	{


		public function menu()
		{
			start_button.addEventListener(MouseEvent.CLICK, start_button_clicked);
		}
		public function start_button_clicked(event:MouseEvent)
		{
			zombiecash.main.show_game();
		}
	}

}