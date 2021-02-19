#!/bin/bash
DIR="$(dirname $(realpath ${BASH_SOURCE}))"
setToken() {
    $DIR/mfa.sh $1 $2
    source $DIR/.token_file
    echo "Your creds have been set in your env."
}
alias mfa=setToken
