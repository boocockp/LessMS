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

