#!/usr/bin/env bash

DEPLOY_BUCKET=lessms

./s3-cli sync --delete-removed dist s3://$DEPLOY_BUCKET/
./s3-cli put src/main/config.json s3://lessms/config.json
