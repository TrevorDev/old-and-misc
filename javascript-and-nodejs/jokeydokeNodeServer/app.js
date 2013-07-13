var inline = require('./tb_modules/inline.js');
var database = require('./tb_modules/database.js');
var dbJoke = require('./tb_modules/dbJoke.js');
var express = require('express');
var fs = require('fs');
var escapeHTML = require('escape-html');

var app = express();
app.use(express.bodyParser());
app.use(express.cookieParser('whatever'));
app.use(express.cookieSession());

var db;

database.init(function(err, initDB) {
db = initDB;
db.joke = dbJoke.dbJoke();
//db.joke.removeAllJoke();
app.post('/*', function(req, res){
  var file = inline.getFile(req);
  if(file == "submitJoke"){
    var auth = req.body.author.substring(0,50);
    if(auth==""){
      auth = "Anonymous"
    }
    db.joke.createJoke(auth, req.body.joke.substring(0,255), new Date(), function(){
      res.redirect('/');
    });
  }else{
    res.redirect('/html/err.html');
  }    
});

app.get('/*', function(req, res){
	var file = inline.getFile(req);
	sendFile(req, res, file);
});

/*db.createAcc("trev", "t@m", "bacon", function(){
  db.removeAllAcc();
});*/
app.listen(process.env.PORT || 3000);
});

var test = function(callback){
  process.nextTick(function(){
    var x = 0;
    while(x<1000000000){
      x++;
    }
    console.log("hit");
    callback();
  });
}

var handle = function(req, res, method, params, callback){
  process.nextTick(function() {
    var err;
    if(method=="include"){
      fs.readFile(params, function(err, fileString) {
        if(fileString){
          callback(err, fileString.toString());
        }else{
          console.log("err 1"+" "+inline.getFile(req));
          callback(err, "ERROR HERE");
        }
      });
    }else if(method=="getJokes"){
      //callback(err, "jokes");
      db.joke.getNewJokes(100,0, function(err, docs){
        var content="";
        for (var joke in docs) {
          content+='<div class="well"><h4 class="media-heading">'+escapeHTML(docs[joke].author)+'</h4>'+escapeHTML(docs[joke].joke)+'</div>';
        };
        callback(err, content);
      });
    }else if(method=="test"){
      callback(err, "test");
    }else if(method=="siteName"){
      callback(err, "Resubox");
    }else{
      callback(err, "yess");
    }
  });
};

var sendFile = function(req, res, file) {
    fs.readFile(file, function(err, fileString) {
      if(err) {
      	console.log("err 0" + err);
      	file = "html/err.html";
      	sendFile(req, res, file);
      } else {
      	//to remove cache res.writeHead(200);
      	if(inline.setReturnFileType(res, file)){
          //slow
          fileString = fileString.toString();
          inline.execInline(req, res, fileString, handle, function(err, content){
            res.send(content);
          });
        }else{
          res.send(fileString);
        }
      }
    });
  }