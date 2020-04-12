#!/bin/sh
# This will enable the configuration and change key parts of the riot.im client

WEBAPP_DIR=${1}
DEFAULT_HS_HOSTNAME=${2}
DEFAULT_HS_PORT=${3}

HOST_AND_PORT=${DEFAULT_HS_HOSTNAME}:${DEFAULT_HS_PORT}

# enable the config by copying config.sample.json
if [ ! -f $WEBAPP_DIR/config.json ]; then
	cp $WEBAPP_DIR/config.sample.json $WEBAPP_DIR/config.json
fi

# change settings inside config.json
sed -i "s|\"default_hs_url\":\s\"https://matrix.org\"|\"default_hs_url\": \"https://${HOST_AND_PORT}\"|g" $WEBAPP_DIR/config.json
