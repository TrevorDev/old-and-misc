package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.events.Event;
	import playerio.*;
	import serverHandler;
	import flash.display.IBitmapDrawable;
	
	public class lobby extends MovieClip{

		public var connection:serverHandler;
		public var room_maker:room_setup;
		public var inside_room:room;
		public var playerObject:playerInRoom;
		public var lobbyMessage:lobby_message;
		public var makingRoom:Boolean = false;
		public var working:Boolean = false;
		
		public var totalRoomNum:int;
		
		public var displayedRooms:Array = [];
		public var pageNumber:Array = [];
		public var playersInRoom:Array = [];
		
		public function lobby(passed_class:serverHandler) {

			connection = passed_class;
			connection.setLobby(this);
			// load the rooms
			refresh_rooms(null);

			lobby_create_button.addEventListener(MouseEvent.CLICK, room_create_clicked);
			lobby_refresh_button.addEventListener(MouseEvent.CLICK, refresh_rooms);
			storeBtn.addEventListener(MouseEvent.CLICK, showStore);
		}
		
		public function refresh_rooms(event:MouseEvent)
		{
			total_room_counter.text = "Refreshing...";
			// find the total number of rooms
			connection.theClient.multiplayer.listRooms("MyGame", {}, 0, 0, function(rooms:Array){
			totalRoomNum = rooms.length;
			total_room_counter.text = "Total Rooms: " + totalRoomNum;
			var pageX = 34.9;
			var pageY = 427.20;
			
			var i:int=1;
			while(i<pageNumber.length)
			{
				pageNumber[i].removeEventListener(MouseEvent.CLICK,show_room_page);
				removeChild(pageNumber[i]);
				pageNumber[i] = null;
				pageNumber.splice(i,1);
			}

			for (var aRoom in displayedRooms)
			{
				displayedRooms[aRoom].removeEventListener(MouseEvent.CLICK,joinRoomMouse);
				removeChild(displayedRooms[aRoom]);
				displayedRooms[aRoom] = null;
				displayedRooms.splice(aRoom,1);
			}
			
			if(totalRoomNum > 8)
			{
				for(i=0;i<totalRoomNum;i+=8)
				{
					trace("i " + i);
					trace("i convertd " + ((i+8)/8));
					var pageCounter:page_number = new page_number;
					pageCounter.x = pageX;
					pageCounter.y = pageY;
					pageCounter.page_num.text = ((i+8)/8).toString();
					addChild(pageCounter);
					pageNumber.push(pageCounter);
					pageX += 41.7;
					pageCounter.addEventListener(MouseEvent.CLICK, show_room_page);
				}
			}
				}, function(e:PlayerIOError){
			   trace("Unable to list rooms", e)
			})

			connection.theClient.multiplayer.listRooms("MyGame", {}, 8, 0, function(rooms:Array){
			var roomX = 154.35;
			var roomY = 60.35;

   			for( var a:int=0;a<rooms.length;a++)
			{
				if(a > 3)
				{
					roomX = 428.45;
				}
				if(a == 4)
					roomY = 60.35;
				var room:lobby_room_button = new lobby_room_button;
				room.x = roomX;
				room.y = roomY;
				room.roomName.text = rooms[a].id;
				if(rooms[a].data.inProgress == "1")
					room.roomStatus.text = "In Progress";
				room.player_info.text = rooms[a].onlineUsers + "/" + rooms[a].data.maxPlayers;
				room.addEventListener(MouseEvent.CLICK,joinRoomMouse);
				addChild(room);
				displayedRooms.push(room);
				roomY = roomY + 90;
    		  	//Trace out returned rooms
    		  	trace(rooms[a])
    		  	//Trace out online users in room
    		  	trace(rooms[a].onlineUsers)
			  	trace(rooms[a].data.map)
			}
			}, function(e:PlayerIOError){
			   trace("Unable to list rooms", e)
			})
		}

		public function show_room_page(event:MouseEvent)
		{
			var i:int=1;
			while(i<displayedRooms.length)
			{
				displayedRooms[i].removeEventListener(MouseEvent.CLICK,joinRoomMouse);
				removeChild(displayedRooms[i]);
				displayedRooms[i] = null;
				displayedRooms.splice(i,1);
			}
			//loop through displayedRooms and remove them.
			var offset:int = event.target.text;
			offset = (offset - 1) * 8;
			trace("offset: " + offset);
			connection.theClient.multiplayer.listRooms("MyGame", {}, 8, offset, function(rooms:Array){
			var roomX = 154.35;
			var roomY = 60.35;

   			for( var a:int=0;a<rooms.length;a++)
			{
				if(a > 3)
				{
					roomX = 428.45;
				}
				if(a == 4)
					roomY = 60.35;
				var room:lobby_room_button = new lobby_room_button;
				room.x = roomX;
				room.y = roomY;
				room.roomName.text = rooms[a].id;
				room.player_info.text = rooms[a].onlineUsers + "/" + rooms[a].data.maxPlayers;
				room.addEventListener(MouseEvent.CLICK,joinRoomMouse);
				addChild(room);
				displayedRooms.push(room);
				roomY = roomY + 90;
    		  	//Trace out returned rooms
    		  	//trace(rooms[a])
    		  	//Trace out online users in room
    		  	trace(rooms[a].onlineUsers)
			  	trace(rooms[a].data.map)
			}
			}, function(e:PlayerIOError){
			   trace("Unable to list rooms", e)
			})
		}

		public function room_create_clicked(event:MouseEvent) {
			if(makingRoom == false)
			{
				makingRoom = true;
				room_maker = new room_setup();
				room_maker.x = width/2;
				room_maker.y = height/2;
				addChild(room_maker);
				room_maker.make_room.addEventListener(MouseEvent.CLICK, createJoinRoom);
				room_maker.stop_room.addEventListener(MouseEvent.CLICK, done_making_room);
			}
		}
		
		public function done_making_room(event:MouseEvent)
		{
			makingRoom = false;
			room_maker.make_room.removeEventListener(MouseEvent.CLICK, createJoinRoom);
			room_maker.stop_room.removeEventListener(MouseEvent.CLICK, done_making_room);
			if(contains(room_maker))
				removeChild(room_maker);
		}
		
		public function createJoinRoom(event:MouseEvent)
		{
			var myRoomName = room_maker.myRoomName.text;
			trace(myRoomName);
			done_making_room(null);
			//create a room with roomName with a map id of '1'
			connection.theClient.multiplayer.createRoom(myRoomName, "MyGame",true, {map:1,inProgress:"0",maxPlayers:4},joinRoom,function(error){trace(error)});
		}
		
		public function joinRoomMouse(event:MouseEvent)
		{
			var myRoomName = event.target.text;
			joinRoom(myRoomName);
		}
		
		public function joinRoom(myRoomName:String)
		{
			if(!working)
			{
				working = true;
				connection.theClient.multiplayer.joinRoom(myRoomName, {},connection.handleJoin,function(error){trace(error); working = false});
				inside_room = new room();
				inside_room.theRoomName.text = myRoomName;
			}
		}
		
		public function showInsideRoom()
		{
			addChild(inside_room);
			inside_room.room_leave_button.addEventListener(MouseEvent.CLICK, removeJoinedRoomWindow);
			inside_room.room_ready_button.addEventListener(MouseEvent.CLICK,function(){connection.connection.send("ready",connection.myId)});
			inside_room.room_sendChat_button.addEventListener(MouseEvent.CLICK,sendChat);
			inside_room.addEventListener(Event.ENTER_FRAME, keyInput);
			working = false;
		}

		public function addPlayer(playerName:String, playerId:int)
		{
			playerObject = new playerInRoom();
			playerObject.Id = playerId;
			playerObject.playerName.text = playerName;
			playerObject.x = 38;
			playerObject.y = 33+(25 * playersInRoom.length);
			
			addChild(playerObject);
			playersInRoom.push(playerObject);
		}
		
		public function playerReady(playerId:int)
		{
			for(var i:int = 0; i<playersInRoom.length; i++)
			{
				if(playersInRoom[i].Id == playerId)
				{
					playersInRoom[i].playerReady.text = "Y";
				}
			}
		}
		
		public function playerOwner(playerId:int)
		{
			for(var i:int = 0; i<playersInRoom.length; i++)
			{
				if(playersInRoom[i].Id == playerId)
				{
					playersInRoom[i].playerReady.text = "H";
				}
			}
		}
		
		public function removePlayer(playerId:int)
		{
			// loop through all the players
			for(var i:int = 0; i<playersInRoom.length; i++)
			{
				if(playersInRoom[i].Id == playerId)
				{
					removeChild(playersInRoom[i]);
					playersInRoom[i] = null;
					playersInRoom.splice(i,1);
				}
			}
			// line all the players up properly
			for(i = 0; i<playersInRoom.length; i++)
			{
				playersInRoom[i].y = 33+(25 * i);
			}
			working = false;
		}
		
		public function removeAllPlayers()
		{
			var i:int=0;
			while(i<playersInRoom.length)
			{
				removeChild(playersInRoom[i]);
				playersInRoom[i] = null;
				playersInRoom.splice(i,1);
			}
		}
		
		public function sendChat(event:MouseEvent)
		{
			if(inside_room.sendChat.text != "")
			{
				connection.sendChat(inside_room.sendChat.text);
				inside_room.sendChat.text = "";
			}
		}
		
		public function keyInput(event:Event)
		{
			if(landworld(root).enterKey){
				sendChat(null);
			}
			if(landworld(root).fFive){
				connection.connection.send("ready",connection.myId);
			}
		}

		public function removeJoinedRoomWindow(event:MouseEvent)
		{
			connection.connection.disconnect();
			removeAllPlayers();
			removeChild(inside_room);
			inside_room.room_leave_button.removeEventListener(MouseEvent.CLICK, removeJoinedRoomWindow);
			inside_room.room_ready_button.removeEventListener(MouseEvent.CLICK,function(){});
			inside_room.room_sendChat_button.removeEventListener(MouseEvent.CLICK,sendChat);
			inside_room.removeEventListener(Event.ENTER_FRAME, keyInput);
		}
		
		public function gotChat(playerId:int,words:String)
		{
			var currentText:String = inside_room.room_message_box.text;
			if(playerId == -2)
				inside_room.room_message_box.text = currentText + "\nSystem: " + words;6
			for(var i:int = 0; i<playersInRoom.length; i++)
			{
				if(playersInRoom[i].Id == playerId)
				{
					inside_room.room_message_box.text = currentText + "\n" + playersInRoom[i].playerName.text + ": " + words;
				}
			}
			inside_room.scrollerBar.update();
			inside_room.scrollerBar.scrollPosition = 9000;
			inside_room.scrollerBar.visible = true;
			if (inside_room.scrollerBar.enabled == false) {
				inside_room.scrollerBar.alpha = 0;
			} else {
				inside_room.scrollerBar.alpha = 100;
			}
		}
		
		public function showStore(event:MouseEvent)
		{
			remove_all();
			lobby_create_button.removeEventListener(MouseEvent.CLICK, room_create_clicked);
			lobby_refresh_button.removeEventListener(MouseEvent.CLICK, refresh_rooms);
			var storeFront = new store_room;
			storeFront.x = width/2;
			storeFront.y = height/2;
			addChild(storeFront);
		}
		
		public function remove_all()
		{
			// remove the room creation menu
			if(room_maker)
				done_making_room(null);
			// remove the in-room window
			if(inside_room)
			{
				removeChild(inside_room);
				inside_room.room_leave_button.removeEventListener(MouseEvent.CLICK, removeJoinedRoomWindow);
				inside_room.room_ready_button.removeEventListener(MouseEvent.CLICK,function(){});
				inside_room.room_sendChat_button.removeEventListener(MouseEvent.CLICK,sendChat);
				inside_room.removeEventListener(Event.ENTER_FRAME, keyInput);
			}
			// remove the list of displayed rooms
			var i:int=1;
			while(i<displayedRooms.length)
			{
				displayedRooms[i].removeEventListener(MouseEvent.CLICK,joinRoomMouse);
				removeChild(displayedRooms[i]);
				displayedRooms[i] = null;
				displayedRooms.splice(i,1);
			}
			// remove each paged tab
			i = 1;
			while(i<pageNumber.length)
			{
				pageNumber[i].removeEventListener(MouseEvent.CLICK,show_room_page);
				removeChild(pageNumber[i]);
				pageNumber[i] = null;
				pageNumber.splice(i,1);
			}
			// remove all the room player objects
			removeAllPlayers();
		}
		
		public function newMessage(msg:String,button:String)
		{
			removeMessage(null);
			lobbyMessage = new lobby_message(msg,button);
			lobbyMessage.x = width/2;
			lobbyMessage.y = height/2;
			addChild(lobbyMessage);
			lobbyMessage.buttonTxt.addEventListener(MouseEvent.CLICK,removeMessage);
		}
		
		
		public function removeMessage(event:MouseEvent)
		{
			if(lobbyMessage)
			{
				lobbyMessage.removeEventListener(MouseEvent.CLICK,removeMessage);
				removeChild(lobbyMessage);
				lobbyMessage = null;
			}
		}
		
	}
	
}
