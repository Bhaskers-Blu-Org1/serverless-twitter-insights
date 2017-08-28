Initial Notes
===

You will need:

* OpenWhisk account
* A Twitter API account
* A Cloudant BM account
* A Watson Tone Analysis service

There are a few different parts to this service.

Part One - Get Tweets
---

This is done by running a call to my public Twitter package to get tweets matching term X. You should bind the public package to your space with the consumer key and secret. Call it `journey_twitter`. 

This binds a copy of combinators specifically for part one: 

	wsk package bind /whisk.system/combinators getTweetsForwarder --param '$actionName' 'journey_twitter/getTweets' --param '$actionArgs' '["term"]' --param '$forward' '["term"]'

Make a package called ibm_journey_twitter. This is just to store actions and stuff.

This makes the shapeTweets action. It takes the tweet results and prepares them for entry into cloudant:

	wsk action update ibm_journey_twitter/shapeTweets actions/shapeTweets.js

Note: shapeTweets assums a dbname of tweets.

This is the entire sequence: 

	wsk action update --sequence ibm_journey_twitter/updateTwitterData getTweetsForwarder/forwarder,ibm_journey_twitter/shapeTweets,"Bluemix_Twitter Storage_Credentials-1"/manage-bulk-documents

Note I called my Cloudant service Bluemix_Twitter Storage_Credentials-1. That seems like a dumb name. 

In theory, you can testinvoke. It should:

* find tweets on serverless
* shape them for entry into Cloudant *and* store the search term for each result
* run the cloudant bulk insert thing

You can run this N times and data won't be duplicated.

Part 2
---

This is where we will run this query to get stuff to be analyzed:

```
{
	"dbname":"tweets",
	"query":{
		"selector": {
		  "analysis": {
			"$exists": false
		  }
		},
		"fields": [
		  "_id"
		],
		"sort": [
		  {
			"_id": "asc"
		  }
		]
	  }
}
```

Part 3
---

Fancy client-side app with static HTML, CSS, and JS to do reporting. Will hit serverless APIs to fetch data.