package  {
	
		import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class stockDisplay extends MovieClip {
		
		public var sId;
		public function stockDisplay() {
			// constructor code
		}
		public function sellClicked(event:MouseEvent)
		{
			money.connection.requestSellStock(this.sId, 1);
		}
		public function buyClicked(event:MouseEvent)
		{
			money.connection.requestBuyStock(this.sId, 1);
		}
	}
	
}
