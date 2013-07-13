package  {
	
	import playerio.*;
	import serverHandler;
	import flash.display.MovieClip;
	
	public class DBexport extends MovieClip {
		
		public var connection:serverHandler;
		
		public function DBexport(conn:serverHandler) {
			connection = conn;
			
			writeToDB("lev119" );
		}
		
		public function writeToDB(mapName:String)
		{
			var obj:DatabaseObject = new DatabaseObject();
			
			// creating the database array for each button
			var buttonArray:DatabaseObject = new DatabaseObject();
			// need this to put into an array
			obj.buttons = []
			//loop through all the buttons
			for (var i = 0; i < button.buttons.length;i++)
			{
				// put the x and y buttons into an object
				buttonArray.myarray = [button.buttons[i].x,button.buttons[i].y]
				// put the coordinates object into the buttons array
				obj.buttons[i] = buttonArray.myarray
			}
			
			
			// creating the database array for each activation
			var activateArray:DatabaseObject = new DatabaseObject();
			// need this to put into an array
			obj.activated = []
			//loop through all the activated
			for (i = 0; i < activated.activateds.length;i++)
			{
				// put the x and y activated into an object
				activateArray.myarray = [activated.activateds[i].x,activated.activateds[i].y]
				// put the coordinates object into the buttons array
				obj.activated[i] = activateArray.myarray
			}
			
			// creating the database array for each activation
			var badArray:DatabaseObject = new DatabaseObject();
			// need this to put into an array
			obj.bad = []
			//loop through all the activated
			for (i = 0; i < bad1.badGuys.length;i++)
			{
				// put the x and y activated into an object
				badArray.myarray = [Number(bad1.badGuys[i].x+0.00001),Number(bad1.badGuys[i].y+0.00001), Number((bad1.badGuys[i].x - bad1.badGuys[i].distance/2)+0.00001),Number((bad1.badGuys[i].x + bad1.badGuys[i].distance/2)+0.00001),bad1.badGuys[i].direction,bad1.badGuys[i].speed]
				// put the coordinates object into the buttons array
				obj.bad[i] = badArray.myarray
			}
			
			connection.theClient.bigDB.createObject("Maps",mapName,obj,null,function(error){trace(error)});
		}
		
	
	}
}