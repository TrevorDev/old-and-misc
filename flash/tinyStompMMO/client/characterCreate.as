package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import playerio.*;
	
	public class characterCreate extends MovieClip {
		
		public var eyeLook:Number = 1;
		public var hatsLook:Number = 1;
		public var headLook:Number = 1;
		public var shoesLook:Number = 1;
		public var thisRef:Number = 0;
		
		public function characterCreate() {
			// constructor code
			guySprite.lookPlayer=thisRef;
			eye.look[guySprite.lookPlayer]=eyeLook;
			hats.look[guySprite.lookPlayer]=hatsLook;
			foot.look[guySprite.lookPlayer]=shoesLook;
			head.look[guySprite.lookPlayer]=headLook;
			updateChar();
			createCharBtn.addEventListener(MouseEvent.CLICK, makeCharacterBtn);
			headLeftBtn.addEventListener(MouseEvent.CLICK, headLeft);
			headRightBtn.addEventListener(MouseEvent.CLICK, headRight);
			eyeLeftBtn.addEventListener(MouseEvent.CLICK, eyeLeft);
			eyeRightBtn.addEventListener(MouseEvent.CLICK, eyeRight);
			shoeLeftBtn.addEventListener(MouseEvent.CLICK, shoeLeft);
			shoeRightBtn.addEventListener(MouseEvent.CLICK, shoeRight);
		}
		
		function shoeRight(event:MouseEvent)
		{
			shoesLook = shoesLook + 1;
			if(shoesLook > 2)
			{
				shoesLook = 1;
			}
			foot.look[guySprite.lookPlayer]=shoesLook;
			updateChar();
		}
		
		function shoeLeft(event:MouseEvent)
		{
			shoesLook = shoesLook - 1;
			if(shoesLook < 1)
			{
				shoesLook = 2;
			}
			foot.look[guySprite.lookPlayer]=shoesLook;
			updateChar();
		}
		
		function headRight(event:MouseEvent)
		{
			headLook = headLook + 1;
			if(headLook > 4)
			{
				headLook = 1;
			}
			head.look[guySprite.lookPlayer]=headLook;
			updateChar();
		}

		function headLeft(event:MouseEvent)
		{
			headLook = headLook - 1;
			if(headLook < 1)
			{
				headLook = 4;
			}
			head.look[guySprite.lookPlayer]=headLook;
			updateChar();
		}
		
		function updateChar()
		{
			character.gotoAndStop(2);
			character.gotoAndStop(1);
		}
		
		function eyeLeft(event:MouseEvent)
		{
			eyeLook = eyeLook - 1;
			if(eyeLook < 1)
			{
				eyeLook = 3;
			}
			eye.look[guySprite.lookPlayer]=eyeLook;
			updateChar();
		}
		function eyeRight(event:MouseEvent)
		{
			eyeLook = eyeLook + 1;
			if(eyeLook > 3)
			{
				eyeLook = 1;
			}
			eye.look[guySprite.lookPlayer]=eyeLook;
			updateChar();
		}
		
		public function makeCharacterBtn(event:MouseEvent) {
			landworld.main.eyeLook = eyeLook;
			landworld.main.headLook = headLook;
			landworld.main.shoesLook = shoesLook;
			
			serverHandler.serverHand.theClient.multiplayer.createJoinRoom(serverHandler.serverHand.theClient.connectUserId,
																		  "Store",false, null,null,
																		  function(conn:Connection){
																			  // hat eye torsoid and bootid
																			  trace(eyeLook,headLook,shoesLook);
																			  conn.send("makeChar",0,eyeLook,headLook,shoesLook);},
																		  function(error){trace(error)});
			landworld.main.show_lobby();
			serverHandler.serverHand.theLobby.refresh_rooms(null);
			landworld.main.remove_characterCreate();
		}
	}
	
}
