var room = require('./room.js');
var account = require('./account.js');
var commands = require('./commands.js');

exports.Room=function (){
	this.players=0;
	this.nextUsr=null;
	this.prevUsr=null;

	this.playerJoinAlert=function (name){
	var temp=this.nextUsr;
	while(temp!=null){			
			commands.sendConnectedName(temp.user, name);
			temp=temp.nextUsr;
		}
	}
	
	
	this.getNames=function (){
		var str="";
		var temp=this.nextUsr;
		while(temp!=null){			
			str=str+temp.user.account.userName+" ";
			temp=temp.nextUsr;
		}
		if(str.length>0){
		str=str.substring(0,str.length-1);
		}
		return str;
	}

}

exports.usrInRoom=function (){
this.user;
this.nextUsr=null;
this.prevUsr=null;
}
//fix so inside
exports.addPlayer=function (rooms, roomNum, user){
	user.room=roomNum;
	user.roomNode=new room.usrInRoom();
	user.roomNode.user=user;
	user.roomNode.nextUsr=rooms[roomNum].nextUsr;
	if(user.roomNode.nextUsr!=null){
	user.roomNode.nextUsr.prevUsr=user.roomNode;
	}
	user.roomNode.prevUsr=rooms[roomNum];
	rooms[roomNum].nextUsr=user.roomNode;
	rooms[roomNum].players++;
}

exports.removePlayer=function (rooms, roomNum, user){
	if(user.room!=-1){
		user.room=-1;
		if(user.roomNode.nextUsr!=null){
		user.roomNode.nextUsr.prevUsr=user.roomNode.prevUsr;
		}
		user.roomNode.prevUsr.nextUsr=user.roomNode.nextUsr;
		user.roomNode=null;
		rooms[roomNum].players--;
		console.log("quit");
		
		temp=rooms[roomNum].nextUsr;
		while(temp!=null){
			if(temp.user!=null){
				commands.sendRemovePlayer(temp.user, user.account.userName);
			}
			temp=temp.nextUsr;
		}
		
	}
}

exports.sendRooms=function (rooms){
	
	for(var i=0;i<rooms.length;i++){
	var pos=[];
	var temp=rooms[i].nextUsr;
	var j=0;
	while(temp!=null){
	pos[j*4]=temp.user.posX;
	pos[j*4+1]=temp.user.posY;
	pos[j*4+2]=temp.user.spdX;
	pos[j*4+3]=temp.user.spdY;
	temp=temp.nextUsr;
	j++;
	}
	
	j=0;
	temp=rooms[i].nextUsr;
	while(temp!=null){
	if(temp.user!=null){
	commands.sendPlayerCo(temp.user, j, pos, rooms);
	}
	temp=temp.nextUsr;
	j++;
	}

	}
}