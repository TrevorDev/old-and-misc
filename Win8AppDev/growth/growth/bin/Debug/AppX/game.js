var cashM;
var graphs;
var gainInterestLevelB;
function onLoading() {
    //GLOBAL//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var gravity = 0.3;
    var context;
    var canvas;
    var frameTime;

    function clearScreen() {
        context.clearRect(0, 0, canvas.width, canvas.height);
    }

    function frameTimer() {
        this.time = 0;
        this.dt = 0;
        this.getTimePassed = function() {
            var now = new Date().getTime();
            this.dt = now - (this.time || now);
            this.time = now;
            this.dt /= (15);
            if (this.dt > 1.6) {
                this.dt = 0;
            }
        }
    }

    function checkCollision(a1, b1) {
        var dist = new Array();
        dist.push((a1.dim.y + b1.dim.y) - (Math.max(a1.points[0].y, a1.points[2].y, b1.points[2].y, b1.points[0].y) - Math.min(a1.points[0].y, a1.points[2].y, b1.points[2].y, b1.points[0].y)));
        dist.push((a1.dim.x + b1.dim.x) - (Math.max(a1.points[0].x, a1.points[1].x, b1.points[1].x, b1.points[0].x) - Math.min(a1.points[0].x, a1.points[1].x, b1.points[1].x, b1.points[0].x)));

        if (dist[0] > 0 && dist[1] > 0) {
            var spacing = 0.01;
            if (dist[0] < dist[1]) {
                if (a1.points[2].y == Math.max(a1.points[0].y, a1.points[2].y, b1.points[2].y, b1.points[0].y)) {
                    return new vec2(0, dist[0] + spacing);
                } else {
                    return new vec2(0, -(dist[0] + spacing));
                }
            } else {
                if (a1.points[1].x == Math.max(a1.points[0].x, a1.points[1].x, b1.points[1].x, b1.points[0].x)) {
                    return new vec2((dist[1] + spacing), 0);
                } else {
                    return new vec2(-(dist[1] + spacing), 0);
                }
            }
        }
        return new vec2(0, 0);
    }




    //INPUT//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var keyEnum = {
        W_Key: 0,
        A_Key: 1,
        S_Key: 2,
        D_Key: 3,
        E_Key: 4,
        L_Key: 5
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
            if (key == 'E'.charCodeAt(0)) {
                var data="block";
                function add(str){
                    data = data + "," + str;
                }
                for(var i = 0;i<block.ar.length;i++){
                    add(block.ar[i].pos.x);
                    add(block.ar[i].pos.y);
                    add(block.ar[i].dim.x);
                    add(block.ar[i].dim.y);
                }
                var newWindow = window.open("data:application/octet-stream," + data);
            }
            if (key == 'L'.charCodeAt(0)) {
                block.ar = new Array();
                var level = "block,60,480,690,60,360,450,30,30,540,360,30,120,570,360,180,120,0,0,60,600,720,0,90,600,60,540,660,60,60,0,660,60";
                var levelAr = level.split(",");
                mode = "";
                for(var i=0;i<levelAr.length;i++){
                    if(levelAr[i]=="block"){
                        mode=levelAr[i];
                        i++;
                    }
                    if(mode=="block"){
                        var pos = new vec2(parseInt(levelAr[i++]), parseInt(levelAr[i++]));
                        var dim = new vec2(parseInt(levelAr[i++]), parseInt(levelAr[i++]));
                        new block(pos, dim, "#514949");
                        i--;
                    }
                }
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

    function mouseDown(e) {
        if (e.type == "mouseup") {
            var pos = lockToGrid(new vec2(mouseDown.startPos.x, mouseDown.startPos.y));
            var dim = lockToGrid(new vec2(e.offsetX - mouseDown.startPos.x, e.offsetY - mouseDown.startPos.y));

            if (dim.x < 0) {
                pos.x += dim.x;
                dim.x *= -1;
            }
            if (dim.y < 0) {
                pos.y += dim.y;
                dim.y *= -1;
            }

            new block(pos, dim, "#514949");
        } else if (e.type == "mousedown") {
            mouseDown.startPos.x = e.offsetX;
            mouseDown.startPos.y = e.offsetY;
            console.log(mouseDown.startPos.x);
        }
    }
    mouseDown.startPos = new vec2(0, 0);


    //GRID//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function drawGrid() {
        for (var i = 0; i < canvas.width; i += drawGrid.space) {
            context.moveTo(i, 0);
            context.lineTo(i, canvas.height);

        }
        for (var j = 0; j < canvas.height; j += drawGrid.space) {
            context.moveTo(0, j);
            context.lineTo(canvas.width, j);
        }
    }
    drawGrid.space = 30;

    function lockToGrid(vec) {
        vec.x = Math.round(vec.x / drawGrid.space) * drawGrid.space;
        vec.y = Math.round(vec.y / drawGrid.space) * drawGrid.space;
        return vec;
    }
    //OBJECTS//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

    function movieClip(pos, dim) {
        this.pos = pos;
        this.dim = dim;
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

    //PLAYER//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
            this.grounded = false;
            var brokenCollisionsBlock = new Array();
            var brokenCollisionsMove = new Array();
            for (var b = 0; b < block.ar.length; b++) {
                var vec = checkCollision(this, block.ar[b]);
                this.pos = this.pos.add(vec);
                this.calcPoints();
                var worked = true;
                for (var c = 0; c < block.ar.length; c++) {
                    if (block.ar[c] != block.ar[b]) {
                        var vec2 = checkCollision(this, block.ar[c]);

                        if ((vec2.x != 0 || vec2.y != 0)) {
                            var place = brokenCollisionsBlock.indexOf(block.ar[c]);
                            if (place != -1) {
                                this.pos = this.pos.add(vec2);


                                if (vec2.y != 0) {
                                    if ((vec2.y < 0) != (this.spd.y < 0)) {
                                        this.spd.y = 0;
                                        if (vec2.y < 0) {
                                            this.grounded = true;
                                            this.jumpsDone = 0;
                                        }
                                    }

                                } else if (vec2.x != 0) {
                                    if ((vec2.x < 0) != (this.spd.x < 0)) {
                                        this.spd.x = 0;
                                    }
                                }

                            } else {
                                brokenCollisionsBlock.push(block.ar[b]);
                                brokenCollisionsMove.push(vec2);
                                this.pos = this.pos.add(vec.scaleMult(-1));
                                this.calcPoints();
                                worked = false;
                                break;
                            }
                        }
                    }

                }
                if (worked) {
                    if (vec.y != 0) {
                        if ((vec.y < 0) != (this.spd.y < 0)) {
                            this.spd.y = 0;
                            if (vec.y < 0) {
                                this.grounded = true;
                                this.jumpsDone = 0;
                            }
                        }

                    } else if (vec.x != 0) {
                        if ((vec.x < 0) != (this.spd.x < 0)) {
                            this.spd.x = 0;
                        }
                    }
                }


            }
            this.calcPoints();
        }
        this.checkInput = function() {
            if (isKeyDown(keyEnum.W_Key)) {
                if (this.jumpsDone < this.maxJumps && !this.jumpKeyDown) {
                    this.spd.y = -7;
                    this.jumpsDone++;
                    this.jumpKeyDown = true;
                }
            } else {
                this.jumpKeyDown = false;
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

        this.grounded = false;
        this.maxJumps = 2;
        this.jumpsDone = 0;
        this.jumpKeyDown = false;
        this.points = new Array();
        this.calcPoints();
        this.maxSpd = 3;
        this.spd = new vec2(0, 0);
        this.color = color;
    }


    //Graph//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function graph(placeHolder, costL, sellB, buyB, shareNumL) {
        this.data=[];
        this.totalPoints = 100;
        this.value = 0;
        this.shares = 0;
        this.costL = costL
        this.sellB = sellB;
        this.buyB = buyB;
        this.shareNumL = shareNumL;
        var graph = this;
        this.buyB.onclick = function () {
            var share = bigint_div(cashM.value, graph.value);
            if (share) {
                graph.setShares(bigint_plus(share,graph.shares));
                cashM.subtract(bigint_mul(new BigInt(graph.value), new BigInt(share)));
            }
        };

        this.sellB.onclick = function () {
            cashM.add(graph.value * graph.shares);
            graph.setShares(new BigInt(0));
        };
        
        this.setShares=function(num){
            this.shares = num;
            shareNumL.innerText = "Shares owned: " + this.shares;
        }

        this.getRandomData = function() {
            if (this.data.length > 0)
                this.data = this.data.slice(1);
            // Do a random walk
            while (this.data.length < this.totalPoints) {

                var prev = this.data.length > 0 ? this.data[this.data.length - 1] : 50,
                    y = Math.round(prev + Math.random() * 10 - 5);

                if (y < 20) {
                    y = 20;
                } else if (y > 100) {
                    y = 100;
                }
                this.value = y;
                this.costL.innerText = "Cost: $" + y;
                this.data.push(y);
            }

            // Zip the generated y values with the x values

            var res = [];
            for (var i = 0; i < this.data.length; ++i) {
                res.push([i, this.data[i]])
            }

            return res;
        }
        this.draw = function() {
            this.plot.draw();
        }

        

        this.update=function() {
                this.plot.setData([this.getRandomData()]);
                this.draw();

        }

        this.plot=$.plot(placeHolder, [ this.getRandomData() ], {
            series: {
                shadowSize: 2,   // Drawing is faster without shadows
                lines: { show: true, fill: true },
                color: '#444466'
            },
            yaxis: {
                min: 0,
                max: 100
            },
            xaxis: {
                show: false
            }
        });
    }

    //Graph//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function cashMeter(placeHolder) {
        this.value = new BigInt("0");
        this.scoreLabel=placeHolder;
        this.interest = 0;
        this.add=function(val) {
            this.value = bigint_plus(this.value, val);
            this.update();
        }
        this.subtract=function(val) {
            this.value = bigint_minus(this.value, val);
            this.update();
        }
        this.update=function(){
            this.scoreLabel.innerText='Funds: $'+this.value;
        }
    }
    
    //MAIN//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var scoreLabel = document.getElementById("score");
    cashM = new cashMeter(scoreLabel);
    var investB = document.getElementById("invest");
    var gainInterestB = document.getElementById("gainInterest");
    gainInterestLevelB = document.getElementsByClassName("gainInterestLevelB");
    gainInterestLevelB.disableCheck = function () {
        for (var x = 0 ; x < gainInterestLevelB.length; x++) {
            if (cashM.interest >= gainInterestLevelB[x].interest) {
                gainInterestLevelB[x].disabled = true;
            }
        }
    }
    for(var x = 0 ;x<gainInterestLevelB.length;x++){
        gainInterestLevelB[x].innerText += ' Level ' + (x + 1) + ' ($' + Math.pow(10, x + 1) + ')';
        gainInterestLevelB[x].cost = Math.pow(10, x + 1);
        gainInterestLevelB[x].interest = x + 1;
        gainInterestLevelB[x].onclick = function () {
            if (cashM.value >= this.cost && cashM.interest < this.interest) {
                cashM.subtract(this.cost);
                cashM.interest = this.interest;
            }
            gainInterestLevelB.disableCheck();
        };
    }
    var workButtonB = document.getElementById("work");
    
    var graphPlaceHolders = document.getElementsByClassName("graph-placeholder");
    var sellInvestB = document.getElementsByClassName("sellInvestB");
    var buyInvestB = document.getElementsByClassName("buyInvestB");
    var graphCostL = document.getElementsByClassName("graphValue");
    var shareNumL = document.getElementsByClassName("shareNum");
    graphs = [];
    for(var x = 0 ;x<graphPlaceHolders.length;x++){
        graphs[x] = new graph(graphPlaceHolders[x], graphCostL[x], sellInvestB[x], buyInvestB[x], shareNumL[x]);
    }


    workButtonB.onclick=function(){
        cashM.add(1);
    };

    gainInterestB.shown = 0;
    gainInterestB.onclick=function(){
        if (gainInterestB.shown == 1) {
            $("#interests").hide();
            gainInterestB.shown = 0;
        } else {
            $("#interests").show();
            gainInterestB.shown = 1;
        }
    };
    investB.shown = 0;
    investB.onclick = function () {
        if (investB.shown == 1) {
            $("#invests").hide();
            investB.shown = 0;
        } else {
            $("#invests").show();
            investB.shown = 1;
        }
    };

    $(window).resize(function(){
        for(x in graphs){
            graphs[x].plot.resize();
            graphs[x].plot.setupGrid();
            graphs[x].draw();
        }
    });
    
    var mainloop = function() {
            //score = bigint_mul(score, 5);
            cashM.add(cashM.interest);
            for(x in graphs){
                graphs[x].update();
            }
            
    };

    var animFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || null;
   
    var ONE_FRAME_TIME = 1000.0;
    mainloop();
    setInterval(mainloop, ONE_FRAME_TIME);
    $("#invests").hide();
    $("#interests").hide();
    
}