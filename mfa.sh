#!/bin/bash
# set -x
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

# Helper
while getopts ":h" option; do
    case $option in
        h) # display Help
            echo "Usage: $0 <AWS_CLI_PROFILE> <TOKEN_DURATION>"
            echo "Where:"
            echo "   <AWS_CLI_PROFILE>(Optional) = aws-cli profile usually in $HOME/.aws/config"
            echo "   <TOKEN_DURATION>(Optional) = Token code duration time (default 129600)"
            exit;;
        esac
done

echo "Reading config..."
if [ ! -r ~/mfa.cfg ]; then
  echo "No config found.  Please create your mfa.cfg.  See README.txt for more info."
  exit 2
fi

echo -n "Enter your MFA Token: " >&2
read -s MFA_TOKEN_CODE
AWS_CLI_PROFILE=${1:-default}
DURATION=${2:-129600}
ARN_OF_MFA=$(grep "^$AWS_CLI_PROFILE" ~/mfa.cfg | cut -d '=' -f2- | tr -d '"')

echo "AWS-CLI Profile: $AWS_CLI_PROFILE"
echo "MFA ARN: $ARN_OF_MFA"
echo "MFA Token Code: $MFA_TOKEN_CODE"

echo "Your Temporary Creds:"
aws --profile $AWS_CLI_PROFILE sts get-session-token --duration $DURATION \
  --serial-number $ARN_OF_MFA --token-code $MFA_TOKEN_CODE --output text \
  | awk '{printf("export AWS_ACCESS_KEY_ID=\"%s\"\nexport AWS_SECRET_ACCESS_KEY=\"%s\"\nexport AWS_SESSION_TOKEN=\"%s\"\nexport AWS_SECURITY_TOKEN=\"%s\"\n",$2,$4,$5,$5)}' | tee ~/.token_file
