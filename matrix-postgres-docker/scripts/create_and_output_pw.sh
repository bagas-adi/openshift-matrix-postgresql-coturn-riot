#!/bin/sh
# creates and outputs a random password

PW=$(pwgen -s 64 1)

# output to stdout
echo $PW
