package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class dialogue extends MovieClip {
		public static var ar:Array = new Array();
		public var inUse=false;
		public function dialogue() {
			ar.push(this);
		}
		public function displayWords(item:String)
		{
			if(!inUse){
			this.dialogueBox.text = item;
			inUse=true;
			}
		}
		public function hideWords()
		{
			if(inUse){
			this.dialogueBox.text = "";
			inUse=false;
			}
		}
	}
	
}
