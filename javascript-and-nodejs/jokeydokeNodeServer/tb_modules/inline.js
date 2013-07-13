var fs = require('fs');

exports.execInline = function(req, res, fileString, handler, callback, pos) {
	//do i need this tick? only if stuff after call needs to be done fast
	process.nextTick(function() {
		if(!pos){
			pos=0;
		};
	    var patt = /<\s*\?\s*node\s+(\w*)?\((.*?)\)\s*\?\s*>/;
	    var result = patt.exec(fileString.substring(pos));

	    if(!result || result == null) {
	    	//nothing left to replace, return text
	    	var err;
	    	callback(err, fileString);
	    } else {
	    	//invoke client handler to receive text
	    	handler(req, res, result[1], result[2], function(err, content){
	    		//get positions in string to replace
	    		var startPosOfResult = pos + result.index;
	    		var endPosOfResult = startPosOfResult + result[0].length;
	    		//replace with content from user
		        fileString = fileString.substring(0, startPosOfResult) + content + fileString.substring(endPosOfResult);
		        //continue parsing
		        exports.execInline(req, res, fileString, handler, callback, startPosOfResult);
	    	});
	    }
	});
  };


exports.getFile = function(req){
	var file = req.params[0];
      if(!file||file == "") {
        file = "html/index.html";
      }
      return file;
}

exports.getFileType = function(file){
	if(file){
	return file.split('.').pop();
	}else{
	return null;
}
}

exports.setReturnFileType = function(res, file){
	//console.log(file);
	var type = exports.getFileType(file);
	if(type){
	if(type=="js"){
		res.set({
			'Content-Type': 'text/javascript '
		})
	}else if(type=="css"){
		res.set({
			'Content-Type': 'text/css'
		})
	}else if(type=="html"){
		res.set({
			'Content-Type': 'text/html'
		})
		return true;
	}else if(type=="png"){
		res.set({
			'Content-Type': 'image/png'
		})
	}else if(type=="ico"){
		res.set({
			'Content-Type': 'image/ico'
		})
	}else if(type=="gif"){
		res.set({
			'Content-Type': 'image/gif'
		})
	}else if(type=="jpeg"){
		res.set({
			'Content-Type': 'image/jpeg'
		})
	}else if(type=="jpg"){
		res.set({
			'Content-Type': 'image/jpeg'
		})
	}
	return false;
}
	
}