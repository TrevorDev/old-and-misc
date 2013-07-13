using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace MyGame
{
    public class badGuy
    {
        public double x, y, leftX, rightX;
        public int exp, health, speed, type, id;
        public bool alive, direction;

        public badGuy(int eType, double xpos, double ypos, int givenExp, int hp, bool dir, int speed, int id,double leftX,double rightX)
        {
            this.type = eType;
            this.x = xpos;
            this.y = ypos;
            this.exp = givenExp;
            this.health = hp;
            this.direction = dir;
            this.speed = speed;
            this.id = id;
            alive = true;
            this.leftX = leftX;
            this.rightX = rightX;

        }
    }

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
        public int headID = 1;
        public int eyeID = 1;
        public int bodyID = 1;
        public int footID = 1;
        public int footDamage = 5;
        public int weaponDamage = 10;
        // character level/experience
        public int level = 1;
        public int experience = 0;
        public bool guest = false;
    }

    [RoomType("MyGame")]
    public class GameCode : Game<Player>
    {
        Random rand = new Random();
        DateTime oldTickTime = new DateTime();
        DateTime oldStateTime = new DateTime();
        TimeSpan diff = new TimeSpan();
        bool inGame = false;
        List<badGuy> badGuyList = new List<badGuy>();


        String mapName = "lev119";
        DatabaseArray enemyArray;

        public override void GameStarted()
        {
            // allow tons of people, for stress test

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
                foreach (badGuy bad in badGuyList)
                {
                    if (bad.alive)
                    {
                        // going right
                        if (bad.direction)
                        {
                            if (bad.x > bad.rightX)
                            {
                                bad.direction = false;
                                Broadcast("direct", bad.id, bad.x, false);
                            }
                            bad.x += bad.speed;
                        }
                        // going left
                        else
                        {
                            if (bad.x < bad.leftX)
                            {
                                bad.direction = true;
                                Broadcast("direct", bad.id, bad.x, true);
                            }
                            bad.x -= bad.speed;
                        }
                    }
                }
            }
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
                        foreach (Player guy in Players)
                        {
                            if (guy.Id != player.Id)
                            {
                                guy.Send("pos", player.Id, m.GetInt(1), m.GetInt(2), m.GetInt(3), m.GetInt(4));
                            }
                        }
                        player.x = m.GetInt(1);
                        player.y = m.GetInt(2);
                        player.xSpeed = m.GetInt(3);
                        player.ySpeed = m.GetInt(4);
                    }
                    break;
                case "chat":
                    Broadcast("chat", player.Id, m.GetString(0));
                    break;
                case "actOn":
                    Broadcast("actOn", m.GetInt(1));
                    break;
                case "actOff":
                    Broadcast("actOff", m.GetInt(1));
                    break;
                case "fhit":
                    int dmg0 = 0;
                    foreach (Player guy in Players)
                    {
                        if (guy.Id == m.GetInt(0))
                        {
                            dmg0 = guy.footDamage;
                        }
                    }
                    foreach (badGuy bad in badGuyList)
                    {
                        if (bad.alive)
                        {
                            if (bad.id == m.GetInt(1))
                            {
                                Broadcast("fhit", dmg0,m.GetInt(1));
                                Console.WriteLine("badheath1: " + bad.health);
                                bad.health -= dmg0;
                                Console.WriteLine("badheath2: " + bad.health);
                                if (bad.health <= 0)
                                {
                                    bad.alive = false;
                                    Broadcast("edead", m.GetInt(1));
                                }
                            }
                        }
                    }
                    break;
                case "whit":
                    int dmg1 = 0;
                    foreach (Player guy in Players)
                    {
                        if (guy.Id == m.GetInt(0))
                        {
                            dmg1 = guy.weaponDamage;
                        }
                    }
                    foreach (badGuy bad in badGuyList)
                    {
                        if (bad.alive)
                        {
                            if (bad.id == m.GetInt(1))
                            {
                                Broadcast("whit", dmg1,m.GetInt(1));
                                Console.WriteLine("badheath1: "+ bad.health);
                                bad.health -= dmg1;
                                Console.WriteLine("badheath2: "+ bad.health);
                                if (bad.health <= 0)
                                {
                                    bad.alive = false;
                                    Broadcast("edead", m.GetInt(1));
                                }
                            }
                        }
                    }
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
                                getPlayerItems(guy);
                                // send the player everyone elses info.
                                //foreach (Player guy2 in Players)
                                //{
                                //    if (guy2.Id != guy.Id)
                                //    {
                                //        guy.Send("reCharInfo", guy2.Id, guy2.headID, guy2.eyeID, guy2.bodyID, guy2.footID);
                                //    }
                                //}
                            }
                            sendNames();
                        }
                    }
                    player.ready = true;
                    if(!player.owner)
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

            if (String.Compare(player.ConnectUserId.Substring(0, 6), "Guest-") == 0)
            {
                player.guest = true;
                player.Name = player.ConnectUserId;
            }
            else if (String.Compare(player.ConnectUserId.Substring(0, 6), "simple") == 0)
            {
                player.Name = player.ConnectUserId.Substring(6, player.ConnectUserId.Length-6);
            }
            else
            {
                player.Name = "someone";
                player.Disconnect();
            }
            // create a DB object for the character.
            //createCharacter(player, "bobby", 0, 1, 5);
            player.x = rand.Next(250);
            player.y = rand.Next(250);

            if (inGame)
                player.Send("startTheGame");
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
                        getPlayerItems(player);

            foreach (Player guy in Players)
            {
                if(guy != player)
                    player.Send("playerName", guy.Id, guy.Name);
                if (guy.ready)
                {
                    player.Send("ready", guy.Id);
                }
            }
            Broadcast("playerName", player.Id, player.Name);
            foreach (Player guy in Players)
            {
                if (guy.owner)
                {
                    player.Send("theOwner", guy.Id);
                }
            }


            // send the player the dead enemies
            foreach (badGuy bad in badGuyList)
            {
                if (!bad.alive)
                {
                    player.Send("edead", bad.id);
                }
            }

            // send the player everyone elses info.
            foreach (Player guy in Players)
            {
                if (guy.Id != player.Id)
                {
                    player.Send("reCharInfo", guy.Id, guy.headID, guy.eyeID, guy.bodyID, guy.footID);
                }
            }
        }

        public void sendNames()
        {
            foreach (Player guy in Players)
            {
                    Broadcast("playerName", guy.Id, guy.Name);
            }
        }


        //When a user leaves the game instance
        public override void UserLeft(Player player)
        {
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
            int enemyID = 0;
            foreach (DatabaseArray I in enemyArray)
            {
                badGuy bad = new badGuy(0, I.GetDouble(0), I.GetDouble(1), 10, 10, I.GetBool(4), I.GetInt(5), enemyID,I.GetDouble(2),I.GetDouble(3));
                badGuyList.Add(bad);
                enemyID++;
            }

        }

        public void createCharacterFailed(PlayerIOError error)
        {
            Console.WriteLine("Error creating object: ");
        }

        public void getPlayerItems(Player rePlayer)
        {
            if (String.Compare(rePlayer.ConnectUserId.Substring(0, 6), "simple") == 0)
            {
                PlayerIO.BigDB.Load("Players", rePlayer.ConnectUserId, delegate(DatabaseObject obj)
                {
                    Message charInfo = Message.Create("charStatus");
                    charInfo.Add(obj.GetInt("Head"));
                    charInfo.Add(obj.GetInt("Eye"));
                    charInfo.Add(obj.GetInt("Body"));
                    charInfo.Add(obj.GetInt("Feet"));
                    charInfo.Add(obj.GetInt("Level"));
                    // store the database object on the server
                    rePlayer.headID = obj.GetInt("Head");
                    rePlayer.eyeID = obj.GetInt("Eye");
                    rePlayer.bodyID = obj.GetInt("Body");
                    rePlayer.footID = obj.GetInt("Feet");
                    rePlayer.level = obj.GetInt("Level");
                    // broadcast the player information to everyone else
                    foreach (Player guy in Players)
                    {
                        if (guy.Id != rePlayer.Id)
                        {
                            guy.Send("reCharInfo", rePlayer.Id, rePlayer.headID, rePlayer.eyeID, rePlayer.bodyID, rePlayer.footID, rePlayer.level);
                        }
                    }
                }
                );
            }
        }
    }

    [RoomType("Store")]
    public class StoreCode : Game<Player>
    {
        public Player thePlayer;
         //When a user enters this game instance
        public override void UserJoined(Player player)
        {
            thePlayer = player;
        }

        public override void GotMessage(Player player, Message m)
        {
            //Record and re-route messages
            switch (m.Type)
            {
                case "makeChar":
                    createCharacter(0,m.GetInt(1), m.GetInt(2), m.GetInt(3));
                    break;
                case "charStatus":
                    PlayerIO.BigDB.Load("Players",player.ConnectUserId,checkCreated,null);
                    break;
            }
        }

        // if their character has already been made
        public void checkCreated(DatabaseObject obj)
        {
            //Make a message to send the player all their data.
            Message charInfo = Message.Create("charStatus");
            charInfo.Add(obj.GetInt("Head"));
            charInfo.Add(obj.GetInt("Eye"));
            charInfo.Add(obj.GetInt("Body"));
            charInfo.Add(obj.GetInt("Feet"));
            charInfo.Add(obj.GetInt("Level"));
            charInfo.Add(obj.GetInt("Experience"));
            charInfo.Add(obj.GetInt("Coins"));

            thePlayer.Send(charInfo);
            Message Inventory = Message.Create("inventory");
            foreach (int invIndex in obj.GetArray("Inventory"))
            {
                Inventory.Add(invIndex);
            }
            thePlayer.Send(Inventory);
        }

        public void createCharacter(int headID, int eyeID, int bodyID, int feetID)
        {
            DatabaseObject thePlayerObj = new DatabaseObject();

            if (eyeID > 3)
                eyeID = 1;
            if (headID > 5)
                headID = 1;
            if (bodyID > 5)
                bodyID = 1;
            if (feetID > 5)
                feetID = 1;

            Console.WriteLine("head " + headID + " eye " + eyeID + " body " + bodyID + " feet " + feetID);
            thePlayerObj.Set("Head", headID);
            thePlayerObj.Set("Eye", eyeID);
            thePlayerObj.Set("Body", bodyID);
            thePlayerObj.Set("Feet", feetID);

            thePlayerObj.Set("Level", 1);
            thePlayerObj.Set("Experience", 0);
            thePlayerObj.Set("Coins", 0);
            thePlayerObj.Set("Inventory", new DatabaseArray());
            thePlayerObj.Set("Inventory.0", 0);

            //Save thePlayer to table "Players" under key "testplay"
            PlayerIO.BigDB.CreateObject("Players", thePlayer.ConnectUserId, thePlayerObj, null);
        }
    }
}