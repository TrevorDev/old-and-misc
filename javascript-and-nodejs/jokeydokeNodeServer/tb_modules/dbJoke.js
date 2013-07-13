var mongoose = require('mongoose');

exports.dbJoke = function (db) {
		var jokeSchema = mongoose.Schema({
			author: String,
			joke: String,
			date: Date
		});
		var JokeModel = mongoose.model('Joke', jokeSchema);
		var jokeRef = new joke(JokeModel);
		return jokeRef;
}

function joke(jokeModel) {
	this.createJoke = function(author, joke, date, callback) {
		var newJoke = new jokeModel({
			author: author,
			joke: joke,
			date: date
		});
		newJoke.save(function(err, newJoke) {
			
			var quer = jokeModel.find().sort({ date: 'desc'}).skip(2).limit(2);
			var ans = quer.exec(function(err, j){
				console.log(j)
			})
			/*
			jokeModel.find({
				joke: /tbaron@uoguelph.ca/
			}, function(err, docs) {
				console.log(docs)
			})*/
			if(err){
				err = "Joke already exists"
			}
			callback(err);
		})
	}

	this.getJoke = function(author, callback) {
		jokeModel.findOne({
			author: author
		}, function(err, docs) {
			callback(err, docs);
		})
	}

	this.getNewJokes = function(number, offset, callback) {
		var quer = jokeModel.find().sort({ date: 'desc'}).skip(offset).limit(number);
			var ans = quer.exec(function(err, docs){
				callback(err, docs);
			})
	}

	this.removeAllJoke = function() {
		jokeModel.remove(function(err) {});
	}
}