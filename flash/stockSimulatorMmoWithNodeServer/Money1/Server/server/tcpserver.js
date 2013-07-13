var commands = require('./commands.js');
var account = require('./account.js');
var stock = require('./stock.js');
var net = require('net');
var readline = require('readline'),rl = readline.createInterface(process.stdin, process.stdout);

//array of all users and data
var hashMap=[];
account.createHash(hashMap);

//array of all active users socket and active account
var usrs = [];

//array of all active stocks
var totalStocks=20;
var stocks = [];
createStocks(stocks);

console.log(account.getServerTime());
//loadAccounts
load();

//function on when client connects
var server = net.createServer(function (socket) {
	sendPolicy(socket);	
	
	console.log("new connection");
	socket.usr=new account.User(socket);
	usrs.push(socket.usr);
	
	//function on receiving data event
	socket.on('data', function(usrData){
		//check packet is size of int
		if(usrData.length>=4){
			var cNum = commands.getCommandNum(usrData);
			usrData=usrData.slice(4);
			commands.commandHandle(cNum, socket.usr, hashMap,usrData, stocks);
		}
	});	
	//when client closes app
	socket.on('end', function(){
		console.log("exit");
		var i=usrs.indexOf(socket.usr);
		usrs.splice(i,1);
	});
});
server.listen(843, "192.168.4.103");



function createStocks(stocks){
	for(var i=0;i<totalStocks;i++){
	stocks[i]=new stock.Stock(stocks);
	}
}



//Server's user Interface

rl.on('line', function (cmdAndParam) {
	splitInfo=cmdAndParam.split(" ");
	cmd=splitInfo[0];
	param=splitInfo[1];
	switch(cmd)
	{
	//Saving to file
	case "save":
		if(!param){
			param="accounts.txt";
		}
		var fs = require('fs');
		var stream = fs.createWriteStream(param);
		stream.once('open', function(fd) {
			for(var i=0;i<hashMap.length;i++){
				if(hashMap[i].account!=account.blankAcc){
					var temp=hashMap[i];
					do{
						stream.write(temp.account.userName+"|||"+temp.account.password+"|||"+temp.account.email+"|||"+temp.account.gameMoney+"\n");
						temp=temp.nextLink;
					}while(temp);
				}
			}
		});
		break;
		// Loading from file
	case "load":
load(param);
		break;
	default:
		console.log('invalid command');
	}
});

function load(param){
		if(!param){
			param="accounts.txt";
		}
		var fs = require('fs');
fs.readFile(param, 'ascii', function(err,data){
  if(err) {
    console.error("Could not open file: %s", err);
  }else{
  allAccount=data.split("\n");
  for(var i=0;i<allAccount.length-1;i++){
  item=allAccount[i].split("|||");
  newAcc=new account.Account(item[0], item[1], item[2]);
  newAcc.setGameMoney(parseInt(item[3]));
  account.hashAdd(newAcc, hashMap);
  }
  }
});
}

rl.on('close', function() {
	console.log('goodbye!');
	process.exit(0);
});

//send to flash to accept connections
function sendPolicy(socket){
	var fs = require('fs');
	socket.write("<?xml version=\"1.0\"?><cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"843\" /></cross-domain-policy>\0", 'utf8');
}