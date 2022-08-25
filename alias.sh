#!/bin/bash
SHELL_PROCESS=`ps -p $$ | sed -n 2p`
if [[ "${SHELL_PROCESS}" == *"zsh"* ]]; then
  RELEVANT_BASH_SOURCE="${(%):-%N}"
else
  RELEVANT_BASH_SOURCE="${BASH_SOURCE[0]}"
fi
SCRIPT_PATH="$( cd -- "$(dirname -- "${RELEVANT_BASH_SOURCE}")" >/dev/null 2>&1 ; pwd -P  )"
setToken() {
    $SCRIPT_PATH/mfa.sh $1 $2
    source ~/.token_file
    echo "Your creds have been set in your env."
}
alias mfa=setToken
