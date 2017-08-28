function main(args) {
	console.log('i was set '+args.tweets.length+' tweets');
	let result = [];
	args.tweets.forEach(function(t) {
		let doc = {};
		//copy all
		doc.tweet = t;
		//copy id to _id
		doc._id = t.id_str;
		//set the original search term
		doc.term = args.term;
		result.push(doc);
	});

	//todo: dbname should be a param
	return {
		docs:{"docs":result},
		dbname:"tweets"
	};
}