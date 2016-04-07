# aws-mfa-script
Script to fetch an MFA token for you to use temporary aws access credentials

I got this somewhere on github and made some changes to it to require 
less parameters and remember my MFA ARN.  

The profile name should be the name of the profile stanza in your 
~/.aws/credentials file as used by the aws-cli.

The ARN should be the ARN of your MFA device as specified in the AWS console.

The MFA code is the code your MFA device gives you.

Please see the mfa-install.sh file for an example of this alias function.

You will need to make a copy of the SAMPLE-mfa.cfg file named mfa.cfg.
This file will need a variable defined for each aws cli profile you wish
to use. The variable name should be the profile name and the value should 
be the ARN of the MFA to use for that profile. 

# Installation
 1. Extract the files to ~/
 2. Run the alias script as part of your shell profile.
 3. Copy the SAMPLE-mfa.cfg to your home directory as mfa.cfg and put your profile names and MFA ARN's in there.
 
# Running the script
At a command prompt run the dollowing command.
```mfa <mfacode> <optional-aws-profile>```
 
## Alias Note:
Scripts run in a subprocess of the calling shell.  This means that 
if you attempt to set the env vars in the script, they will only persist
inside that subprocess.  You can set an alias function to be run by your
shell that will source the env vars into your main shell whenever you 
run the mfa command alias.
