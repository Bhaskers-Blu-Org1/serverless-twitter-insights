
wsk action update ibm_journey_twitter/shapeTweets actions/shapeTweets.js

wsk action update --sequence ibm_journey_twitter/updateTwitterData getTweetsForwarder/forwarder,ibm_journey_twitter/shapeTweets,"Bluemix_Twitter Storage_Credentials-1"/manage-bulk-documents
