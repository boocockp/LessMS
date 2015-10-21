var express = require('express'),
    aws = require('aws-sdk'),
    google = require('googleapis');
var router = express.Router();

var AWS_ACCESS_KEY = 'your_AWS_access_key';
var AWS_SECRET_KEY = 'your_AWS_secret_key';
var S3_BUCKET = 'images_upload';

var s3 = new aws.S3();
aws.config.update({accessKeyId: AWS_ACCESS_KEY, secretAccessKey: AWS_SECRET_KEY});


/* Signed URL */
router.post('/', function (req, res, next) {
    var idToken = req.body.idToken;
    //res.send('Google id for ' + idToken);

    //var options = {
    //    Bucket: S3_BUCKET,
    //    Key: req.body.file_name,
    //    Expires: 60,
    //    ContentType: req.body.file_type,
    //    ACL: 'public-read'
    //};
    //
    //s3.getSignedUrl('putObject', options, function(err, data){
    //    if(err) return res.send('Error with S3');
    //
    //    res.json({
    //        signed_request: data,
    //        url: 'https://s3.amazonaws.com/' + S3_BUCKET + '/' + req.body.file_name
    //    })
    //})

});

module.exports = router;
