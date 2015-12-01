#!/usr/bin/env bash

# Copy example config files to base directory
# Set up links so you can serve the app from src/main for development

cp -n aws/config.json .
cp -n aws/s3cmd.conf .
cp -n aws/deploy_vars .

mkdir -p target/main target/test

(cd src/main && ln -fs ../../bower_components bower)
(cd src/main && ln -fs ../../lib)
(cd src/main && ln -fs ../../config.json)

echo You need to update config.json, s3cmd.conf and deploy_vars with your details
