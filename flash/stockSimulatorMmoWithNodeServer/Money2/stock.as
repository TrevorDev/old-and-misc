package  {
	
	public class stock {
public var stockId=0;
public var stockName="";
public var buyPrice=0;
public var sellPrice=0;
public var hist:Array = new Array();

		public function stock(id, stockName, buyPrice, sellPrice, hist) {
			this.stockId=Number(id);
			this.stockName=stockName;
			this.buyPrice=Number(buyPrice);
			this.sellPrice=Number(sellPrice);
			var split=hist.split(",");
			for(var i=0;i<split.length; i++){
				this.hist.push(Number(split[i]));
			}
			
		}

	}
	
}
