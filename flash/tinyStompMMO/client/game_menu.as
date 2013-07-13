package 
{

	import flash.display.MovieClip;
	import flash.events.*;


	public class game_menu extends MovieClip
	{

		public function game_menu()
		{
			Return.addEventListener(MouseEvent.CLICK,returnToGame);
			Option.addEventListener(MouseEvent.CLICK,showOption);
			ExitGame.addEventListener(MouseEvent.CLICK,exitMenu);
		}

		public function removeEventHandlers()
		{
			Return.removeEventListener(MouseEvent.CLICK, returnToGame);
			Option.removeEventListener(MouseEvent.CLICK,showOption);
			ExitGame.removeEventListener(MouseEvent.CLICK,exitMenu);
		}

		public function returnToGame(event:MouseEvent)
		{
			removeEventHandlers();
			HUD.hud.showingGameMenu = false;
			HUD.hud.removeChild(HUD.hud.gameMenu);
		}

		public function showOption(event:MouseEvent)
		{
			//removeEventHandlers();
			trace("options");
		}

		public function exitMenu(event:MouseEvent)
		{
			removeEventHandlers();
			HUD.hud.showingGameMenu = false;
			HUD.hud.removeChild(HUD.hud.gameMenu);
			HUD.hud.removeEventListener(Event.ENTER_FRAME, HUD.hud.follow);
			HUD.hud.chatInputs.sendChat.removeEventListener(MouseEvent.CLICK,HUD.hud.sendChatButton);


			//HUD.hud = null;
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].emotes);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].movePlayer);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].attacking);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].misc);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].gravity);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].makePlat);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].makeWall);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].springer);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].goal);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].deathZone);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].coins);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].checkPoint);
			guy.players[0].removeEventListener(Event.ENTER_FRAME, guy.players[0].cams);

			guy.num = -1;
			//guy.players[0] = null;
			for (var i = 0; i < coin.coins.length; i++)
			{

				coin.coins[i] = null;
				coin.coins.splice(i,1);
			}
			coin.num = -1;
			for (i = 0; i < button.buttons.length; i++)
			{
				button.buttons[i].removeEventListener(Event.ENTER_FRAME, button.buttons[i].hit);
				button.buttons[i] = null;
				button.buttons.splice(i,1);
			}

			for (i = 0; i < activated.activateds.length; i++)
			{
				activated.activateds[i].removeEventListener(Event.ENTER_FRAME, activated.activateds[i].makeWall);
				activated.activateds[i] = null;
				activated.activateds.splice(i,1);
			}

			for (var bad in bad1.badGuys)
			{
				if (bad1.badGuys[bad] != null)
				{
					bad1.badGuys[bad].removeEventListener(Event.ENTER_FRAME, bad1.badGuys[bad].hit);
					bad1.badGuys[bad].timer.stop();
					bad1.badGuys[bad] = null;
					bad1.badGuys.splice(bad,1);
				}
			}
			bad1.num = -1;

			for (i in ground.allGround)
			{
				ground.allGround[i] = null;
				ground.allGround.splice(i,1);
			}

			serverHandler.serverHand.inRoom = true;
			serverHandler.serverHand.inGame = false;
			serverHandler.serverHand.timer.stop();

			serverHandler.serverHand.connection.disconnect();
			landworld.main.show_begin();
			landworld.main.remove_level_one();
		}

	}

}