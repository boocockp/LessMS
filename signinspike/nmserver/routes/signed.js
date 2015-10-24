var express = require('express'),
    aws = require('aws-sdk'),
    google = require('googleapis');
var router = express.Router();

var AWS_ACCESS_KEY = process.env.AWS_ACCESS_KEY;
var AWS_SECRET_KEY = process.env.AWS_SECRET_KEY;
var S3_BUCKET = process.env.S3_BUCKET;

var s3 = new aws.S3();
aws.config.update({accessKeyId: AWS_ACCESS_KEY, secretAccessKey: AWS_SECRET_KEY});


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
        if(err) return res.send('Error with S3');

        res.json({
            signedPutRequest: data,
            url: 'https://s3.amazonaws.com/' + S3_BUCKET + '/' + filePath
        })
    })

});

module.exports = router;
