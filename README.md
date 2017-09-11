# aws-mfa-script
Script to fetch an MFA token for you to use temporary aws access credentials

I got this somewhere on github and made some changes to it to require 
less parameters and remember my MFA ARN.  

  * The profile name should be the name of the profile stanza in your 
     ~~~~
     ~/.aws/credentials file as used by the aws-cli.
     ~~~~
  * The ARN should be the ARN of your MFA device as specified in the AWS console.
  - The MFA code is the code your MFA device gives you.
  - Please see the mfa-install.sh file for an example of this alias function.
  * You will need to make a copy of the SAMPLE-mfa.cfg file named mfa.cfg. This file will need a variable defined for each aws cli profile you wish to use. The variable name should be the profile name and the value should be the ARN of the MFA to use for that profile. 

# Installation
 1. git clone repo to ~/
 2. add the following line into your '~/.bash_profile' source ./aws-mfa-script/alias.sh
 3. fille your credentials in mfa.cfg.
 
# Running the script
At a command prompt run the dollowing command.
```mfa <mfacode> <optional-aws-profile>```
