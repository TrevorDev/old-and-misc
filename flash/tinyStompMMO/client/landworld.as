package 
{
	import flash.display.StageDisplayState;

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import playerio.*;
	import serverHandler;
	import remotePlayer;
	import flash.sampler.NewObjectSample;
	import fl.transitions.easing.None;

	public class landworld extends MovieClip
	{
		public static var arrListeners:Array=[];
		public static var main;
		
		//char information
		public var backLook:Number = 0;
		public var weaponLook:Number = 0;
		public var otherOneLook:Number = 0;
		public var otherTwoLook:Number = 0;
		public var eyeLook:Number = 0;
		public var hatsLook:Number = 0;
		public var headLook:Number = 0;
		public var shoesLook:Number = 0;
		public var level:Number = 0;
		public var experience:Number = 0;
		public var coins:Number = 0;
		// </char information>
		
		public var begin_screen:begin;
		public var level_one_screen:MovieClip;
		public var lobby_screen:lobby;
		public var login_screen:loginMenu;
		public var levelFunction=level_one;
		public var character_screen:characterCreate;

		public var left,right,up,down,enterKey,attack = false,fFive:Boolean = false, escKey = false, one, two, three;

public var connection:serverHandler;


		public function landworld()
		{
			
			main = this;
			stage.stageFocusRect=false; 
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			show_begin();
		}
//LISTENERS==========================
override public function addEventListener(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=false):void {
super.addEventListener(type,listener,useCapture,priority,useWeakReference);
arrListeners.push({type:type,listener:listener});
}
//
public function clearEvents():void {
for (var i:Number=0; i < arrListeners.length; i++) {
if (this.hasEventListener(arrListeners[i].type)) {
this.removeEventListener(arrListeners[i].type,arrListeners[i].listener);
}
}
arrListeners=null;
}

		public function guestConnect(guestName:String)
		{
			connection = new serverHandler(); 
			connection.setMainMenu(this);
			
			/*PlayerIO.quickConnect.facebookOAuthConnectPopup(
				stage, 
				"testgame-5xhfufvewua6xwetedwz7q", 
				"_blank", // name of window to open dialog in
				["publish_stream","offline_access"], // requested permissions from facebook
				null,
				connection.handleFacebookConnect,
				connection.handleError
			);*/
			PlayerIO.connect(
				stage,								//Referance to stage
				"testgame-5xhfufvewua6xwetedwz7q",			//Game id (Get your own at playerio.com. 1: Create user, 2:Goto admin pannel, 3:Create game, 4: Copy game id inside the "")
				"public",							//Connection id, default is public
				guestName,								//Username
				"",									//User auth. Can be left blank if authentication is disabled on connection
				null,								//Current PartnerPay partner.
				connection.guestConnect,						//Function executed on successful connect
				connection.handleError							//Function executed if we recive an error
			);
			eyeLook = 1;
			hatsLook = 1;
			headLook = 1;
			shoesLook = 1;
			backLook=2;
			addChild(connection);
		}
		
		public function registerConnect(userName:String,thePassword:String,email:String)
		{
			connection = new serverHandler(); 
			connection.setMainMenu(this);
			PlayerIO.quickConnect.simpleRegister(
				stage,								//Referance to stage
				"testgame-5xhfufvewua6xwetedwz7q",			//Game id (Get your own at playerio.com. 1: Create user, 2:Goto admin pannel, 3:Create game, 4: Copy game id inside the "")
				userName,
				thePassword,
				email,
				null,								// captcha key
				null,								// captcha value
				null,								//ExtraData
				null,								//Current PartnerPay partner.
				connection.handleRegistration,						//Function executed on successful connect
				connection.regError							//Function executed if we recive an error
			);
			addChild(connection);
		}
		
		public function simpleConnect(userName:String,thePassword:String)
		{
			connection = new serverHandler(); 
			connection.setMainMenu(this);
			PlayerIO.quickConnect.simpleConnect(
				stage,								//Referance to stage
				"testgame-5xhfufvewua6xwetedwz7q",			//Game id (Get your own at playerio.com. 1: Create user, 2:Goto admin pannel, 3:Create game, 4: Copy game id inside the "")
				userName,
				thePassword,
				connection.handleConnect,						//Function executed on successful connect
				connection.handleError							//Function executed if we recive an error
			);
			addChild(connection);
		}
		
		//KEYBOARD INPUT=============================================
		function keyIsDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 27)
			{
				escKey = true;
			}
			if (event.keyCode == 37)
			{
				left = true;
			}
			if (event.keyCode == 38)
			{
				up = true;
			}
			if (event.keyCode == 39)
			{
				right = true;
			}
			if (event.keyCode == 40)
			{
				down = true;
			}
			if (event.keyCode == 13)
			{
				enterKey = true;
			}
			if (event.keyCode == 116)
			{
				fFive = true;
			}
			if (event.keyCode == 88)
			{
				attack = true;
			}
		if (event.keyCode == 49)
			{
				one = true;
			}
			if (event.keyCode == 50)
			{
				two = true;
			}
			if (event.keyCode == 51)
			{
				three = true;
			}
		}


		function keyIsUp(event:KeyboardEvent):void
		{
			if (event.keyCode == 27)
			{
				escKey = false;
			}
			if (event.keyCode == 37)
			{
				left = false;
			}
			if (event.keyCode == 38)
			{
				up = false;
			}
			if (event.keyCode == 39)
			{
				right = false;
			}
			if (event.keyCode == 40)
			{
				down = false;
			}
			if (event.keyCode == 13)
			{
				enterKey = false;
			}
			if (event.keyCode == 116)
			{
				fFive = false;
			}
			if (event.keyCode == 88)
			{
				attack = false;
			}
			if (event.keyCode == 49)
			{
				one = false;
			}
			if (event.keyCode == 50)
			{
				two = false;
			}
			if (event.keyCode == 51)
			{
				three = false;
			}
		}

		//INTERFACE==================================================
		public function show_begin()
		{
			root.x = 0;
			root.y = 0;
			begin_screen = new begin(this);
			addChild(begin_screen);
		}
		
		public function show_login()
		{
			root.x = 0;
			root.y = 0;
			login_screen = new loginMenu;
			login_screen.x = width/2;
			login_screen.y = 280;
			remove_begin();
			addChild(login_screen);
		}
		
		public function show_characterCreate()
		{
			character_screen = new characterCreate();
			remove_login();
			addChild(character_screen);
		}
		
		public function remove_characterCreate()
		{
			if(character_screen)
			{
				character_screen.removeEventListener(MouseEvent.CLICK, character_screen.makeCharacterBtn);
				removeChild(character_screen);
				character_screen = null;
			}
		}
		
		public function remove_login()
		{
			if(login_screen)
			{
				login_screen.removeEventListener(MouseEvent.CLICK, login_screen.guestConnect);
				removeChild(login_screen);
				login_screen = null;
			}
		}
		
		public function show_lobby()
		{
			lobby_screen = new lobby(connection);
			remove_login();
			addChild(lobby_screen);
		}
		
		public function remove_lobby()
		{
			if(lobby_screen)
			{
				lobby_screen.remove_all();
				removeChild(lobby_screen);
				lobby_screen = null;
			}
		}
		
		public function show_level_one()
		{
			levelFunction= level_two;
			
			if(room.roomer.listLevel.selectedIndex==0){
				levelFunction= level_two;
			}
			else if(room.roomer.listLevel.selectedIndex==1){
				levelFunction= level_two;
			}else if(room.roomer.listLevel.selectedIndex==2){
				levelFunction= level_two;
			}else if(room.roomer.listLevel.selectedIndex==3){
				levelFunction= level_two;
			}
			
			level_one_screen = new levelFunction;
			
			remove_lobby();
			addChild(level_one_screen);
			stage.focus = level_one_screen;
		}
		
		public function remove_level_one()
		{
			if(level_one_screen)
			{
				removeChild(level_one_screen);
				level_one_screen = null;
			}
		}
		
		public function remove_begin()
		{
			if (begin_screen)
			{
				begin_screen.removeEventListener(MouseEvent.CLICK, begin_screen.start_button_clicked);
				removeChild(begin_screen);
				begin_screen = null;
			}
		}
	}
}