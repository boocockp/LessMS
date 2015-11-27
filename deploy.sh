#!/usr/bin/env bash

. deploy_vars

./s3-cli sync --delete-removed dist s3://$DEPLOY_BUCKET/
./s3-cli put src/main/config.json s3://$DEPLOY_BUCKET/config.json
