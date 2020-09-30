#!/bin/bash
setToken() {
    ~/mfa.sh $1 $2
    source ~/.token_file
    echo "Your creds have been set in your env."
}
AssumeRole() {
    ~/assume_role.sh $1
    source ~/.token_file
    echo "Your creds have been set in your env."
}
clearToken() {
    ~/mfa-clear.sh
    source ~/.token_file
    echo "Your creds have been cleared."
}
alias mfa=setToken
alias clear_creds=clearToken
alias assume_role=AssumeRole
