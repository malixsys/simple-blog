assert = require 'assert' 
{BlogModel}  = require '../models/blog'

getAllTopicsOK = ->
	console.log "getAllTopicsOK"
	dataPath = __dirname + '/../data' 
	model = new BlogModel dataPath 
	
	model.getAllTopics (err, topics) -> 
		assert err is null, "Error retrieving all topics. Error: #{err}" 
		console.log "getAllTopicsOK ended"


getAllTopicsError = ->
	console.log "getAllTopicsError"

	dataPath = __dirname + '/../xx-data' 
	model = new BlogModel dataPath 
	
	model.getAllTopics (err, topics) -> 
		assert err isnt null, "Should have gotten an error!" 
		console.log "getAllTopicsError ended"


getTopicOK = ->
	console.log "getTopicOK"

	dataPath = __dirname + '/../data' 
	model = new BlogModel dataPath 
	
	model.getAllTopics (err, topics) -> 
		url = topics[0].url
		model.getTopicByUrl url, (err, topic) ->
			assert err is null, "Error retrieving topic #{url}. Error: #{err}"
			console.log "getTopicOK ended"


getTopicError = ->
	console.log "getTopicError"

	dataPath = __dirname + '/../data' 
	model = new BlogModel dataPath 
	
	model.getAllTopics (err, topics) -> 
		url = topics[0].url + "-xxx"
		model.getTopicByUrl url, (err, topic) ->
			assert err isnt null, "Should have gotten an error retrieving topic #{url}. Error #{err}"
			console.log "getTopicError ended"


editTopicByUrl = ->
	console.log "editTopicByUrl"

	dataPath = __dirname + '/../data' 
	model = new BlogModel dataPath 
	url = "unit-test-topic"
	model.saveTopicByUrl url, "unit test content", (err, data) -> 
		assert err is null, "Error saving topic #{url}. Error: #{err}"
		console.log "editTopicByUrl ended"


saveExistingTopic = -> 
	console.log "saveExistingTopic"

	dataPath = __dirname + '/../data' 
	model = new BlogModel dataPath 
	timeStamp = new Date()
	topic = {
		id: 4
		title: "unit test title #{timeStamp}"
		url: "unit-test-topic"
		summary: "unit test summary #{timeStamp}"
		content: "unit test content #{timeStamp}"
		postedOn: timeStamp
	}

	console.log topic.content

	model.saveTopic topic, (err, data) -> 
		assert err is null, "Error saving topic #{topic.url}. Error: #{err}"
		console.log "saveExistingTopic ended"


saveNewTopic = ->
	console.log "TBD"

# -----------------
# Execute the tests
# -----------------
getAllTopicsOK()
getAllTopicsError()
getTopicOK()
getTopicError()
editTopicByUrl()
saveExistingTopic()
#saveNewTopic()
