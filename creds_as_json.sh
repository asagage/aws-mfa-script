#!/bin/bash

if [ $# -ne 1 ]; then
    PROFILE=default
else
    PROFILE=$1
fi

SOURCE_FILE=$(readlink -f ${BASH_SOURCE[0]})
DIR=$(dirname ${SOURCE_FILE})

FILENAME="$DIR/creds/${PROFILE}_token_file"
source $FILENAME

echo '{"accessKeyId": "'"$AWS_ACCESS_KEY_ID"'","secretAccessKey": "'"$AWS_SECRET_ACCESS_KEY"'","sessionToken": "'"$AWS_SESSION_TOKEN"'"}'


