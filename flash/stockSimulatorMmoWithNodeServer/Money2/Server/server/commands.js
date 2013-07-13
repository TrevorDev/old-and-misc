var account = require('./account.js');
var commands = require('./commands.js');
var net = require('net');

exports.commandHandle=function (cNum, user, hashMap, data, stocks){
	switch(cNum)
	{
	//creating account
	case 1:
		var splitUsrPass=data.toString(0).split("|");
		var userName=splitUsrPass[0];
		var pass=splitUsrPass[1];
		var email=splitUsrPass[2];
		if(account.hashNameTaken(userName, hashMap)){
			commands.sendAccountNotMade(user);
		}else{
			commands.sendAccountMade(user);
			console.log("Account Created:"+userName+" "+pass+" "+email);
			account.hashAdd(new account.Account(userName, pass, email), hashMap);
		}
		break;
		//loging in
	case 2:
		var splitUsrPass=data.toString(0).split("|");
		var userName=splitUsrPass[0];
		var pass=splitUsrPass[1];
		var foundAcc=account.checkPasswordValid(userName, pass, hashMap);
		if(!foundAcc.equals(account.blankAcc)){
			user.account=foundAcc;
			console.log("worked");
			commands.sendAccountInfo(user);
		}else{
		commands.sendAccountNotFound(user);
		}
		break;
	case 3:
	commands.sendAvailibleStocks(user, stocks);
		break;
      case 4:
      var stockId=commands.getNextInt(data);
      data=data.slice(4);
      var amount=commands.getNextInt(data);
      data=data.slice(4);
	commands.buyStock(user, stocks, stockId, amount);
		break;
      case 5:
      
	var stockId=commands.getNextInt(data);
   data=data.slice(4);
      var amount=commands.getNextInt(data);
      data=data.slice(4);
	commands.sellStock(user, stocks,stockId, amount);
		break;
	default:

	}
}


exports.getCommandNum=function (buff){
	var cNum=0;
	for (var i=0;i<4;i++){
		cNum += buff.slice(3-i,4).readUInt8(0, 'big')*Math.pow(256,i);
	}

	return cNum;
}

exports.getNextInt=function (buff){
	var cNum=0;
	for (var i=0;i<4;i++){
		cNum += buff.slice(3-i,4).readUInt8(0, 'big')*Math.pow(256,i);
	}
	return cNum;
}


exports.buyStock=function (user, stocks, stockId, amount){
   if(!user.account.stocks[stockId]){
   user.account.stocks[stockId]=0;
   }
   if(stocks[stockId].buyPrice<=user.account.gameMoney){
   user.account.stocks[stockId]+=amount;
   user.account.gameMoney-=stocks[stockId].buyPrice*amount;
   }
   console.log(user.account.stocks);
	
}

exports.sellStock=function (user, stocks, stockId, amount){
if(!user.account.stocks[stockId]||user.account.stocks[stockId]==0){
}else{
if(user.account.stocks[stockId]>0){
   user.account.stocks[stockId]-=amount;
   user.account.gameMoney+=amount*stocks[stockId].sellPrice;
   }

}
console.log(user.account.stocks);
}


exports.sendAccountMade=function (user){
	commands.sendClientPacket(user, 1);
}

exports.sendAccountNotMade=function (user){
	commands.sendClientPacket(user, 2);
}

exports.sendAccountNotFound=function (user){
	commands.sendClientPacket(user, 3);
}

exports.sendAccountInfo=function (user){
	commands.sendClientPacket(user, 4, user.account.gameMoney.toString());
}

exports.sendAvailibleStocks=function (user, stocks){
var sendStr="";
for(var i =0;i<stocks.length;i++){
sendStr+=stocks[i].id.toString()+"/"+stocks[i].name+"/"+stocks[i].buyPrice.toString()+"/"+stocks[i].sellPrice.toString()+"/";
for(var j=0;j<stocks[i].hist.length;j++){
sendStr+=stocks[i].hist[j].toString();
if(j!=stocks[i].hist.length-1){
sendStr+=",";
}
}
if(i!=stocks.length-1){
sendStr+="|";
}

}
	commands.sendClientPacket(user, 5, sendStr);
}

exports.sendClientPacket=function (user, command, param){
	if(param==null)param = "";
	var send = new Buffer(param.length+4);
	send.writeUInt32BE(command, 0);
	send.write(param, 4);
	user.socket.write(send, 'ascii');
}