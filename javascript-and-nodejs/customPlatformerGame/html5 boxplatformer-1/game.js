var gravity = 0.3;
var context;
var canvas;
var frameTime;

function clearScreen() {
    context.clearRect(0, 0, canvas.width, canvas.height);
}

function movieClip(pos, dim) {
    this.pos = pos;
    this.dim = dim;
}
var maxi=0;
function frameTimer() {
    this.time = 0;
    this.dt = 0;
    this.getTimePassed = function() {
        var now = new Date().getTime();
        this.dt = now - (this.time || now);
        this.time = now;
        this.dt /= (15);
        if(maxi<this.dt){
            maxi=this.dt;
        }
        if(this.dt>1.6){
            this.dt=0;
        }
        console.log(this.dt+"  "+maxi);
    }
}

function vec2(x, y) {
    this.x = x;
    this.y = y;
    this.scaleMult = function(num) {
        return new vec2(this.x * num, this.y * num);
    }
    this.copy = function() {
        return new vec2(this.x, this.y);
    }
    this.add = function(vec) {
        return new vec2(this.x + vec.x, this.y + vec.y);
    }
}

function block(pos, dim, color) {
    movieClip.call(this, pos, dim);
    block.ar.push(this);
    this.draw = function() {
        context.fillStyle = this.color;
        context.fillRect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    }
    this.calcPoints = function() {
        for (var i = 0; i < 2; i++) {
            for (var j = 0; j < 2; j++) {
                this.points[i * 2 + j] = new vec2(this.pos.x + (j * (this.dim.x)), this.pos.y + (i * (this.dim.y)));
            }
        }
    }
    this.points = new Array();
    this.calcPoints();
    this.color = color;
}
block.ar = new Array();

function player(pos, dim, color) {
    movieClip.call(this, pos, dim);
    this.calcPoints = function() {
        for (var i = 0; i < 2; i++) {
            for (var j = 0; j < 2; j++) {
                this.points[i * 2 + j] = new vec2(this.pos.x + (j * (this.dim.x)), this.pos.y + (i * (this.dim.y)));
            }
        }
    }

    this.move = function() {
        this.spd.y += gravity * frameTime.dt;
        this.pos = this.pos.add(this.spd.scaleMult(frameTime.dt));
        this.calcPoints();
        for (var b = 0; b < block.ar.length; b++) {
                var dist = new Array();
                dist.push((this.dim.y + block.ar[b].dim.y) - (Math.max(this.points[0].y, this.points[2].y, block.ar[b].points[2].y, block.ar[b].points[0].y)-Math.min(this.points[0].y, this.points[2].y, block.ar[b].points[2].y, block.ar[b].points[0].y)));
                dist.push((this.dim.x + block.ar[b].dim.x) - (Math.max(this.points[0].x, this.points[1].x, block.ar[b].points[1].x, block.ar[b].points[0].x)-Math.min(this.points[0].x, this.points[1].x, block.ar[b].points[1].x, block.ar[b].points[0].x)));
                
                if(dist[0]>0&&dist[1]>0){
                    if(dist[0]<dist[1]){
                        if(this.points[2].y==Math.max(this.points[0].y, this.points[2].y, block.ar[b].points[2].y, block.ar[b].points[0].y)){
                            this.pos.y+=dist[0];
                        }else{
                            this.pos.y-=dist[0];
                        }
                        this.spd.y=0;
                    }else{
                       if(this.points[1].x==Math.max(this.points[0].x, this.points[1].x, block.ar[b].points[1].x, block.ar[b].points[0].x)){
                            this.pos.x+=dist[1];
                       }else{
                            this.pos.x-=dist[1];
                       } 
                       this.spd.x=0;
                    }
                    
                    
                }
                
                
            
        }
         this.calcPoints();
    }
    this.checkInput = function() {
        if (isKeyDown(keyEnum.W_Key)) {
            this.spd.y = -5;
        }
        if (isKeyDown(keyEnum.S_Key)) {
            this.spd.y = 5;
        }
        if (isKeyDown(keyEnum.A_Key)) {
            if (this.spd.x > -this.maxSpd) {
                this.spd.x -= 0.7 * frameTime.dt;
            }
        }
        if (isKeyDown(keyEnum.D_Key)) {
            if (this.spd.x < this.maxSpd) {
                this.spd.x += 0.7 * frameTime.dt;
            }
        }
    }
    this.draw = function() {
        context.fillStyle = this.color;
        context.fillRect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    }



    this.points = new Array();
    this.calcPoints();
    this.maxSpd = 3;
    this.spd = new vec2(0, 0);
    this.color = color;
}


function onLoading() {

    canvas = document.getElementById("myCanvas");
    context = canvas.getContext("2d");
    frameTime = new frameTimer();
    canvas.focus();
    canvas.addEventListener("keydown", handlekeydown, true);
    canvas.addEventListener("keyup", onKeyUp, true);
    var guy = new player(new vec2(5, 5), new vec2(30, 30), "#FF0000");
    var b1 = new block(new vec2(300, 300), new vec2(30, 90), "#514949");
    var b2 = new block(new vec2(0, 400), new vec2(500, 30), "#514949");
    var mainloop = function() {
            clearScreen();
            frameTime.getTimePassed();
            guy.checkInput();
            guy.move();
            guy.draw();
            //b2.pos.y-=0.3;
            b2.calcPoints();
            b1.draw();
            b2.draw();
            

        };

    var animFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || null;
    if (animFrame !== null) {
        var recursiveAnim = function() {
                mainloop();
                animFrame(recursiveAnim, canvas);
            };
        // start the mainloop
        animFrame(recursiveAnim, canvas);
    } else {
        var ONE_FRAME_TIME = 1000.0 / 60.0;
        setInterval(mainloop, ONE_FRAME_TIME);
    }
}

var keyEnum = {
    W_Key: 0,
    A_Key: 1,
    S_Key: 2,
    D_Key: 3
};
var keyArray = new Array(4);

var handlekeydown = function onKeyDown(event) {

        var key = ('which' in event) ? event.which : event.keyCode;
        // Detect which key was pressed
        if (key == 'W'.charCodeAt(0)) {

            keyArray[keyEnum.W_Key] = true;
        }
        if (key == 'A'.charCodeAt(0)) {

            keyArray[keyEnum.A_Key] = true;
        }
        if (key == 'S'.charCodeAt(0)) {

            keyArray[keyEnum.S_Key] = true;
        }
        if (key == 'D'.charCodeAt(0)) {

            keyArray[keyEnum.D_Key] = true;
        }
    }

function onKeyUp(event) {
    var key = ('which' in event) ? event.which : event.keyCode;
    // Detect which key was released
    if (key == 'W'.charCodeAt(0)) {
        keyArray[keyEnum.W_Key] = false;
    }
    if (key == 'A'.charCodeAt(0)) {

        keyArray[keyEnum.A_Key] = false;
    }
    if (key == 'S'.charCodeAt(0)) {

        keyArray[keyEnum.S_Key] = false;
    }
    if (key == 'D'.charCodeAt(0)) {

        keyArray[keyEnum.D_Key] = false;
    }
    // Repeat for each key you care about...
}

function isKeyDown(key) {
    return keyArray[key];
}