#!/bin/bash

if [ ! -z ${ZSH_VERSION+x} ]; then
    echo "zsh set SCRIPT_PATH variable"
    echo ${(%):-%x}
    SCRIPT_PATH="$( cd -- "$(dirname -- "${(%):-%x}")" >/dev/null 2>&1 ; pwd -P  )"
elif [ ! -z ${BASH_VERSION+x} ]; then
    echo "bash set SCRIPT_PATH variable"
    echo $BASH_SOURCE
    SCRIPT_PATH="$( cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P  )"
else
    echo "shell not recognised"
    exit 1
fi

setToken() {
    $SCRIPT_PATH/mfa.sh $1 $2
    source ~/.token_file
    echo "Your creds have been set in your env."
}
alias mfa=setToken
