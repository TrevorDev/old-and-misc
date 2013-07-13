package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class playingScreen extends MovieClip {
		static var xDim = 12;
		static var yDim = 6;
		static var grid:Array = new Array(); 
		static var blockWid = 800/xDim;
		static var blockHigh = (480-40)/yDim;
		var guy;
		static var screen;
		static public function setArVal(grid, xVal, yVal, val){
			grid[xVal+yVal*xDim] = val;
		}
		
		static public function getArVal(grid, xVal, yVal){
			if(xVal<0||xVal>=xDim||yVal<0||yVal>=yDim){
				return 0;
			}
			return grid[xVal+yVal*xDim];
		}
		
		static public function getArValGen(grid, xVal, yVal){
			if(xVal<0||xVal>=xDim||yVal<0||yVal>=yDim){
				return 1;
			}
			return grid[xVal+yVal*xDim];
		}
		
		static public function setBlank(grid){
			for(var i = 0; i < xDim*yDim;i++){
				grid[i]=0;
			}
		}
		
		public function playingScreen() {
			screen=this;
			guy=new cat;
			guy.width=blockWid;
			guy.height=blockHigh;
			drawBoard();
			addEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin);
		}
		
		public function onTouchBegin(e:MouseEvent) {
			var hitX = xGetGrid(e.stageX);
			var hitY = yGetGrid(e.stageY);
			if(getArValGen(grid, hitX, hitY)==0){
			guy.goPosX=hitX;
			guy.goPosY=hitY;
			guy.moving=true;
			}
			
		}
		
		public function drawBoard() {
			var xPos;
			var yPos;
			
			setBlank(grid);
			
			var guyPosX=1+Math.floor(Math.random()*(xDim-3));
			var guyPosY=1+Math.floor(Math.random()*(yDim-3));
			guy.x=xGrid(guyPosX);
			guy.y=yGrid(guyPosY);
			guy.posX=guyPosX;
			guy.posY=guyPosY;
			guy.goPosX=guyPosX;
			guy.goPosY=guyPosY;
			setArVal(grid,guyPosX,guyPosY,12);
			catL.addChild(guy);
			
			var cheesePosX=guy.posX;
			var cheesePosY=guy.posY;
			while(cheesePosX==guy.posX&&cheesePosY==guy.posY){
				cheesePosX=3+Math.floor(Math.random()*(xDim-6));
				cheesePosY=3+Math.floor(Math.random()*(yDim-3-2));
			}
			//trace(cheesePosX);
			//trace(cheesePosY);
			var cheeseBlock = new cheese;
			cheeseBlock.posX=cheesePosX;
			cheeseBlock.posY=cheesePosY;
			cheeseBlock.x=xGrid(cheeseBlock.posX);
			cheeseBlock.y=yGrid(cheeseBlock.posY);
			setArVal(grid,cheeseBlock.posX,cheeseBlock.posY,3);
			cheeseL.addChild(cheeseBlock);
			
			for(var i =0;i<xDim;i++){
				xPos=i*blockWid;
				for(var j=0;j<yDim;j++){
					yPos=j*blockHigh;
					
					var block = new tile;
					block.x=xPos;
					block.y=yPos;
					block.width=blockWid;
					block.height=blockHigh;
					tileL.addChild(block);
					
					if(getArValGen(grid,i,j)==0&&getArValGen(grid,i+1,j+1)==0&&getArValGen(grid,i-1,j-1)==0&&getArValGen(grid,i-1,j+1)==0&&getArValGen(grid,i+1,j-1)==0){
						var rand = Math.random();
						if(rand<0.4){
							var block = new wall;
							setArVal(grid,i,j,1);
							block.x=xPos;
							block.y=yPos;
							block.width=blockWid;
							block.height=blockHigh;
							wallL.addChild(block);
						}/*else if(rand<0.45){
							var block2 = new cheese();
							setArVal(grid,i,j,2);
							block2.x=xPos;
							block2.y=yPos;
							block2.posX=i;
							block2.posY=j;
							cheeseL.addChild(block2);
						}*/
					}
				}
			}
			setArVal(grid,guy.posX,guy.posY,0);
			mouse.reload();
			this.addEventListener(Event.ENTER_FRAME, mouse.spawner);
		}
		
		public static function unloader(){
			cat.catThis.removeEventListener(Event.ENTER_FRAME, cat.catThis.doCatStuff);
			playingScreen.screen.removeEventListener(MouseEvent.MOUSE_DOWN, playingScreen.screen.onTouchBegin);
			playingScreen.screen.removeEventListener(Event.ENTER_FRAME, mouse.spawner);
			for(var f = 0;f<mouse.ar.length;f++){
				mouse.ar[f].removeEventListener(Event.ENTER_FRAME, mouse.ar[f].doMouseStuff);
				playingScreen.screen.mouseL.removeChild(mouse.ar[f]);
				mouse.ar.splice(f,1);
			}
		}
		
		public static function xGrid(grid){
			var ret = grid*blockWid;
			return ret;
		}
		public static function yGrid(grid){
			var ret = grid*blockHigh;
			return ret;
		}
		
		public static function xGetGrid(pos){
			var ret = Math.floor(pos/blockWid);
			return ret;
		}
		public static function yGetGrid(pos){
			var ret = Math.floor(pos/blockHigh);
			return ret;
		}
	}
	
}
