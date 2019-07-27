#!/bin/bash
setToken() {
    ~/mfa.sh $1 $2
    source ~/.token_file
    echo "Your creds have been set in your env."
}
alias mfa=setToken
