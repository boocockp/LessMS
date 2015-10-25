var express = require('express'),
    aws = require('aws-sdk'),
    google = require('googleapis');
var router = express.Router();

var AWS_ACCESS_KEY = process.env.AWS_ACCESS_KEY;
var AWS_SECRET_KEY = process.env.AWS_SECRET_KEY;
var S3_BUCKET = process.env.S3_BUCKET;

//console.log('AWS_ACCESS_KEY', AWS_ACCESS_KEY, 'AWS_SECRET_KEY', AWS_SECRET_KEY);
aws.config.update({accessKeyId: AWS_ACCESS_KEY, secretAccessKey: AWS_SECRET_KEY, region: "eu-west-1"});
var s3 = new aws.S3();


/* Signed URL */
router.post('/', function (req, res, next) {
    var idToken = req.body.idToken;
    var filePath = req.body.filePath;
    var contentType = req.body.contentType;
    console.log('idToken', idToken, 'filePath', filePath, 'contentType', contentType);

    var options = {
        Bucket: S3_BUCKET,
        Key: filePath,
        Expires: 60,
        ContentType: contentType,
        ACL: 'public-read'

    };

    s3.getSignedUrl('putObject', options, function(err, data){
        if(err) return res.status(500).send('Error with S3: ' + err);

        res.json({
            signedPutUrl: data,
            getUrl: 'http://' + S3_BUCKET + '.s3.amazonaws.com/' + filePath
        })
    })

});

module.exports = router;
