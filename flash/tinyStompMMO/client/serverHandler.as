package 
{
	import flash.display.MovieClip;
	import playerio.*;
	import remotePlayer;
	import flash.events.*;
	import flash.utils.Timer;

	public class serverHandler extends MovieClip
	{
		public static var serverHand;
		public var rePlayer:remotePlayer;
		var inRoom:Boolean = true;
		var roomOwner = false;
		var inGame:Boolean = false;
		public static var players:Array = new Array  ;
		//Time at the last frame
		var oldTime:Number = (new Date()).getTime();
		//Time at the last state update
		var oldStateTime:Number = 0;
		//Your userID
		var myId:int = -1;
		var myDude:MovieClip;
		//If the up key is pressed
		var keyUp:Boolean = false;
		//If the down key is pressed
		var keyDown:Boolean = false;
		//If the Right key is pressed
		var keyRight:Boolean = false;
		//If the Left key is pressed
		var keyLeft:Boolean = false;
		public var errMessage:lobby_message;
		public var connection:Connection;
		public var theClient:Client;
		public var theLobby:lobby;
		public var mainMenu:landworld;
		public var myUserId;
		public var myName;
		var enterKey:Boolean = false;

		public var splineCo = 3;
		public var preXS = 0;
		public var preYS = 0;
		public var preXP = 0;
		public var preYP = 0;

		var timeStart;

		// 320 ms timer
		var timer:Timer = new Timer(320,0);

		public function serverHandler()
		{
			serverHand = this;
			addEventListener(Event.ENTER_FRAME,go);

			timer.addEventListener(TimerEvent.TIMER, timerTick);
		}

		function timerTick(e:TimerEvent):void
		{
			if (myId != -1)
			{
				
				connection.send("pos",myId,guy.players[0].x,guy.players[0].y, guy.players[0].xSpeed, guy.players[0].ySpeed);
				
			}
		}


		public function guestConnect(client:Client):void
		{
			theClient = client;
			//client.multiplayer.developmentServer = "127.0.0.1:8184";
			landworld.main.show_lobby();
			theLobby.refresh_rooms(null);
		}

		public function handleConnect(client:Client):void
		{
			theClient = client;
			//client.multiplayer.developmentServer = "127.0.0.1:8184";
			landworld.main.show_lobby();
			trace("Sucessfully connected to player.io");
			// join the room store and request character information.
			theClient.multiplayer.createJoinRoom(theClient.connectUserId,
												  "Store",false, null,null,
												  function(conn:Connection){
												  conn.send("charStatus");
												  conn.addMessageHandler("*",gotStoreMessage);},
												  function(error){trace(error)});
			theLobby.refresh_rooms(null);
		}
		
		public function handleRegistration(client:Client):void
		{
			theClient = client;
			//client.multiplayer.developmentServer = "127.0.0.1:8184";
			landworld.main.show_characterCreate();
		}

		public function handleFacebookConnect(client:Client,access_string:String,facebookUserId:String):void
		{
			theClient = client;
			myUserId = facebookUserId;
			trace("Sucessfully connected to player.io");

			//client.multiplayer.developmentServer = "127.0.0.1:8184";
		}
		
		public function regError(error:PlayerIORegistrationError):void
		{
			trace("Got",error,error.errorID);
			var errorMsg = "";
			if(error.emailError != null)
				errorMsg = errorMsg + error.emailError;
			if(error.passwordError != null)
				errorMsg = errorMsg + " " + error.passwordError + "\n";
			if(error.usernameError != null)
				errorMsg = errorMsg + " " + error.usernameError + "\n";
			errMessage = new lobby_message(errorMsg,"OK");
			errMessage.x = 412.5;
			errMessage.y = 350;
			addChild(errMessage);
			errMessage.buttonTxt.addEventListener(MouseEvent.CLICK,removeMessage);
		}

		public function handleError(error:PlayerIOError):void
		{
			trace("Got",error,error.errorID);
			errMessage = new lobby_message(error.message,"OK");
			errMessage.x = 412.5;
			errMessage.y = 350;
			addChild(errMessage);
			errMessage.buttonTxt.addEventListener(MouseEvent.CLICK,removeMessage);
		}

		public function removeMessage(event:MouseEvent)
		{
			if(errMessage)
			{
				errMessage.removeEventListener(MouseEvent.CLICK,removeMessage);
				removeChild(errMessage);
				errMessage = null;
			}
		}
		//called when you joins the room
		function handleJoin(conn:Connection)
		{
			inRoom = true;
			trace("joined");
			connection = conn;
			theLobby.showInsideRoom();
			//This will call gotMessage every time we receive any message;
			connection.addMessageHandler("*",gotMessage);
		}

		//sends a chat message when the cend button is pressed;
		function sendChat(chatMessage:String)
		{
			connection.send("chat",chatMessage);
		}

		function loadedCharacter(user:DatabaseObject):void
		{
			trace(user.Name);
		}

		//Called when you receive a message
		public function gotMessage(info:Message)
		{
			var i:int;
			//The time now
			var messageTime:Number = (new Date()).getTime();
			//The time since the last state update
			var diff:Number = messageTime - oldStateTime;
			switch (info.type)
			{
					//When a user joins (including you)
				case "userJoined" :
					if (inGame)
					{
						//Set him at the given x and y with all default properties
						if (info.getInt(0) != myId)
						{
							players[info.getInt(0)] = new remotePlayer(info.getInt(1),info.getInt(2));
							players[info.getInt(0)].messageTimeout = 0;
							//players[info.getInt(0)].userName.text = "some noob";
							remote.remote.addChildAt(players[info.getInt(0)], 0);
						}
					}
					break;
				case "playerName" :
					if (info.getInt(0) != myId)
					{
						if (inGame)
						{
							if (players[info.getInt(0)])
							{
								players[info.getInt(0)].userName.text = info.getString(1);
							}
						}
						if (inRoom)
						{
							theLobby.addPlayer(info.getString(1),info.getInt(0));
						}
					}
					else
					{
						if (inRoom)
						{
							theLobby.addPlayer(info.getString(1),info.getInt(0));
						}
						myName = info.getString(1);
					}
					break;
					//Give the current game state when you join
				case "info" :
					//Get your ID
					myId = info.getInt(0);
					myDude = players[myId];
					if (inGame)
					{
						//Load every existing player's data
						for (i = 0; i < (info.length - 1) / 3; i++)
						{
							players[info.getInt(i * 3 + 1)] = new remotePlayer(100,20);
							players[info.getInt(i * 3 + 1)].x = info.getInt(i * 3 + 2);
							players[info.getInt(i * 3 + 1)].y = info.getInt(i * 3 + 3);
							players[info.getInt(i * 3 + 1)].messageTimeout = 0;
							remote.remote.addChildAt(players[info.getInt(i * 3 + 1)], 0);
						}
					}
					break;
				case "userLeft" :
					if (info.getInt(0) == myId)
					{
						inRoom = false;
						inGame = false;
					}
					if (inRoom)
					{
						theLobby.removePlayer(info.getInt(0));
					}
					if (inGame)
					{
						//remove the player when he leaves
						remote.remote.removeChild(players[info.getInt(0)]);
						delete players[info.getInt(0)];
					}
					break;

					//When a user presses "up"
				case "pos" :
					if (inGame)
					{
						if (myId != info.getInt(0))
						{
							if(players[info.getInt(0)] != null)
							{
								players[info.getInt(0)].packetBuf++;
								if (players[info.getInt(0)].packetBuf > players[info.getInt(0)].buffSize)
								{
									players[info.getInt(0)].packetBuf = 0;
								}


								players[info.getInt(0)].nextX[players[info.getInt(0)].packetBuf] = info.getInt(1);
								players[info.getInt(0)].nextY[players[info.getInt(0)].packetBuf] = info.getInt(2);
								players[info.getInt(0)].xSpeed[players[info.getInt(0)].packetBuf] = info.getInt(3);
								players[info.getInt(0)].ySpeed[players[info.getInt(0)].packetBuf] = info.getInt(4);


players[info.getInt(0)].oldestX=players[info.getInt(0)].newestX;
players[info.getInt(0)].oldestY=players[info.getInt(0)].newestY;
players[info.getInt(0)].oldestXS=players[info.getInt(0)].newestXS;
players[info.getInt(0)].oldestYS=players[info.getInt(0)].newestYS;

players[info.getInt(0)].newestX=info.getInt(1);
players[info.getInt(0)].newestY=info.getInt(2);
players[info.getInt(0)].newestXS=info.getInt(3);
players[info.getInt(0)].newestYS=info.getInt(4);

								players[info.getInt(0)].newTime[players[info.getInt(0)].packetBuf] = (new Date()).getTime();
								players[info.getInt(0)].timeDif[players[info.getInt(0)].packetBuf] = (players[info.getInt(0)].newTime[players[info.getInt(0)].packetBuf] - players[info.getInt(0)].oldTime);
								players[info.getInt(0)].oldTime = players[info.getInt(0)].newTime[players[info.getInt(0)].packetBuf];
							}

						}
					}
					break;
					//Displays a chat message on the player when a user sends it
				case "chat" :
					if (inRoom)
					{
						theLobby.gotChat(info.getInt(0),info.getString(1));
					}
					if (inGame)
					{
						if (info.getInt(0) != myId)
						{
							players[info.getInt(0)].userSays.text = info.getString(1);
							players[info.getInt(0)].messageTimeout = 90;
							HUD.hud.gotChatMsg(players[info.getInt(0)].userName.text,info.getString(1));
						}
						else
						{
							HUD.hud.gotChatMsg(myName,info.getString(1));
						}
					}
					break;
				case "actOn" :
					trace("on" + info.getInt(0));
					for (var active in activated.activateds)
					{
						if(info.getInt(0) == activated.activateds[active].link)
						{
							activated.activateds[active].moveOn = true;
						}
					}
					break;
				case "actOff" :
					trace("off" + info.getInt(0));
					for (var activee in activated.activateds)
					{
						if(info.getInt(0) == activated.activateds[activee].link)
						{
							activated.activateds[activee].moveOn = false;
						}
					}
					break;
				case "startTheGame" :
					inGame = true;
					inRoom = false;
					mainMenu.show_level_one();
					timer.start();
					break;
				case "theOwner" :
					if (inRoom)
					{
						theLobby.playerOwner(info.getInt(0));
						if (info.getInt(0) == myId)
						{
							//theLobby.inside_room.room_ready_button.readyText.text = "Start Game";
						}
						else
						{
							//theLobby.inside_room.room_ready_button.readyText.text = "Ready";
						}
					}
					break;
				case "ready" :
					if (inRoom)
					{
						theLobby.playerReady(info.getInt(0));
					}
					break;
				case "ConnectOverflow" :
					if (inRoom)
					{
						theLobby.removeJoinedRoomWindow(null);
						theLobby.newMessage("Only one connection is allowed per room","OK");
					}
					break;
				case "Full" :
					theLobby.removeJoinedRoomWindow(null);
					theLobby.newMessage("The room is full","OK");
					break;
				case "direct" :
					{
						bad1.badGuys[info.getInt(0)].x = info.getNumber(1);
						bad1.badGuys[info.getInt(0)].direction = info.getBoolean(2);
						if(bad1.badGuys[info.getInt(0)].direction){
							bad1.badGuys[info.getInt(0)].scaleX=1;
						}else{
							bad1.badGuys[info.getInt(0)].scaleX=-1;
						}
					}
					break;
				case "edead" :
				bad1.badGuys[info.getInt(0)].health=0;
					bad1.badGuys[info.getInt(0)].play();
					
					break;
				case "reCharInfo" :
					players[info.getInt(0)].updateChar(info.getInt(2),info.getInt(3),info.getInt(4));
					break;
			
		};
		}

		public function setLobby(obj:lobby)
		{
			theLobby = obj;
		}

		public function setMainMenu(obj:landworld)
		{
			mainMenu = obj;
		}

		//The enterFrame function
		function go(info)
		{
			if (inGame)
			{
				//compute the time since last update
				var newTime:Number = (new Date()).getTime();
				var diff:Number = newTime - oldTime;
				oldTime = newTime;
				//Set your person's movement to your key presses to give extrapolation
				if (myId != -1)
				{
					//myDude.x += myDude.xSpeed;
					//connection.send("pos",myId,guy.players[0].x,guy.players[0].y);
				}

				if (landworld(root).enterKey && enterKey == false)
				{
					enterKey = true;
					if (guy.players[0].canMove)
					{
						guy.players[0].canMove = false;
						stage.focus = mainMenu.level_one_screen.theHUD.chatInputs.chatInput;
						mainMenu.level_one_screen.theHUD.sendChatButton(null);
					}
					else
					{
						stage.focus = this;
						mainMenu.level_one_screen.theHUD.sendChatButton(null);
						guy.players[0].canMove = true;
					}
				}
				else if (!landworld(root).enterKey)
				{
					enterKey = false;
				}


				//Move all players
				if (landworld(root).left || landworld(root).right || landworld(root).up || landworld(root).down)
				{
					guy.players[0].canMove = true;
					stage.focus = this;
				}
				timeStart = (new Date()).getTime()-400;
				for (var player:String in players)
				{
					//CUBIC SPLINE
					if (! players[player].start && players[player].packetBuf >= 1)
					{
						players[player].start = true;
					}
					if (players[player].start)
					{
						if (players[player].newPacket)
						{
							players[player].newPacket = false;
							preXS = players[player].oldestXS;
							preYS = players[player].oldestYS;
							preXP = players[player].oldestX;
							preYP = players[player].oldestY;
							players[player].curPacket++;
							players[player].curPacketPlus++;
							if (players[player].curPacket > players[player].buffSize)
							{
								players[player].curPacket = 0;
							}
							if (players[player].curPacketPlus > players[player].buffSize)
							{
								players[player].curPacketPlus = 0;
							}

							players[player].x1 = (preXP);
							players[player].x2 = (preXP + preXS * splineCo);
							players[player].x3 = (players[player].newestX - (players[player].newestXS * splineCo));
							players[player].x4 = (players[player].newestX);
							players[player].y1 = (preYP);
							players[player].y2 = (preYP + preYS * splineCo);
							players[player].y3 = (players[player].newestY - (players[player].newestYS * splineCo));
							players[player].y4 = (players[player].newestY);
players[player].speedPack=players[player].curPacket;
						}
						else
						{
							players[player].splineTime=(timeStart-players[player].newTime[players[player].curPacket])/players[player].timeDif[players[player].curPacket];
							//trace("CURRENT   "+players[player].curPacket+"  BUF "+players[player].packetBuf);
							if (players[player].splineTime > 1)
							{
								players[player].splineTime = 1;

							}
							players[player].x = players[player].splineTime*players[player].splineTime*players[player].splineTime * (players[player].x4 - 3*players[player].x3 + 3*players[player].x2 - players[player].x1) + players[player].splineTime*players[player].splineTime * (3*players[player].x3 - 6*players[player].x2 + 3*players[player].x1) + players[player].splineTime * (3*players[player].x2 - 3*players[player].x1) + players[player].x1;
							players[player].y = players[player].splineTime*players[player].splineTime*players[player].splineTime * (players[player].y4 - 3*players[player].y3 + 3*players[player].y2 - players[player].y1) + players[player].splineTime*players[player].splineTime * (3*players[player].y3 - 6*players[player].y2 + 3*players[player].y1) + players[player].splineTime * (3*players[player].y2 - 3*players[player].y1) + players[player].y1;
							if(players[player].x1 > players[player].x2)
							{
								players[player].scaleX = -1;
							}
							else if(players[player].x1 < players[player].x2)
							{
								players[player].scaleX = 1;
							}else{
								if(players[player].sprite.currentFrame==1){
								players[player].sprite.walking.gotoAndStop(1);
								}
							}
							
							if (timeStart >= players[player].newTime[players[player].curPacketPlus])
							{
								var temp = players[player].curPacketPlus;
								players[player].curPacketPlus++;
								if (players[player].curPacketPlus > players[player].buffSize)
								{
									players[player].curPacketPlus = 0;
								}
								if (players[player].newTime[players[player].curPacketPlus] >= players[player].newTime[temp])
								{
									players[player].newPacket = true;
								}
								players[player].curPacketPlus=temp;
							}

						}
					}


					//Only lets chat messages display for a short time
					if (players[player].messageTimeout > 0)
					{
						players[player].messageTimeout--;
					}
					else
					{
						players[player].userSays.text = "";
					}
				}
			}
		}
		
		public function gotStoreMessage(info:Message)
		{
			var i:int;
			//The time now
			var messageTime:Number = (new Date()).getTime();
			//The time since the last state update
			var diff:Number = messageTime - oldStateTime;
			switch (info.type)
			{
				case "charStatus" :
					trace("head " + info.getInt(0));
					landworld.main.eyeLook = info.getInt(1);
					landworld.main.headLook = info.getInt(2);
					landworld.main.shoesLook = info.getInt(3);
					landworld.main.hatsLook = 1;
					trace("Level " + info.getInt(4));
					trace("Exp " + info.getInt(5));
					
					//eye head shoe hat
					theLobby.charPreview.showCharacter(info.getInt(1),info.getInt(2),info.getInt(3),1);
					theLobby.theLevel.text = "Level: " + info.getInt(4);
					theLobby.theCoins.text = "Coins: " + info.getInt(6);
					
					break;
			};
		}
	}

}