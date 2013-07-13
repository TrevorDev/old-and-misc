using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace MyGame
{
    public class Player : BasePlayer
    {
        public string Name;
        public Boolean owner = false;
        public Boolean ready = false;
        public float x = 0;
        public float y = 0;
        //location last state update
        public float oldX = 0;
        public float oldY = 0;
        public float speed = 10;
        public float maxSpeed = 10;
        public float xSpeed = 0;
        public float ySpeed = 0;
        public float xAccel = 1;
        public float yAccel = 1;
        // character item types
        public int hatType = 0;
        public int torsoType = 0;
        public int feetType = 0;
        // character level/experience
        public int level = 1;
        public int experience = 0;
    }

    [RoomType("MyGame")]
    public class GameCode : Game<Player>
    {
        Random rand = new Random();
        DateTime oldTickTime = new DateTime();
        DateTime oldStateTime = new DateTime();
        TimeSpan diff = new TimeSpan();
        bool doState = false;
        bool inGame = false;
        String mapName = "lev114";
        DatabaseArray enemyArray;

        public override void GameStarted()
        {
            // allow tons of people, for stress test
            this.PreloadPlayerObjects = true;
            oldTickTime = DateTime.Now;
            oldStateTime = DateTime.Now;
            Console.WriteLine("map" + RoomData["map"]);
            // Add game tick every 50 ms
            AddTimer(tick, 50);
        }

        // called every 50 ms
        private void tick()
        {
            //Get the time elapsed since the last tick
            DateTime newTime = DateTime.Now;
            diff = newTime - oldTickTime;
            //The difference in ms
            int msDiff = diff.Milliseconds;
            //Renew the time of the last update
            oldTickTime = newTime;

            if (inGame)
            {
                if (enemyArray != null)
                {
                    for (var i = 0; i < enemyArray.Count; i++)
                    {
                        // enemy going right
                        if (enemyArray.GetArray(i).GetBool(4))
                        {
                            if (enemyArray.GetArray(i).GetDouble(0) > enemyArray.GetArray(i).GetDouble(3))
                            {
                                enemyArray.GetArray(i).Set(4, false);
                                Broadcast("direct", i, enemyArray.GetArray(i).GetDouble(0), false);
                            }
                            enemyArray.GetArray(i).Set(0, enemyArray.GetArray(i).GetDouble(0) + enemyArray.GetArray(i).GetInt(5));
                        }
                        // enemy going left
                        else
                        {
                            if (enemyArray.GetArray(i).GetDouble(0) < enemyArray.GetArray(i).GetDouble(2))
                            {
                                enemyArray.GetArray(i).Set(4, true);
                                Broadcast("direct", i, enemyArray.GetArray(i).GetDouble(0), true);
                            }
                            enemyArray.GetArray(i).Set(0, enemyArray.GetArray(i).GetDouble(0) - enemyArray.GetArray(i).GetInt(5));
                        }
                    }
                }
            }
            //// Sends the state update every other tick
            //if (doState)
            //{
            //    //Compute the time since the last update was sent
            //    diff = newTime - oldStateTime;
            //    msDiff = diff.Milliseconds;

            //    //Compose the state message
            //    Message stateUpdate = Message.Create("state");
            //    stateUpdate.Add(msDiff);
            //    //Put all users into the same message
            //    foreach (Player guy in Players)
            //    {
            //        //Only send an update if the user has changed position
            //        if (guy.oldX != guy.x || guy.oldY != guy.y)
            //        {
            //            stateUpdate.Add(guy.Id, guy.x, guy.y);
            //            guy.oldX = guy.x;
            //            guy.oldY = guy.y;
            //        }
            //    }
            //    Broadcast(stateUpdate);
            //    doState = false;
            //    oldStateTime = newTime;
            //}
            //else
            //{
            //    doState = true;
            //}
        }

        public override void GotMessage(Player player, Message m)
        {
            //Get the current time
            DateTime newTime = DateTime.Now;
            diff = newTime - oldStateTime;
            //Get the difference from last state update in ms
            int msDiff = diff.Milliseconds;

            //Record and re-route keypresses
            switch (m.Type)
            {
                case "pos":
                    if (inGame)
                    {
                        Broadcast("pos", player.Id, m.GetInt(1), m.GetInt(2),m.GetInt(3),m.GetInt(4));
                        player.x = m.GetInt(1);
                        player.y = m.GetInt(2);
                        player.xSpeed = m.GetInt(3);
                        player.ySpeed = m.GetInt(4);
                    }
                    break;
                case "chat":
                    Broadcast("chat", player.Id, m.GetString(0));
                    break;
                case "ready":
                    // only the room owner can send the startGame command
                    if (player.owner)
                    {
                        bool canStart = true;
                        // check if all the players are ready
                        foreach (Player guy in Players)
                        {
                            if (guy.owner == false)
                            {
                                if (guy.ready == false)
                                {
                                    canStart = false;
                                    Broadcast("chat", -2, guy.Name + " is not ready.");
                                }
                            }
                        }
                        if (canStart == true)
                        {
                            Broadcast("startTheGame");
                            inGame = true;
                            PlayerIO.BigDB.Load("Maps", mapName, loadMapInfo);
                            RoomData["inProgress"] = "1";
                            RoomData.Save();
                            foreach (Player guy in Players)
                            {
                                Broadcast("userJoined", guy.Id, guy.x, guy.y);
                            }
                        }
                    }
                    player.ready = true;
                    Broadcast("ready",player.Id);
                    break;
            }
        }

        //When a user enters this game instance
        public override void UserJoined(Player player)
        {
            Console.WriteLine("players " + PlayerCount);
            if (PlayerCount == 1)
            {
                player.owner = true;
            }
            player.Name = "the name";
            // create a DB object for the character.
            //createCharacter(player, "bobby", 0, 1, 5);
            player.x = rand.Next(250);
            player.y = rand.Next(250);

            if (inGame)
            {
                player.Send("startTheGame");

            }
            //Make a message to bring the new player up to speed
            Message upToSpeed = Message.Create("info");
            upToSpeed.Add(player.Id);
            //Add all the player's data
            foreach (Player guy in Players)
            {
                if (guy != player)
                {
                    upToSpeed.Add(guy.Id, guy.x, guy.y);
                }
            }
            player.Send(upToSpeed);

            Broadcast("userJoined", player.Id, player.x, player.y);
            foreach (Player guy in Players)
            {
                if(guy != player)
                    player.Send("playerName", guy.Id, guy.Name);
                if (guy.ready)
                {
                    player.Send("ready", guy.Id);
                }
            }
            Broadcast("playerName", player.Id, "the name");
                        foreach (Player guy in Players)
            {
                if (guy.owner)
                {
                    player.Send("theOwner", guy.Id);
                }
            }
        }

        public override bool AllowUserJoin(Player player)
        {
            int maxPlayers;
            // try to parse RoomData
            if (!int.TryParse(RoomData["maxPlayers"], out maxPlayers)) {
                maxPlayers = 4; //Default
	        }
            if (PlayerCount < maxPlayers)
            {
                PlayerIO.BigDB.LoadOrCreate("connectedUsers", player.ConnectUserId,
                    delegate(DatabaseObject result)
                    {
                        //empty object
                        if (!result.Contains("inRoom"))
                        {
                            result.Set("inRoom", true);
                            result.Save(null);
                        }
                        else
                        {
                            bool inRoom = result.GetBool("inRoom");
                            if (inRoom == true)
                            {
                                player.Send("ConnectOverflow");
                                player.Disconnect();
                            }
                            else
                            {
                                result.Set("inRoom", true);
                                result.Save(null);
                            }
                        }
                    }
                 );
                    return true;
            }
            return true;
        }

        public void removeFromRoomDB(Player player)
        {
            Console.WriteLine("removing2 " + player.ConnectUserId);
            PlayerIO.BigDB.DeleteKeys("connectedUsers", player.ConnectUserId);


        }

        //When a user leaves the game instance
        public override void UserLeft(Player player)
        {
            Console.WriteLine("removing " + player.ConnectUserId);
            removeFromRoomDB(player);
            Broadcast("userLeft", player.Id);
            // if the room maker leaves
            if (player.owner == true)
            {
                foreach (Player guy in Players)
                {
                    // if the next owner isnt the same old owner.
                    if (guy.Id != player.Id)
                    {
                        guy.owner = true;
                        Broadcast("theOwner", guy.Id);
                        break;
                    }
                }
            }
        }

        public void loadMapInfo(DatabaseObject mapTable)
        {
            enemyArray = mapTable.GetArray("bad");
            // x pos
        }

        public void createCharacter(Player player, string Name, int hatID, int chestID, int feetID)
        {
            DatabaseObject thePlayer = new DatabaseObject();
            thePlayer.Set("Name", Name);

            thePlayer.Set("Hat", hatID);
            thePlayer.Set("Chest", chestID);
            thePlayer.Set("Feet", feetID);

            thePlayer.Set("Level", 1);
            thePlayer.Set("Experience", 0);

            //Save thePlayer to table "Players" under key "testplay"
           // PlayerIO.BigDB.CreateObject("Players", "testplay", thePlayer, null);
        }


        public void createCharacterFailed(PlayerIOError error)
        {
            Console.WriteLine("Error creating object: ");
        }
    }

    [RoomType("Store")]
    public class StoreCode : Game<Player>
    {

	
    }
}