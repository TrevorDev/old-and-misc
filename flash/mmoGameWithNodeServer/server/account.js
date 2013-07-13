var account = require('./account.js');
var totalHash=400;



exports.User=function (socket, acc){
	this.account;
	this.socket = socket;
	this.room=-1;
	this.roomNode=null;
	this.posX=5;
	this.posY=0;
	this.spdX=0;
	this.spdY=10;
	
	this.updatePos=function (posX, posY, spdX, spdY){
	this.posX=posX;
	this.posY=posY;
	this.spdX=spdX;
	this.spdY=spdY;
	}
	
}



exports.hashLink=function (acc, nxt){
	this.account=acc;
	this.nextLink;
}

exports.Account=function (usr, pass, email){
	this.userName = usr;
	this.password = pass;
	this.email = email;
	this.gameMoney = 1000;
	this.lastLogedIn=account.getServerTime();
	
	this.setGameMoney=function (gameMoney){
		this.gameMoney=gameMoney;
	}
	
	this.addGameMoney=function (amount){
		this.gameMoney+=amount;
	}
	
	this.equals=function (acc){
		if(acc.userName==this.userName){
			return true;
		}else{
			return false;
		}
	}
}

exports.hashAdd=function (acc, hashMap){
	var num = account.getHashNum(acc.userName);
	temp=hashMap[num];
	if(temp.account==account.blankAcc){
		temp.account=acc;
	}else{
		
		while(temp.nextLink){
			temp=temp.nextLink;
		}
		temp.nextLink=new account.hashLink(account.blankAcc);
		temp.nextLink.account=acc;
		
	}
	
}

exports.getHashNum=function (userName){
	var num = 0;
	var len = 10;
	if(userName.length<len){
		len=userName.length;
	}
	for (var i=0;i<len;i++){
		num+=(userName[i].charCodeAt(0)-31)*Math.pow(90, i);
	}
	num=num%totalHash;
	return num;
}

exports.createHash=function (hashMap){
	for(var i=0;i<totalHash;i++){
		hashMap[i]=new account.hashLink(account.blankAcc);
	}
}

exports.hashNameTaken=function (userName, hashMap){
	var num = account.getHashNum(userName);
	if(hashMap[num].account.equals(account.blankAcc)){
		return false;
	}else{
		var temp = hashMap[num];
		if(temp.account.userName==userName){
			return true;
		}
		while(temp.nextLink){
			temp=temp.nextLink;
			if(temp.account.userName==userName){
				return true;
			}
		}
		return false;
	}
}

exports.checkPasswordValid=function (userName, password, hashMap){
	var num = account.getHashNum(userName);
	if(hashMap[num].account.equals(account.blankAcc)){
		return account.blankAcc;
	}else{
		var temp = hashMap[num];
		if(temp.account.userName==userName&&temp.account.password==password){
			return temp.account;
		}
		while(temp.nextLink){
			temp=temp.nextLink;
			if(temp.account.userName==userName&&temp.account.password==password){
				return temp.account;
			}
		}
		return account.blankAcc;
	}
}

exports.getServerTime =function (){
var yourDateTime = new Date();
var estDateTime = new Date(yourDateTime.getTime()-yourDateTime.getTimezoneOffset()*60*1000);
return estDateTime;
}

exports.blankAcc = new account.Account("|","|","|");