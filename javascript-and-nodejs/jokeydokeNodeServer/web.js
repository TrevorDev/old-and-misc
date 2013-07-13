var express = require('express');

var app = express.createServer(express.logger());
var test = 0;
app.get('/', function(request, response) {
  test++;
  response.send('Helloo World!'+test);
});

var port = process.env.PORT || 5000;
app.listen(port, function() {
  console.log("Listening on " + port);
});