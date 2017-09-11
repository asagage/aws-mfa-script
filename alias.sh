#!/bin/bash
setToken() {
    #do things with parameters like $1 such as
    ~/aws-mfa-script/mfa.sh $1 $2
    source ~/aws-mfa-script/.token_file
    echo "Your creds have been set in your env."
}
alias mfa=setToken
