package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	
	public class flingScore extends MovieClip {
		var percentWin;
		
		public function flingScore(score:Number, total:Number) {
			scoreContinue.addEventListener(TouchEvent.TOUCH_TAP, continue_button_clicked);
			if(score == 0) {
				infoTextfield.text = "wow no mice today";
			}
			else {
				percentWin = score / total;
				if(percentWin == 1) {
					infoTextfield.text = score + "out of " + total + "\n\nYou are the God of mice flinging";
				}
				else if(percentWin <= 0.15) {
					infoTextfield.text = "wow only " + score + " out of " + total + "\n\nYour grandma can do better than that";
				}
				else if(percentWin <= 0.35) {
					infoTextfield.text = score + " out of " + total + "\n\nI expected better of you";
				}
				else if(percentWin <= 0.60) {
					infoTextfield.text = score + " out of " + total + "\n\nIf there was an award for most beautiful mouse flinger\n\n you would win it";
				}
				else if(percentWin < 0.80) {
					infoTextfield.text = score + " out of " + total + "\n\nBack in my day\nyou would be crowned sheriff";
				}
				else if(percentWin >= 0.80) {
					infoTextfield.text = score + " out of " + total + "\n\nNice flinging cowboy\n your cat would be proud";
				}
			}
		}
		
		public function unloadScore() {
			scoreContinue.removeEventListener(TouchEvent.TOUCH_TAP, continue_button_clicked);
		}
		
		public function continue_button_clicked(event:TouchEvent) {
			catGame.main.showStartScreen();
		}
	}
	
}
