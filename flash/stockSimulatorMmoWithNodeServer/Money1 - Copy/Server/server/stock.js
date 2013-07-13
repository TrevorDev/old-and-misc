var stock = require('./stock.js');
var ending =["Org","Co","Megacorp","Inc", "Group", "Tech", "Firm", "Limited","Partnership", "Enterprise", "Digital"];
var start =["Sky","Tiny","Smart","Crazy","Red","Solid", "Nano", "Strong","Awesome", "Wacky", "Great", "Cool", "Shiny", "Amazing"];
var middle =["Car","Circle","Lightining","Balloon","Knight","Shoes","Planet","Clown","Rocket","Hammer", "Lion","Farm","Web","Hamster","Gold","Computer","Diamonds", "Crunch", "Steel", "Information", "Ideas"];
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
   this.nextName=function (){
   this.name=start[Math.floor(Math.random()*start.length)]+" "+middle[Math.floor(Math.random()*middle.length)]+" "+ending[Math.floor(Math.random()*ending.length)];
   }
	this.nextPrice=function (){
	this.buyPrice=Math.floor(Math.random()*100);
   this.sellPrice=Math.floor(this.buyPrice*0.95);
	this.buys=0;
	this.sells=0;
	}
   this.nextPrice();
   this.nextName();
}

/*exports.StockOwned=function (){
this.id;
this.amount;
}*/

