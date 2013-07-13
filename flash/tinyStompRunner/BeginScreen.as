package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	public class BeginScreen extends MovieClip {
		
		
		public function BeginScreen() {
			runner.menuSong();
			start_button.addEventListener(MouseEvent.CLICK, start_button_clicked);
			help_button.addEventListener(MouseEvent.CLICK, help_button_clicked);
			full_button.addEventListener(MouseEvent.CLICK, runner.goFullScreen);
			clr_button.addEventListener(MouseEvent.CLICK, runner.erase);
			mute_button.addEventListener(MouseEvent.CLICK, runner.muter);
			usr1.addEventListener(MouseEvent.CLICK, uOne);
			usr2.addEventListener(MouseEvent.CLICK, uTwo);
			usr3.addEventListener(MouseEvent.CLICK, uThree);
			if(runner.user=="1"){
				this.usr1.gotoAndStop(2);
			}else{
				this.usr1.gotoAndStop(1);
			}
			if(runner.user=="2"){
				this.usr2.gotoAndStop(2);
			}else{
				this.usr2.gotoAndStop(1);
			}
			if(runner.user=="3"){
				this.usr3.gotoAndStop(2);
			}else{
				this.usr3.gotoAndStop(1);
			}
		}
		
		public function start_button_clicked(event:MouseEvent) {
			if(runner.day!=0){
			transition.addScreen(runner.main.show_preScreen);
			}else{
				transition.addScreen(runner.main.intro);
			}
		}
		
		public function help_button_clicked(event:MouseEvent) {
			transition.addScreen(runner.main.show_helpScreen);
		}
		
		public function uOne(event:MouseEvent) {
			runner.user="1";
			runner.loades();
			if(runner.user=="1"){
				this.usr1.gotoAndStop(2);
			}else{
				this.usr1.gotoAndStop(1);
			}
			if(runner.user=="2"){
				this.usr2.gotoAndStop(2);
			}else{
				this.usr2.gotoAndStop(1);
			}
			if(runner.user=="3"){
				this.usr3.gotoAndStop(2);
			}else{
				this.usr3.gotoAndStop(1);
			}
		}
		
		public function uTwo(event:MouseEvent) {
			runner.user="2";
			runner.loades();
			if(runner.user=="1"){
				this.usr1.gotoAndStop(2);
			}else{
				this.usr1.gotoAndStop(1);
			}
			if(runner.user=="2"){
				this.usr2.gotoAndStop(2);
			}else{
				this.usr2.gotoAndStop(1);
			}
			if(runner.user=="3"){
				this.usr3.gotoAndStop(2);
			}else{
				this.usr3.gotoAndStop(1);
			}
		}
		
		public function uThree(event:MouseEvent) {
			runner.user="3";
			runner.loades();
			if(runner.user=="1"){
				this.usr1.gotoAndStop(2);
			}else{
				this.usr1.gotoAndStop(1);
			}
			if(runner.user=="2"){
				this.usr2.gotoAndStop(2);
			}else{
				this.usr2.gotoAndStop(1);
			}
			if(runner.user=="3"){
				this.usr3.gotoAndStop(2);
			}else{
				this.usr3.gotoAndStop(1);
			}
		}
		
		
		
	}
	
}
