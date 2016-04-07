#!/bin/bash
setToken() {
    #do things with parameters like $1 such as
    ~/mfa.sh $1 $2
    source ~/.token_file
}
alias mfa=setToken