#!/bin/bash
# set -x
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

if [ -z ~/.token_file ]
then
    source ~/..token_file
fi

# 1 argument is ok
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <AWS_CLI_ROLE>"
    echo "Where:"
    echo "   <AWS_CLI_ROLE> = aws role in $HOME/roles.cfg"
    exit 2
fi

echo "Reading config..."
if [ ! -r ~/roles.cfg ]; then
  echo "No config found.  Please create your mfa.cfg.  See README.txt for more info."
  exit 2
fi

AWS_CLI_ROLE=${1:-default}
DURATION=${2:-129600}
ARN_OF_ROLE=$(grep "^$AWS_CLI_ROLE" ~/roles.cfg | cut -d '=' -f2- | tr -d '"')

echo "AWS-CLI ROLE: $AWS_CLI_ROLE"
echo "ROLE ARN: $ARN_OF_ROLE"

echo "Your Temporary Creds:"
aws sts assume-role --role-arn $ARN_OF_ROLE \
    --role-session-name $AWS_CLI_ROLE --query "Credentials" --output text \
  | awk '{printf("export AWS_ACCESS_KEY_ID=\"%s\"\nexport AWS_SECRET_ACCESS_KEY=\"%s\"\nexport AWS_SESSION_TOKEN=\"%s\"\nexport AWS_SECURITY_TOKEN=\"%s\"\n",$1,$3,$4,$4)}' | tee ~/.token_file
