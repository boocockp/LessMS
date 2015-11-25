#!/usr/bin/env bash

DEPLOY_BUCKET=lessms

./s3-cli sync --delete-removed dist s3://$DEPLOY_BUCKET/
