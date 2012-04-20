var fs = require("fs");
var model = require("../models/blogsync");

throwNotFoundException = function(res, error) {
 	res.render('404.jade', 
	{ status: 404, message: error });
}

renderAllTopics = function(req, res) {
	var topics = model.getAllTopics(req);
  res.render('blogs', {topics: topics});
}

blog = function(req, res) {

	if (req.params.url == undefined) {
		renderAllTopics(req, res);
	} else {
		var topic = model.getTopicByUrl(req);
		if(topic.error) {
			throwNotFoundException(res,data.error);
		} else { 
		 	res.render('blog', topic);
		}
	}	
}

edit = function(req, res) {
	if (req.params.url == undefined) {
		console.log('Edit without a URL was detected. Redirecting to blog list.');
		res.redirect('/blog');
	} else {
		model.getTopicByUrl(req, res, function(req, res, data) { 
		  if(data.error) {
				throwNotFoundException(res,data.error);
		  } else { 
		  	res.render('blogedit', data);
			}
		});
	}	
}

save = function(req, res) {
	if (req.params.url == undefined) {
		console.log('Save without a URL was detected. Redirecting to blog list.');
		res.redirect('/blog');
	} 
	else {
		console.log("Saving new content: " + req.body.content);

		model.saveTopicByUrl(req, res, function(data) { 
		  if(data.error) {
		  	throw "Could not save topic " + req.params.url;
		  } else { 
		  	res.redirect('/blog/'+ req.params.url);
			}
		});
	}
}

module.exports = {
  blog: blog,
  edit: edit,
  save: save
};