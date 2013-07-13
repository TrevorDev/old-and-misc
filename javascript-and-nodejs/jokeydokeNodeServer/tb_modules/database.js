var bcrypt = require('bcrypt');
var mongodb = require('mongodb');
var mongoose = require('mongoose');


function tbDB(Account) {
	this.Account = Account;

	this.createAcc = function(fullName, email, password, callback) {
		bcrypt.genSalt(10, function(err, salt) {
		    bcrypt.hash(password, salt, function(err, hash) {
		        // Store hash in your password DB.
				var newAcc = new Account({
					fullName: fullName,
					email: email,
					password: hash
				});
				newAcc.save(function(err, newAcc) {
					Account.find(function(err, user) {
						//console.log(user)
						if(err) // TODO handle err
						console.log("find error")
					})
					/*
					Account.find({
						email: /tbaron@uoguelph.ca/
					}, function(err, docs) {
						console.log(docs)
					})*/
					if(err){
						err = "Account already exists"
					}
					callback(err);
				})
		    });
		});

	}

	this.getAcc = function(email, callback) {
		Account.findOne({
			email: email
		}, function(err, docs) {
			callback(err, docs);
		})
	}

	this.authenticateAcc = function(email, password, callback) {
		this.getAcc(email, function(err, docs) {
			if(err || !docs) {
				callback("Account doesnt exist");
			} else {
				if(docs.password == password) {
					callback(null);
				} else {
					callback("Wrong password");
				}
			}
		})
	}

	this.removeAllAcc = function() {
		Account.remove(function(err) {});
	}
}


exports.init = function(callback) {
	//Setup connect
	//var mongourl = 'mongodb://localhost/test';
	var mongourl = 'mongodb://tb:q1q1q1@linus.mongohq.com:10055/app11373101';
	//
	/*if(process.env.VCAP_SERVICES) {
		var env = JSON.parse(process.env.VCAP_SERVICES);
		mongourl = ['mongodb-1.8'][0]['credentials'];
	}*/
	mongoose.connect(mongourl);
	var db = mongoose.connection;
	db.on('error', console.error.bind(console, 'connection error:'));


	db.once('open', function() {
		var err = null;
		//Setup Schema
		/*var accountSchema = mongoose.Schema({
			fullName: String,
			email: {
				type: String,
				unique: true
			},
			password: String
		});*/

		/*accountSchema.methods.speak = function() {
			var greeting = this.fullName ? "My fullName is " + this.fullName : "I don't have a fullName";
			console.log(greeting);
		};*/

		//compile schema
		//var Account = mongoose.model('Account', accountSchema);

		//create db class
		//var db = new tbDB(Account);
		
		callback(err, db);
	});
}