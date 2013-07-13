package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.system.Security;
	public class connect
	{

		var socketIP = '206.188.84.178';
		var socketPort = 843;
		var logedIn;
		public var socket:Socket;
		public var debugMode = false;
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
			trace(cNum);
			var param:String = socket.readMultiByte(socket.bytesAvailable,'ascii');
			trace(param);
			commandHandle(cNum, param);
			socket.flush();

		}

		public function requestStockInfo()
		{
			socket.writeInt(3);
			socket.flush();
		}

		public function sendUserLogin(usrName:String, pass:String)
		{
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

		
		public function commandHandle(cNum:int, param:String)
		{
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
					money.gameMoney=Number(param);
					money.main.show_logedIn();
					break;
				case 5 :
					var split = param.split("|");
					for (var i=0;i<split.length;i++){
						var splitStock=split[i].split("/");
						money.stocks  = new Array();
						money.stocks.push(new stock(splitStock[0], splitStock[1], splitStock[2], splitStock[3], splitStock[4]));
					}
					break;
			}
		}
		
		

	}
}