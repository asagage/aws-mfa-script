# aws-mfa-script
Script to fetch an MFA token for you to use temporary aws access credentials

I got this somewhere on github and made some changes to it to require less parameters and remember my MFA ARN.  I copy this script with those hardcoded values set for each profile I need to run against and then just run:
 
 mfa-account1.sh
 mfa-account2.sh 

Be sure to update the following variables to match your AWS settings.

AWS_CLI_PROFILE="default"
ARN_OF_MFA="arn:aws:iam::12345:mfa/user"

The profile name should be the name of the profile stanza in your ~/.aws/credentials file as used by the aws-cli.

The ARN should be the ARN of your MFA device as specified in the AWS console.
