console.log("Loading function");
var AWS = require("aws-sdk");
var zlib = require('zlib')

exports.handler = function(event, context) {
    var sns = new AWS.SNS();
    var payload = new Buffer.from(event.awslogs.data, 'base64')
    zlib.gunzip(payload, function(e, decodedEvent) {
        if (e) {
            context.fail(e)
        } else {
            console.log("Decoded event: " + decodedEvent)
            decodedEvent = JSON.parse(decodedEvent.toString('ascii'))
            var eventText = JSON.stringify(decodedEvent, null, 2);
        }
        var params = {
            Message: eventText, 
            Subject: "CL warn or error log",
            TopicArn: "arn:aws:sns:{region}:{id}:{topic}"
        };
        sns.publish(params, context.done);
    })
};
