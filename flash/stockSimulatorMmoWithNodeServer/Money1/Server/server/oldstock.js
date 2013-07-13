var stock = require('./stock.js');
exports.Stock=function (stocks, id, buyPrice, sellPrice, str, jumpSize){
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
	if(str==null)str = 25+Math.floor(Math.random()*60);
	if(jumpSize==null)jumpSize = 10+Math.floor(Math.random()*90);
	
	this.buyPrice=buyPrice;
	this.sellPrice=sellPrice;
	this.id=id;
	this.str=str;
	this.hist=[];
	
	this.nextPrice=function (){
		this.hist[this.hist.length]=this.buyPrice;
		var chance=Math.floor(Math.random()*100);
		var jump=Math.floor(Math.random()*jumpSize);
		if(chance<=this.str){
			this.buyPrice=this.buyPrice+jump;
		}else{
			this.buyPrice=this.buyPrice-jump;
		}
		this.sellPrice=this.buyPrice-5;
	}
}

