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
			stockButton.addEventListener(MouseEvent.CLICK, stockButton_clicked);
			storeButton.addEventListener(MouseEvent.CLICK, storeButton_clicked);
		}

		public function stockButton_clicked(event:MouseEvent)
		{
			money.connection.requestStockInfo();

			connect.onReceive(money.main.show_stock);


		}

		public function storeButton_clicked(event:MouseEvent)
		{
			money.main.show_accCreate();
		}
	}

}