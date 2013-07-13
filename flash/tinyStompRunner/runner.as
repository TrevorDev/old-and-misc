package 
{

	import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.display.StageDisplayState;
	import flash.net.SharedObject;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;

	public class runner extends MovieClip
	{
		public static var main;

		public static var cash = 100;
		public static var numberJumps = 1;
		public static var maxSpeed = 10;
		public static var jumpPow = 5;
		public static var deathDist = 3000;
		public static var cashGain = 10;
		public static var trickPwr = 0;
		public static var day = 1;
		public static var won = 0;
		public static var muteds = 0;

		public static var mute = false;
		public static var snd:Sound = new Sound();

		public static var user = "1";

		public var begin_screen:BeginScreen;
		public var game_screen:regularLevel;
		public var preGame_screen:PreGameScreen;
		public var help_screen:HelpScreen;
		public var intro_screen:introMovie;
		public var end_screen:endMovie;

		public static var sndChan:SoundChannel;
		public static var soundNum = 0;

		public var left,right,up,down,enterKey,attack = false,fFive:Boolean = false,escKey = false,one,two,three;
		public function runner()
		{
			main = this;
		}
		public function runnerStart()
		{
			var allowed_site:String = "flashgamelicense.com";

			var domain:String = this.root.loaderInfo.url.split("/")[2];

			//if (domain.indexOf(allowed_site) == (domain.length - allowed_site.length))
			if(1)
			{

				loades();
			stage.stageFocusRect = false;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			show_begin();
			if (muteds==1)
			{
				muter(null);
			}

			}
			else
			{

				// Nothing's okay.  Go away.

			}
			
			
		}
		//SOUND//////////////////////////
		public static function fadeSong()
		{
			if (sndChan)
			{
				var transform:SoundTransform = sndChan.soundTransform;
				transform.volume = 0;
				sndChan.soundTransform = transform;
			}
		}

		public static function stopMusic()
		{
			if (sndChan)
			{
				sndChan.stop();
			}
			soundNum = 0;
		}

		public static function menuSong()
		{


			if (soundNum!=1&&!mute)
			{
				if (sndChan)
				{
					sndChan.stop();
				}
				snd= new menuMusic();
				sndChan = snd.play(0,99999);
				soundNum = 1;
			}
		}
		public static function gameSong()
		{

			if (soundNum!=2&&!mute)
			{
				if (sndChan)
				{
					sndChan.stop();
				}
				snd= new gameMusic();
				sndChan = snd.play(0,99999);
				soundNum = 2;
			}
		}

		public static function muter(event:MouseEvent)
		{

			if (mute)
			{
				runner.main.begin_screen.mute_button.gotoAndStop(1);
				mute = false;

				menuSong();
			}
			else
			{
				runner.main.begin_screen.mute_button.gotoAndStop(2);
				if (sndChan)
				{
					sndChan.stop();
				}

				soundNum = 0;
				mute = true;

			}
		}

		//LOADING AND SAVING

		public static function saving()
		{

			var so:SharedObject = SharedObject.getLocal(user);
			so.data.ca = cash;
			so.data.jn = numberJumps;
			so.data.ms = maxSpeed;
			so.data.jp = jumpPow;
			so.data.dd = deathDist;
			so.data.cg = cashGain;
			so.data.tp = trickPwr;
			so.data.da = day;
			so.data.mu = muteds;
			so.data.wo = won;
			so.flush();
		}

		public static function loades()
		{
			var so:SharedObject = SharedObject.getLocal(user);
			cash = so.data.ca;
			numberJumps = so.data.jn;
			maxSpeed = so.data.ms;
			jumpPow = so.data.jp;
			deathDist = so.data.dd;
			cashGain = so.data.cg;
			trickPwr = so.data.tp;
			day = so.data.da;
			muteds = so.data.mu;
			won = so.data.wo;
			if (! day)
			{
				erase(null);
			}
		}

		public static function erase(event:MouseEvent)
		{
			cash = 100;
			numberJumps = 1;
			maxSpeed = 10;
			jumpPow = 5;
			deathDist = 3000;
			cashGain = 10;
			trickPwr = 0;
			day = 0;
			won = 0;
			muteds = 0;

		}

		//INTERFACE==================================================
		public static function goFullScreen(event:MouseEvent):void
		{
			runner.main.stage["displayState"] = "fullScreen";

		}


		public function show_game()
		{

			game_screen = new regularLevel();
			runner.main.removeAllScreens();
			runner.main.addChildAt(game_screen,0);
			ground.trickCashGained = 0;
			stage.addEventListener(Event.ENTER_FRAME, endDeath.deathChase);
			stage.addEventListener(Event.ENTER_FRAME, guy.movePlayer);
			stage.addEventListener(Event.ENTER_FRAME, guy.gravity);
			stage.addEventListener(Event.ENTER_FRAME, ground.makeWall);
			stage.addEventListener(Event.ENTER_FRAME, ground.generateWalls);
			stage.addEventListener(Event.ENTER_FRAME, bg2.generateBg2);
			stage.addEventListener(Event.ENTER_FRAME, bg1.generateBg1);
			stage.addEventListener(Event.ENTER_FRAME, cam.makeCam);
			stage.addEventListener(Event.ENTER_FRAME, death.makeDeath);
			ground.timeCounted = 0;
		}

		public function remove_game()
		{
			if (game_screen)
			{
				if (main.contains(game_screen))
				{
					runner.day++;
					stage.removeEventListener(Event.ENTER_FRAME, endDeath.deathChase);
					stage.removeEventListener(Event.ENTER_FRAME, guy.movePlayer);
					stage.removeEventListener(Event.ENTER_FRAME, guy.gravity);
					stage.removeEventListener(Event.ENTER_FRAME, ground.makeWall);
					stage.removeEventListener(Event.ENTER_FRAME, bg2.generateBg2);
					stage.removeEventListener(Event.ENTER_FRAME, bg1.generateBg1);
					stage.removeEventListener(Event.ENTER_FRAME, ground.generateWalls);
					stage.removeEventListener(Event.ENTER_FRAME, cam.makeCam);
					stage.removeEventListener(Event.ENTER_FRAME, death.makeDeath);
					for (var i=0; i<upgradeButton.ar.length; i++)
					{
						upgradeButton.ar[i].removeEventListener(MouseEvent.CLICK, upgradeButton.ar[i].clicked);
					}
					doneArrow.ar=new Array();
					placedGround.ar = new Array();
					ground.ar = new Array();
					death.ar = new Array();
					guy.ar = new Array();
					bg2.ar = new Array();
					bg1.ar = new Array();
					removeChild(game_screen);
					game_screen = null;
				}
			}
		}

		public function removeAllScreens()
		{
			remove_helpScreen();
			remove_preScreen();
			remove_begin();
			remove_game();
			remove_intro();
			remove_end();
		}
		public function show_begin()
		{

			begin_screen = new BeginScreen();
			runner.main.removeAllScreens();
			runner.main.addChildAt(begin_screen, 0);
			if (mute)
			{
				runner.main.begin_screen.mute_button.gotoAndStop(2);
			}
			else
			{
				runner.main.begin_screen.mute_button.gotoAndStop(1);
			}
		}

		public function intro()
		{
			intro_screen = new introMovie();
			runner.main.removeAllScreens();
			runner.main.addChildAt(intro_screen, 0);
		}



		public function remove_intro()
		{
			if (intro_screen)
			{
				if (main.contains(intro_screen))
				{
					intro_screen.removeEventListener(Event.ENTER_FRAME, intro_screen.done);
					removeChild(intro_screen);
					intro_screen = null;
				}
			}
		}

		public function end()
		{
			end_screen = new endMovie();
			runner.main.removeAllScreens();
			runner.main.addChildAt(end_screen, 0);
		}

		public function remove_end()
		{
			if (end_screen)
			{
				if (main.contains(end_screen))
				{
					end_screen.removeEventListener(Event.ENTER_FRAME, end_screen.done);
					removeChild(end_screen);
					end_screen = null;
				}
			}
		}

		public function remove_begin()
		{
			if (begin_screen)
			{
				if (main.contains(begin_screen))
				{

					begin_screen.removeEventListener(MouseEvent.CLICK, begin_screen.start_button_clicked);
					begin_screen.removeEventListener(MouseEvent.CLICK, begin_screen.help_button_clicked);
					begin_screen.removeEventListener(MouseEvent.CLICK, runner.goFullScreen);
					begin_screen.removeEventListener(MouseEvent.CLICK, runner.erase);
					begin_screen.removeEventListener(MouseEvent.CLICK, runner.muter);
					removeChild(begin_screen);
					begin_screen = null;
				}
			}
		}

		public function show_preScreen()
		{
			runner.main.removeAllScreens();
			preGame_screen = new PreGameScreen  ;
			runner.main.addChildAt(preGame_screen, 0);
			cashString.updatescore(String((day)), PreGameScreen.screen.totalDay);
			cashString.updatescore(String("$"+(cash)), PreGameScreen.screen.totalCash);
			var dice = Math.floor(Math.random() * 11);
			if (dice==0)
			{
				cashString.updatescore(String("%15 of the cost of your meal"), PreGameScreen.screen.tipBox);
			}
			else if (dice==1)
			{
				cashString.updatescore(String("Move away from the left side of the screen"), PreGameScreen.screen.tipBox);
			}
			else if (dice==2)
			{
				cashString.updatescore(String("I heard someone saying something about pressing alt+F4"), PreGameScreen.screen.tipBox);
			}
			else if (dice==3)
			{
				cashString.updatescore(String("Press down while in the air to perform tricks"), PreGameScreen.screen.tipBox);
			}
			else if (dice==4)
			{
				cashString.updatescore(String("If you keep running you just might reach the end of the world"), PreGameScreen.screen.tipBox);
			}
			else if (dice==5)
			{
				cashString.updatescore(String("Thinking of these tips is hard work"), PreGameScreen.screen.tipBox);
			}
			else if (dice==6)
			{
				cashString.updatescore(String("Eating healthy and getting good exersize (eg. running) is good for your health"), PreGameScreen.screen.tipBox);
			}
			else if (dice==7)
			{
				cashString.updatescore(String("Do a barrel role"), PreGameScreen.screen.tipBox);
			}
			else if (dice==8)
			{
				cashString.updatescore(String("You can jump higher while moving than in a stationary position"), PreGameScreen.screen.tipBox);
			}
			else if (dice==9)
			{
				cashString.updatescore(String("speling isn't important if you get the point accross"), PreGameScreen.screen.tipBox);
			}
			else if (dice==10)
			{
				cashString.updatescore(String("Buying cash gain will increase the ammount of cash generated from staying alive"), PreGameScreen.screen.tipBox);
			}

stage.addEventListener(Event.ENTER_FRAME, preGame_screen.nextGame);
stage.focus = this;
			stage.addEventListener(Event.ENTER_FRAME, upgradeButton.upgradesSystem);
			
		}

		public function remove_preScreen()
		{
			if (preGame_screen)
			{
				if (main.contains(preGame_screen))
				{
					preGame_screen.removeEventListener(MouseEvent.CLICK, preGame_screen.back_button_clicked);
					preGame_screen.removeEventListener(MouseEvent.CLICK, preGame_screen.startRun_button_clicked);
					stage.removeEventListener(Event.ENTER_FRAME, upgradeButton.upgradesSystem);
					stage.removeEventListener(Event.ENTER_FRAME, preGame_screen.nextGame);
					upgradeButton.ar = new Array();
					removeChild(preGame_screen);
					preGame_screen = null;
				}
			}
		}

		public function show_helpScreen()
		{
			help_screen = new HelpScreen  ;
			runner.main.removeAllScreens();
			runner.main.addChildAt(help_screen, 0);
		}

		public function remove_helpScreen()
		{
			if (help_screen)
			{
				if (main.contains(help_screen))
				{
					help_screen.removeEventListener(MouseEvent.CLICK, help_screen.back_button_clicked);
					removeChild(help_screen);
					help_screen = null;
				}
			}
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
			if (event.keyCode == 32)
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
			if (event.keyCode == 32)
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
	}

}