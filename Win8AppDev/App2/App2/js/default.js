// For an introduction to the Blank template, see the following documentation:
// http://go.microsoft.com/fwlink/?LinkId=232509
(function () {
    "use strict";

    WinJS.Binding.optimizeBindingReferences = true;

    var app = WinJS.Application;
    var activation = Windows.ApplicationModel.Activation;

    var appData = Windows.Storage.ApplicationData.current;
    var roamingSettings = appData.roamingSettings;

    var canvas, context, stage;
    var preload;
    var topScore = 0;
    var SCALE_X = window.innerWidth / 800;
    var SCALE_Y = window.innerHeight / 480;
    var MID_X = SCALE_X * 400;
    var MID_Y = SCALE_Y * 240;
    var paused = false;
    function mouseDown(e) {
        //TODO DEVICE SPEED
        if (!paused) {
            if (playerShot.array.length < badGuy.array.length) {
                var y = e.offsetY - (MID_Y);
                var x = e.offsetX - (MID_X);
                var hor = Math.sqrt(x * x + y * y);
                var div = 1 / hor;
                createjs.Sound.play("images/sprites/shoot.wav");
                new playerShot(preload.getResult("player"), new vec2(x * div, y * div));
            }
        }
    }

    function initialize() {
        window.addEventListener("resize", onViewStateChanged);
        canvas = document.getElementById("gameCanvas");
        canvas.onmousedown = mouseDown;
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        context = canvas.getContext("2d");

        preload = new createjs.LoadQueue();
        preload.addEventListener("complete", prepareGame);
        var manifest = [{ id: "player", src: "images/sprites/icecream.png" },
        { id: "icecream", src: "images/sprites/icecream.png" },
        { id: "bad1", src: "images/sprites/bad1.png" },
        { id: "shoot", src: "images/sprites/shoot.wav" }];
        preload.loadManifest(manifest);
    }

    function vec2(x, y) {
        this.x = x;
        this.y = y;
        this.scaleMult = function (num) {
            return new vec2(this.x * num, this.y * num);
        }
        this.copy = function () {
            return new vec2(this.x, this.y);
        }
        this.add = function (vec) {
            return new vec2(this.x + vec.x, this.y + vec.y);
        }
    }

    function playerShot(pic, acc) {
        this.bitmap = new createjs.Bitmap(pic);
        this.bitmap.regX = 25;
        this.bitmap.regY = 25;
        this.bitmap.x = MID_X;
        this.bitmap.y = MID_Y;
        this.spd = new vec2(0, 0);
        this.acc = acc;
        this.frame = 0;
        this.update = function () {
            this.frame++;
            this.spd=this.spd.add(this.acc);
            this.bitmap.x += this.spd.x;
            this.bitmap.y += this.spd.y;
            this.bitmap.rotation++;
            if (this.bitmap.x <= -MID_X * 2 || this.bitmap.x >= MID_X * 2 * 2 || this.bitmap.y <= -MID_Y * 2 || this.bitmap.y >= MID_Y * 2 * 2) {
                for (var i = 0; i < playerShot.array.length; i++) {
                    if (playerShot.array[i] == this) {
                        playerShot.array.splice(i, 1);
                        break;
                    }
                }
            }
        }
        stage.addChild(this.bitmap);
        playerShot.array.push(this);
    }
    playerShot.array = new Array();

    function badGuy(pic, acc, pos) {
        this.bitmap = new createjs.Bitmap(pic);
        this.bitmap.regX = 25;
        this.bitmap.regY = 25;
        this.bitmap.rotation = 25;
        this.bitmap.x = pos.x;
        this.bitmap.y = pos.y;
        this.spd = new vec2(0, 0);
        this.acc = acc;
        this.frame = 0;
        this.update = function () {
            this.frame++;
            this.spd = this.spd.add(this.acc);
            if (this.frame % 30 == 0) {
                this.bitmap.rotation = this.bitmap.rotation * -1;
            }
            this.bitmap.x += this.spd.x;
            this.bitmap.y += this.spd.y;
            if (this.bitmap.x <= -MID_X * 2 || this.bitmap.x >= MID_X * 2 * 2 || this.bitmap.y <= -MID_Y * 2 || this.bitmap.y >= MID_Y * 2 * 2) {
                for(var i =0; i < badGuy.array.length;i++){
                    if (badGuy.array[i] == this) {
                        badGuy.array.splice(i, 1);
                        break;
                    }
                }
            }
        }
        stage.addChild(this.bitmap);
        badGuy.array.push(this);
    }
    badGuy.array = new Array();


    function prepareGame() {
        stage = new createjs.Stage("gameCanvas");
        var icecream = new createjs.Bitmap(preload.getResult("icecream"));
        var bad1 = new createjs.Bitmap(preload.getResult("bad1"));
        icecream.regX = 25;
        icecream.regY = 25;
        icecream.x = MID_X;
        icecream.y = MID_Y;
        icecream.scaleX = SCALE_X;
        icecream.scaleY = SCALE_Y;
        stage.addChild(icecream);
        createjs.Ticker.addEventListener("tick", handleTick);
        createjs.Ticker.setFPS(45);
        var score = 0;
        
        var label = new createjs.Text("Score: " + score + "\nTop: " + topScore, "20px Arial", "black");
        label.textAlign = "center";
        label.x = icecream.x;
        label.y = icecream.y + 30 * SCALE_X;
        label.maxWidth = 100;
        stage.addChild(label);
        var frame = 0;
        var spawnRate = 80;
        var spd = 1;
        function handleTick(event) {
            if (!paused) {
                frame++;
                if (frame % spawnRate == 0) {
                    var deg = Math.random() * 2 * Math.PI;
                    var hor = Math.sqrt(MID_X * MID_X + MID_Y * MID_Y);
                    var x = Math.cos(deg) * hor;
                    var y = Math.sin(deg) * hor;
                    new badGuy(preload.getResult("bad1"), new vec2((-x) * spd / 80000, (-y) * spd / 80000), new vec2(x + MID_X, y + MID_Y));
                }
                for (var i = 0; i < badGuy.array.length; i++) {
                    badGuy.array[i].update();
                    if (ndgmr.checkPixelCollision(badGuy.array[i].bitmap, icecream)) {
                        stage.removeChild(badGuy.array[i].bitmap);
                        badGuy.array.splice(i, 1);
                        i--;
                        score = 0;
                        createjs.Sound.play("images/sprites/explode.wav");
                        label.text = "Score: " + score + "\nTop: " + topScore;
                    }
                }
                for (var i = 0; i < playerShot.array.length; i++) {
                    playerShot.array[i].update();
                }
                for (var i = 0; i < playerShot.array.length; i++) {
                    for (var j = 0; j < badGuy.array.length; j++) {

                        if (ndgmr.checkRectCollision(playerShot.array[i].bitmap, badGuy.array[j].bitmap)) {
                            stage.removeChild(badGuy.array[j].bitmap);
                            badGuy.array.splice(j, 1);
                            j--;
                            stage.removeChild(playerShot.array[i].bitmap);
                            playerShot.array.splice(i, 1);
                            i--;
                            score++;
                            createjs.Sound.play("images/sprites/hit.wav");
                            if (score > topScore) {
                                topScore = score;
                                if (topScore != 0) {
                                    roamingSettings.values["topScore"] = topScore;
                                }
                            }
                            label.text = "Score: " + score + "\nTop: " + topScore;
                            break;
                        }
                    }
                }
                if (0) {
                } else if (score >= 1000) {
                    document.body.style.background = '#FFFFFF';
                    spawnRate = 20;
                    spd = 4.2;
                } else if (score >= 300) {
                    document.body.style.background = '#13151A';
                    spawnRate = 20;
                    spd = 4;
                } else if (score >= 150) {
                    document.body.style.background = '#232731';
                    spawnRate = 25;
                } else if (score >= 100) {
                    document.body.style.background = '#424A51';
                    spawnRate = 35;
                } else if (score >= 50) {
                    document.body.style.background = '#7D6565';
                    spd = 3;
                } else if (score >= 20) {
                    document.body.style.background = '#3fa097';
                    spawnRate = 40;
                } else if (score >= 10) {
                    document.body.style.background = '#41848e';
                    spawnRate = 50;
                    spd = 2;
                } else {
                    document.body.style.background = '#7092BE';
                    spawnRate = 80;
                    spd = 1;
                }
            }
                stage.update();
            
        }
    }



    function gameLoop() {
        update();
        draw();
    }

    function update() {
    }

    function draw() {
    }

    app.onactivated = function (args) {
        if (args.detail.kind === activation.ActivationKind.launch) {
            if (roamingSettings.values["topScore"]) {
                topScore = roamingSettings.values["topScore"];
            }

            args.setPromise(WinJS.UI.processAll());
        }
    };

    app.oncheckpoint = function (args) {
        // TODO: This application is about to be suspended. Save any state
        // that needs to persist across suspensions here. You might use the
        // WinJS.Application.sessionState object, which is automatically
        // saved and restored across suspension. If you need to complete an
        // asynchronous operation before your application is suspended, call
        // args.setPromise().
        
        if (topScore!=0) {
            roamingSettings.values["topScore"] = topScore;
        }
    };
    app.onsettings = function (e) {
        e.detail.applicationcommands = {
            "privacyDiv": { title: "Privacy", href: "policy.html" }
        };
        WinJS.UI.SettingsFlyout.populateSettings(e);
    };



    var pauseLabel = new createjs.Text("Game Paused\n\nReturn to fullscreen\nto continue playing", "20px Arial", "black");
    pauseLabel.textAlign = "center";
    pauseLabel.maxWidth = 200;
    
    function onViewStateChanged(eventArgs) {
        var viewStates = Windows.UI.ViewManagement.ApplicationViewState, msg;
        var newViewState = Windows.UI.ViewManagement.ApplicationView.value;
        if (newViewState === viewStates.snapped) {
            paused = true;
            pauseLabel.x = window.innerWidth/2;
            pauseLabel.y = window.innerHeight/2;
            stage.addChild(pauseLabel);
        } else if (newViewState === viewStates.filled) {
            paused = false;
            stage.addChild(pauseLabel);
        } else if (newViewState === viewStates.fullScreenLandscape) {
            paused = false;
            stage.removeChild(pauseLabel);
            
        } else if (newViewState === viewStates.fullScreenPortrait) {
            paused = false;
            stage.removeChild(pauseLabel);
        }

    }



    document.addEventListener("DOMContentLoaded", initialize, false);
    app.start();
})();
