package 
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	public class begin extends MovieClip
	{
		public var main_class:landworld;

		public function begin(passed_class:landworld)
		{
			main_class = passed_class;
			start_button.addEventListener(MouseEvent.CLICK, start_button_clicked);
		}
		public function start_button_clicked(event:MouseEvent) {
			main_class.show_login();
		}
	}

}