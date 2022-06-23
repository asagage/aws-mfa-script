#!/bin/bash
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P  )"
setToken() {
    AWS_CLI_PROFILE=${2:-default}
    $SCRIPT_PATH/mfa.sh $1 $2 $3
    TOKEN_FILE=${3:-$HOME/.mfa/creds/${AWS_CLI_PROFILE}_token_file}
    source $TOKEN_FILE
    echo "Your creds have been set in your env."
}
alias mfa=setToken
