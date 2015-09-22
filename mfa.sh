#!/bin/bash
#
# Sample for getting temp session token from AWS STS
#
# aws --profile youriamuser sts get-session-token --duration 3600 \
# --serial-number arn:aws:iam::012345678901:mfa/user --token-code 012345
#
# Once the temp token is obtained, you'll need to feed the following environment
# variables to the aws-cli:
#
# export AWS_ACCESS_KEY_ID='KEY'
# export AWS_SECRET_ACCESS_KEY='SECRET'
# export AWS_SESSION_TOKEN='TOKEN'

AWS_CLI=`which aws`

if [ $? -ne 0 ]; then
  echo "AWS CLI is not installed; exiting"
  exit 1
else
  echo "Using AWS CLI found at $AWS_CLI"
fi

#if [ $# -ne 3 ]; then
#  echo "Usage: $0 <AWS_CLI_PROFILE> <ARN_OF_MFA> <MFA_TOKEN_CODE>"
#  echo "Where:"
#  echo "   <AWS_CLI_PROFILE> = aws-cli profile usually in $HOME/.aws/config"
#  echo "   <ARN_OF_MFA> = ARN of the virtual MFA assigned to IAM user (arn:aws:iam::012345678901:mfa/user)"
#  echo "   <MFA_TOKEN_CODE> = Code from virtual MFA device"
#  exit 2
#fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 <MFA_TOKEN_CODE>"
  echo "Where:"
  echo "   <MFA_TOKEN_CODE> = Code from virtual MFA device"
  exit 2
fi

AWS_CLI_PROFILE="default"
ARN_OF_MFA="arn:aws:iam::12345:mfa/user"
MFA_TOKEN_CODE=$1

echo "AWS-CLI Profile: $AWS_CLI_PROFILE"
echo "MFA ARN: $ARN_OF_MFA"
echo "MFA Token Code: $MFA_TOKEN_CODE"

echo "Copy and paste the following into your shell:"
aws --profile $AWS_CLI_PROFILE sts get-session-token --duration 129600 \
  --serial-number $ARN_OF_MFA --token-code $MFA_TOKEN_CODE --output text \
  | awk '{printf("export AWS_ACCESS_KEY_ID=\"%s\"\nexport AWS_SECRET_ACCESS_KEY=\"%s\"\nexport AWS_SESSION_TOKEN=\"%s\"\n",$2,$4,$5)}' | tee ~/.token_file
source ~/.token_file
