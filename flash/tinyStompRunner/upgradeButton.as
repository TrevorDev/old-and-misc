package 
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.Event;
	import flash.utils.Timer;


	public class upgradeButton extends MovieClip
	{
		public static var ar:Array = new Array();
		public var varNum = 0;
		public var newVal = 0;
		public var cost = 0;
		public var buyed = false;
		public function upgradeButton()
		{
			stop();
			ar.push(this);
			this.addEventListener(MouseEvent.CLICK, clicked);

		}

		public static function upgradesSystem(event:Event):void
		{
			for (var i=0; i<upgradeButton.ar.length; i++)
			{
				if (upgradeButton.ar[i].varNum == 1)
				{
					if (upgradeButton.ar[i].newVal <= runner.maxSpeed)
					{
						upgradeButton.ar[i].buyed = true;
					}
				}
				else if (upgradeButton.ar[i].varNum==2)
				{
					if (upgradeButton.ar[i].newVal <= runner.jumpPow)
					{
						upgradeButton.ar[i].buyed = true;
					}
				}
				else if (upgradeButton.ar[i].varNum==3)
				{
					if (upgradeButton.ar[i].newVal <= runner.deathDist)
					{
						upgradeButton.ar[i].buyed = true;
					}
				}
				else if (upgradeButton.ar[i].varNum==4)
				{
					if (upgradeButton.ar[i].newVal <= runner.cashGain)
					{
						upgradeButton.ar[i].buyed = true;
					}
				}
				else if (upgradeButton.ar[i].varNum==5)
				{
					if (upgradeButton.ar[i].newVal <= runner.numberJumps)
					{
						upgradeButton.ar[i].buyed = true;
					}
				}
				else if (upgradeButton.ar[i].varNum==6)
				{
					if (upgradeButton.ar[i].newVal <= runner.trickPwr)
					{
						upgradeButton.ar[i].buyed = true;
					}
				}
				if (upgradeButton.ar[i].buyed == false)
				{
					upgradeButton.ar[i].gotoAndStop(1);
				}
				else
				{
					upgradeButton.ar[i].gotoAndStop(2);
				}
			}
			var hover = false;
			for (i=0; i<upgradeButton.ar.length; i++)
			{
				if (upgradeButton.ar[i].hitTestPoint(runner.main.mouseX,runner.main.mouseY,true))
				{
					if (upgradeButton.ar[i].varNum == 1)
					{
cashString.updatescore(String("Increases the speed your characters runs at"), PreGameScreen.screen.disc);
					}
					else if (upgradeButton.ar[i].varNum==2)
					{
cashString.updatescore(String("Increases the jump height of your characters"), PreGameScreen.screen.disc);
					}
					else if (upgradeButton.ar[i].varNum==3)
					{
cashString.updatescore(String("Increases the starting distance ahead of extinction"), PreGameScreen.screen.disc);
					}
					else if (upgradeButton.ar[i].varNum==4)
					{
cashString.updatescore(String("Increases the speed at which cash is gained from staying alive"), PreGameScreen.screen.disc);
					}
					else if (upgradeButton.ar[i].varNum==5)
					{
cashString.updatescore(String("Increases the number of jumps which can be performed without landing"), PreGameScreen.screen.disc);
					}
					else if (upgradeButton.ar[i].varNum==6)
					{
cashString.updatescore(String("Increases trick rotation speed when pressing DOWN while mid air"), PreGameScreen.screen.disc);
					}
					if (upgradeButton.ar[i].buyed == false)
					{
						cashString.updatescore(String("-$"+(upgradeButton.ar[i].cost)), PreGameScreen.screen.sub);
						cashString.updatescore(String("=$"+(runner.cash-upgradeButton.ar[i].cost)), PreGameScreen.screen.eql);
					}
					for (var j=0; j<upgradeButton.ar.length; j++)
					{
						if (upgradeButton.ar[j].varNum == upgradeButton.ar[i].varNum && upgradeButton.ar[j].newVal <= upgradeButton.ar[i].newVal)
						{
							upgradeButton.ar[j].gotoAndStop(2);
						}
					}
					hover = true;
					break;
				}
				if (! hover)
				{
cashString.updatescore(String(""), PreGameScreen.screen.disc);
					cashString.updatescore(String(""), PreGameScreen.screen.sub);
					cashString.updatescore(String(""), PreGameScreen.screen.eql);

				}
			}
		}
		public function clicked(event:MouseEvent)
		{
			if (runner.cash >= cost)
			{
				runner.cash -=  cost;
				cashString.updatescore(String("$"+(runner.cash)), PreGameScreen.screen.totalCash);
				if (varNum==1)
				{
					if (newVal>runner.maxSpeed)
					{
						runner.maxSpeed = newVal;
					}
				}
				else if (varNum==2)
				{
					if (newVal>runner.jumpPow)
					{
						runner.jumpPow = newVal;
					}
				}
				else if (varNum==3)
				{
					if (newVal>runner.deathDist)
					{
						runner.deathDist = newVal;
					}
				}
				else if (varNum==4)
				{
					if (newVal>runner.cashGain)
					{
						runner.cashGain = newVal;
					}
				}
				else if (varNum==5)
				{
					if (newVal>runner.numberJumps)
					{
						runner.numberJumps = newVal;
					}
				}
				else if (varNum==6)
				{
					if (newVal>runner.trickPwr)
					{
						runner.trickPwr = newVal;
					}
				}

			}
		}

	}

}