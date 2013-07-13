package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.engine.TextElement;
	public class connect
	{

		var socketIP = '206.188.84.178';
		//var socketIP = '127.0.0.1';
		var socketPort = 843;
		public static var gettingData = false;
		var logedIn;
		public var socket:Socket;
		public var debugMode = false;
		public static var doFunc:Function;

		/*public static function onReceive(func:Function)
		{
			doFunc = func;
			mmogame.main.addEventListener(Event.ENTER_FRAME, checkData);
		}

		public static function checkData(e:Event)
		{
			if (! gettingData)
			{
				trace(gettingData);
				doFunc();
				mmogame.main.removeEventListener(Event.ENTER_FRAME, checkData);
			}
		}*/

		public function connect()
		{
			socket = new Socket(socketIP,socketPort);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, socketData);

			//socket.writeUTFBytes("how are you doing");
			//socket.writeInt(7);
			socket.flush();
			//trace(socket.bytesAvailable);

		}

		private function socketData(e:ProgressEvent):void
		{
			var cNum:int = socket.readInt();
			//trace(cNum);
			
			commandHandle(cNum, socket);
			

		}
		
		public function sendPos(posX, posY, spdX, spdY)
		{
			socket.writeInt(4);
			socket.writeInt(posX);
			socket.writeInt(posY);
			socket.writeInt(spdX);
			socket.writeInt(spdY);
			socket.flush();
		}
		
		public function sendUserJoin(room:Number)
		{
			socket.writeInt(3);
			socket.writeInt(room);
			socket.flush();
		}

		public function sendUserLogin(usrName:String, pass:String)
		{
			gettingData = true;
			var sender = usrName + "|" + pass;
			socket.writeInt(2);
			socket.writeUTFBytes(sender);
			socket.flush();
		}

		public function sendNewAccount(usrName:String, pass:String, email:String)
		{
			var sender = usrName + "|" + pass + "|" + email;
			socket.writeInt(1);
			socket.writeUTFBytes(sender);
			socket.flush();
		}


		public function commandHandle(cNum:int, socket)
		{
			var param:String;
			switch (cNum)
			{
					//account created
				case 1 :
					displayMessage.displayMsg("Account Created");
					break;
					//username already exists
				case 2 :
					displayMessage.displayMsg("Account username exists");
					break;
					//incorect login
				case 3 :
					displayMessage.displayMsg("Sorry username or password is incorrect");
					break;
					//loged in
				case 4 :
					param=socket.readMultiByte(socket.bytesAvailable,'ascii');
					mmogame.gameMoney = Number(param);
					mmogame.main.show_logedIn();
					break;
					//joined room
				case 5 :
					mmogame.main.show_level();
					param=socket.readMultiByte(socket.bytesAvailable,'ascii');
					var spltParam=param.split(" ");
					if(spltParam[0]!=""){
						for(var i=spltParam.length-1;i>=0;i--){
							new otherPlayer();
							//otherPlayer.otherPlayerAr[i].pName=spltParam[i];
							otherPlayer.otherPlayerAr[otherPlayer.otherPlayerAr.length-1].playerName.text=spltParam[i];
							remote.remote.addChildAt(otherPlayer.otherPlayerAr[otherPlayer.otherPlayerAr.length-1], 0);
						}
					}
					
					break;
					//received coords
				case 6 :
					var arraySize=socket.readInt()-4;
					var posAr:Array = new Array();
					for(i=0;i<arraySize;i++){
						posAr[i]=socket.readInt();
					}
					//trace(posAr);
					otherPlayer.setVarPinged(posAr);
					break;
					//player joined
				case 7 :
					param=socket.readMultiByte(socket.bytesAvailable,'ascii');
					
					new otherPlayer();
					trace(otherPlayer.otherPlayerAr.length);
					//otherPlayer.otherPlayerAr[otherPlayer.otherPlayerAr.length-1].pName=param;
					otherPlayer.otherPlayerAr[otherPlayer.otherPlayerAr.length-1].playerName.text=param;
					remote.remote.addChildAt(otherPlayer.otherPlayerAr[otherPlayer.otherPlayerAr.length-1], 0);
					break;
					//player left
				case 8 :
					param=socket.readMultiByte(socket.bytesAvailable,'ascii');
					for(i=0;i<otherPlayer.otherPlayerAr.length;i++){
						if(otherPlayer.otherPlayerAr[i].playerName.text==param){
							
							remote.remote.removeChild(otherPlayer.otherPlayerAr[i]);
							delete otherPlayer.otherPlayerAr[i];
							otherPlayer.otherPlayerAr.splice(i, 1);
							break;
						}
					
					}
					break;
				
			}
			param=socket.readMultiByte(socket.bytesAvailable,'ascii');
			socket.flush();
			gettingData = false;
			
		}



	}
}