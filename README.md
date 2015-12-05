# LessMS

## What it does
- LessMS lets you create a CMS in an S3 website bucket.  
- The CMS runs entirely in the browser - no server required.  
- Users can sign in with Google and edit files in their own folder.  
- The files are published immediately on the web.

## How it works

### Setting up
You configure an S3 bucket as a website for your users' content.
 
You install LessMS on another website (which can also be a s3 bucket) and configure it to point to the content website.
  
You also need to register an app in a Google developer account and link it to AWS and your LessMS installation.
  
Step-by step instructions below
  
### What your users see 
Your users sign in with their own Google account.

Once signed in, they can create, upload, edit and browse files in their own folder

LessMS stores files in the content S3 bucket in a folder linked to the user's Google id that only they can update.

As the S3 bucket is a website bucket all the files are publicly available.

Everything is done in the browser using the AWS SDK - no server needed.


## Getting Started

- Clone the project
- Run devSetup.sh
- This will create three files in your working directory that you will need to edit: s3cmd.conf, deploy_vars and config.json

### Set up AWS and Google

#### AWS account
- Create an AWS account and sign up for S3: [http://docs.aws.amazon.com/AmazonS3/latest/gsg/SigningUpforS3.html]

#### Create AWS users with IAM (Identity and Access Management)
- Refer to [http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html]
- Create an Administrators group and an Admin user, noting the access key and secret key
- Put the access key and secret key of the admin user in the s3cmd.conf in your working directory 
- Sign in as the Admin user

#### Create S3 buckets
- Refer to [http://docs.aws.amazon.com/AmazonS3/latest/UG/BucketOperations.html]
- Create a user files bucket and configure as static website
- Create a LessMS install bucket and configure as static website (unless hosting it elsewhere)
- Put the name of the LessMS install bucket in your deploy_vars
- Put the name of the user files bucket in your config.json

#### Set bucket permissions
- In the AWS console for S3, go to your user files bucket
- Click Properties and then Permissions
- Click Edit bucket policy
- Paste in the contents of aws/bucket_policy, changing the bucket name to your user files bucket, and save
- Click Edit CORS configuration
- Paste in the contents of aws/bucket_cors_configuration and save

#### Google Developer project
- Sign in to a Google account under which you want to create your CMS project
- Create a new project for your CMS at https://console.developers.google.com/project
- In the project dashboard at https://console.developers.google.com/home/dashboard, click Use Google APIs
- Click Credentials in the sidebar
- Click Add Credentials/OAuth 2.0 Client Id
- Select Application Type of Web application
- Under Authorized JavaScript origins, add the URL of the LessMS install website
- Under Name, choose a name for you CMS
- Click Create, and note the Client ID shown in a popup box
- Put the Client ID in your config.json

#### Cognito Identity Pool
- In AWS Console for Cognito, create a new Identity Pool
- Enter LessMS as the name
- Under Authentication Providers, click Google+
- Enter the Google Client ID from the previous section
- Click Create
- On the next page, click View Details
- In the first Role Summary, for authenticated identities, click Edit next to the policy document
- Paste in the contents of aws/cognito_role_policy, changing the bucket name to your user files bucket, and save
- Click Allow
- Click Edit Identity Pool at the top right and copy the Identity Pool ID
- Put the Identity Pool ID in your config.json 

## Building

Run ./build.sh to build the distribution bundle

Run ./deploy.sh to copy the distribution files to your LessMS install bucket

## Tests
The tests (under src/test) need to be run manually in a browser and are not suitable for CI yet.

The tests are written in CoffeeScript and need to be compiled to the target dir - it is best to set up a file watcher for this during development.

The browser needs to be signed into a Google account before the tests are run