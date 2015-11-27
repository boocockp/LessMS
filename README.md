# LessMS

## What it does
LessMS lets you create a CMS in an S3 website bucket.  The CMS runs entirely in the browser - no server required.  
Users can sign in with Google and edit files in their own folder.  The files are published immediately on the web.

## How it works

You configure an S3 bucket as a website for your users' content.
 
You install LessMS on another website (which can also be a s3 bucket) and configure it to point to the content website.
  
You also need to register an app in a Google developer account and link it to AWS and your LessMS installation.
  
Step-by step instructions below (*soon*)
  
  
Your users sign in with their own Google account.

Once signed in, they can create, upload, edit and browse files in their own folder

LessMS stores files in the content S3 bucket in a folder linked to the user's Google id that only they can update.

As the S3 bucket is a website bucket all the files are publicly available.

Everything is done in the browser using the AWS SDK - no server needed.


## Getting Started

- Clone the project
- Run devSetup.sh

### Google Developer account
- Create a Google developer account at ...

### Register an app

- Create an app at ... 
- Add the URL of the LessMS website to the app
- Add the localhost URL and port that you use for development
- Take the app id and put it in your config.json

### AWS account
- Create an AWS account
- Create an Admin user
- Put the access key and secret key in your s3cmd.conf 
- Create a LessMS user
- Create a content bucket and configure as static website
- Create a LessMS install bucket and configure as static website (unless hosting it elsewhere)
- Put the name of the LessMS install bucket in your deploy_vars
- Create a Cognito identity pool and link it to the Google app
- Put the Cognito identity pool id in your config.json
- Configure the content bucket with the sample policy in the aws directory 
- ...and some more things

