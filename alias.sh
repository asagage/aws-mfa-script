#!/bin/bash
setToken() {
    $(dirname "$0")/mfa.sh $1 $2
    source ~/.token_file
    echo "Your creds have been set in your env."
}
alias mfa=setToken
