package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import serverHandler;
	
	public class HUD extends MovieClip {
		
		public static var hud;
		public var gameMenu:game_menu;
		var checkingEscKeyUp:Boolean = false;
		var showingGameMenu:Boolean = false;
		
		var messageTimeout = 0;
		
		public function HUD() {
			hud = this;
			this.addEventListener(Event.ENTER_FRAME, follow, false, 0, true);
			chatInputs.sendChat.addEventListener(MouseEvent.CLICK,sendChatButton, false, 0, true);
		}
		
		function follow(event:Event):void
		{
			this.x=-root.x;
			this.y=-root.y;
			if(messageTimeout > 0)
			{
				messageTimeout--;
			}
			else
			{
				if(chatBox.alpha > 0)
				{
					chatBox.alpha -= 0.01;
				}
			}
			
			if(landworld(root).escKey)
			{
				checkingEscKeyUp = true;
			}
			if(checkingEscKeyUp)
			{
				if(!landworld(root).escKey)
				{
					checkingEscKeyUp = false;
					if(showingGameMenu)
					{
						showingGameMenu = false;
						gameMenu.removeEventHandlers();
						removeChild(gameMenu);
					}
					else
					{
						showingGameMenu = true;
						gameMenu = new game_menu();
						gameMenu.x = width/2;
						gameMenu.y = height/2;
						addChild(gameMenu);
					}
				}
			}
		}
		
		function sendChatButton(event:MouseEvent)
		{
			messageTimeout = 120;
			chatBox.alpha = 0.7;
			if(this.chatInputs.chatInput.text != "")
			{
				landworld(root).connection.sendChat(this.chatInputs.chatInput.text);
				this.chatInputs.chatInput.text = "";
			}
		}
		
		public function gotChatMsg(Name:String,msg:String)
		{
			messageTimeout = 120;
			chatBox.alpha = 0.7;
			var currentText:String = chatBox.chatBox.text;
			
			chatBox.chatBox.text = currentText + Name + ": " + msg + "\n";
			
			chatBox.scrollerBar.update();
			chatBox.scrollerBar.scrollPosition = 9000;
			chatBox.scrollerBar.visible = true;
			if (chatBox.scrollerBar.enabled == false) {
				chatBox.scrollerBar.alpha = 0;
			} else {
				chatBox.scrollerBar.alpha = 0.7;
			}
		}
		
	}
}
