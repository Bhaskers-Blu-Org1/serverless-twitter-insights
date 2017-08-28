

#wsk action invoke ibm_journey_twitter/updateTwitterData -b -r --param '$actionName' 'journey_twitter/getTweets' --param '$actionArgs' '["term"]' --param '$forward' '["term"]' --param term serverless

wsk action invoke ibm_journey_twitter/updateTwitterData -b -r --param term serverless