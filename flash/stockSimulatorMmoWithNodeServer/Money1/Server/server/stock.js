var stock = require('./stock.js');
exports.Stock=function (stocks, id, buyPrice, sellPrice){
	if(id==null){
		id=0;
		do{
		var found=true;
		for(var i=0;i<stocks.length;i++){
		if(id==stocks[i].id){
		found=false;
		id++;
		break;
		}
		}
		}while(found==false);
	}
	if(buyPrice==null)buyPrice = 100;
	if(sellPrice==null)sellPrice = 95;

	
	this.buyPrice=buyPrice;
	this.sellPrice=sellPrice;
	this.id=id;
	this.hist=[];
	this.hist[0]=1;
	this.hist[1]=5;
	this.buys=0;
	this.sells=0;
	this.name="super stock";
	this.nextPrice=function (){
	
	this.buys=0;
	this.sells=0;
	}
}

exports.StockOwned=function (){
this.id;
this.amount;
}

