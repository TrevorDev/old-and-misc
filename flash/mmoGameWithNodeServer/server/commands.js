var account = require('./account.js');
var commands = require('./commands.js');
var room = require('./room.js');
var net = require('net');

exports.commandHandle=function (cNum, user, hashMap, data, rooms){
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
		
		//join room
	case 3:
		var roomNum=commands.getNextUInt(data);
		var names = rooms[roomNum].getNames();
		var name = user.account.userName;
		rooms[roomNum].playerJoinAlert(name);
		room.addPlayer(rooms, roomNum, user);		
		commands.sendRoomEntered(user, names);
		//data=data.slice(4);
		break;
		
		//update pos and spd
	case 4:
		var posX=commands.getNextInt(data);
		data=data.slice(4);
		var posY=commands.getNextInt(data);
		data=data.slice(4);
		var spdX=commands.getNextInt(data);
		data=data.slice(4);
		var spdY=commands.getNextInt(data);
		data=data.slice(4);
		user.updatePos(posX, posY, spdX, spdY);
		break;
		
	default:

	}
}


exports.getCommandNum=function (buff){
	var cNum=0;
	cNum += buff.slice(0,4).readUInt32BE(0, 'big');
	return cNum;
}

exports.getNextUInt=function (buff){
	var cNum=0;
		cNum += buff.slice(0,4).readUInt32BE(0, 'big');
	return cNum;
}

exports.getNextInt=function (buff){
	var cNum=0;
		cNum += buff.slice(0,4).readInt32BE(0, 'big');
	return cNum;
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

exports.sendRoomEntered=function (user, names){
	commands.sendClientPacket(user, 5, names.toString());
}

exports.sendPlayerCo=function (user, arrayI, posAr,rooms){
	commands.sendClientCoPacket(user, 6, posAr, arrayI,rooms);
}


exports.sendConnectedName=function (user, name){
	commands.sendClientPacket(user, 7, name.toString());
}

exports.sendRemovePlayer=function (user, nameExit){
	commands.sendClientPacket(user, 8, nameExit);
}

exports.sendClientPacket=function (user, command, param){
	if(param==null)param = "";
	var send = new Buffer(param.length+4);
	send.writeUInt32BE(command, 0);
	send.write(param, 4);
	user.socket.write(send, 'ascii');
}

exports.sendClientCoPacket=function (user, command, posAr, arrayI,rooms){
	var bytesWritten=0;
	//length of array * 4bytes per + 4bytes for cmd + 4 bytes for length - 4 ints for self
	//console.log(posAr);
	var send = new Buffer(posAr.length*4+4+4-(4*4));
	send.writeUInt32BE(command, bytesWritten);
	bytesWritten+=4;
	send.writeInt32BE(posAr.length, bytesWritten);
	bytesWritten+=4;
	for(var i=0;i<posAr.length;i++){
		if(i!=arrayI*4&&i!=arrayI*4+1&&i!=arrayI*4+2&&i!=arrayI*4+3){
			send.writeInt32BE(posAr[i], bytesWritten);
			bytesWritten+=4;
		}
	}
	try{
	user.socket.write(send, 'ascii');
	}catch(err){
	room.removePlayer(rooms, user.room, user);
	console.log("worked2");
	}
	
}