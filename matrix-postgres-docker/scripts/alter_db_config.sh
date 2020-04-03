#!/bin/sh
# creates a random password, outputs it to stdout, alters a sql file

SQL_FILE=${1}
PW=${2}

# enounce the password
echo "The generated user password is: ${PW}"
echo "Paste it in your matrix-synapse configuration file."

# alter the sql file
PATTERN="PW_PLACEHOLDER"
sed -i "s|${PATTERN}|${PW}|g" $SQL_FILE
