#!/bin/bash
# set -x
# Use unset to clear env vars

echo "unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset export AWS_SESSION_TOKEN" > ~/.token_file
