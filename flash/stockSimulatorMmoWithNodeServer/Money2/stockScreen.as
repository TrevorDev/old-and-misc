package 
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;


	public class stockScreen extends MovieClip
	{

		public static var stocksDisplayed:Array = new Array();
		public static var page = 0;

		public function stockScreen()
		{
			page = 0;
			stocksDisplayed = new Array();

			leftMore.addEventListener(MouseEvent.CLICK, leftClicked);
			rightMore.addEventListener(MouseEvent.CLICK, rightClicked);
			backB.addEventListener(MouseEvent.CLICK, backClicked);

			for (var i=0; i<4; i++)
			{
				var stockShown = new stockDisplay();
				stockShown.width = stockShown.width / 2.5;
				stockShown.height = stockShown.height / 2.5;
				var wSpace = (money.main.width-2*stockShown.width)/3;
				if (i%2==0)
				{
					stockShown.x = wSpace;
				}
				else
				{
					stockShown.x = 2 * wSpace + stockShown.width;
				}
				if (i>=2)
				{
					stockShown.y = 40 + stockShown.height;
				}
				else
				{
					stockShown.y = 35;
				}
				this.addChild(stockShown);
				stocksDisplayed.push(stockShown);
				stockShown.buy.addEventListener(MouseEvent.CLICK, stockShown.buyClicked);
				stockShown.sell.addEventListener(MouseEvent.CLICK, stockShown.sellClicked);
			}
			setPage(page);
		}
		public function backClicked(event:MouseEvent)
		{
			money.main.show_logedIn();
		}
		public function rightClicked(event:MouseEvent)
		{
			page = page + 1;
			if (page>=money.stocks.length/4)
			{
				page = 0;
			}
			setPage(page);
		}
		public function leftClicked(event:MouseEvent)
		{
			page = page - 1;
			if (page<0)
			{
				page = money.stocks.length / 4 - 1;
			}
			setPage(page);
		}
		public static function setPage(pageNum)
		{
			for (var i=0; i<4; i++)
			{

				stocksDisplayed[i].sellText.text = String(money.stocks[pageNum * 4 + i].sellPrice);
				stocksDisplayed[i].buyText.text = String(money.stocks[pageNum * 4 + i].buyPrice);
				stocksDisplayed[i].nameText.text = String(money.stocks[pageNum * 4 + i].stockName);
				stocksDisplayed[i].sId=money.stocks[pageNum * 4 + i].stockId;
			}

		}

	}

}