# aws-mfa-script
Script to fetch an MFA token for you to use temporary aws access credentials

I got this somewhere on github and made some changes to it to require 
less parameters and remember my MFA ARN.  

The profile name should be the name of the profile stanza in your 
`~/.aws/credentials` file as used by the aws-cli.

The ARN should be the ARN of your MFA device as specified in the AWS console.

The MFA code is the code your MFA device gives you.

## Installation

 1. Extract the files to your home directory `~/`
 2. Add `source ./alias.sh` to your `~/.bashrc`
 3. Copy `SAMPLE-mfa.cfg` to `~/mfa.cfg` 
 4. Add a profile name and MFA ARN for each aws cli profile you wish to use. The key should be the profile name and the value should be the ARN of the MFA to use for that profile.

## Running the script

At a command prompt run the following command.

```bash
mfa <optional-aws-profile> <optional-token-duration>
```

Or you can just run "mfa" and it will use the default profile and a default time duration.
For usage execute "mfa -h".

### Alias Note

Scripts run in a subprocess of the calling shell.  This means that 
if you attempt to set the env vars in the script, they will only persist
inside that subprocess.  The `alias.sh` script sets an alias function to source the env vars into your main shell whenever you 
run the `mfa` command.

### Assume role helper

Also added a assume_role script that works very similar as mfa script, uses roles.cfg for the assuming any roles.

To use this with MFA make sure your policies have the following:

```bash
"Condition": {
        "Bool": {
            "aws:MultiFactorAuthPresent": "true"
        }
}
```
For further reference: https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html

### Assume Role Usage:

Copy `SAMPLE-roles.cfg` to `~/roles.cfg`

Assume role using assume_role script.

```bash
assume_role <alias-role-on-role.cfg>
```

### Clear Creds
There is also an script to clear the environment credentials. This is helpful if you are moving from one role to another without having to wait for the duration of the token to expire.

```bash
clear_creds
```
