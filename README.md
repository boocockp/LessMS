# LessMS

Log in with Google.

Store files in an S3 bucket in a folder linked to your Google id that only you can update.

If the S3 bucket is a website bucket all the files are publicly available.

List your files and edit them in a suitable editor.

Everything is done in the browser using the AWS SDK - no server needed.

Write permissions are set on the bucket using a policy that allows you to update only objects whose keys start with the id derived from your Google login.
