#!/bin/sh
# Generates the first-time config of the synapse server

if [ $# -ne 3 ]; then
	echo "ERROR: $0 requires 3 arguments.
		1. SERVER_NAME: the domain name for the server.
		2. CONFIG_FILE: path to the config file
		3. REPORT_STATS: reporting stats to central server [yes|no]."
	exit 1;
fi

# args
SERVER_NAME=${1}
CONFIG_FILE=${2}
REPORT_STATS=${3}

if [ ! -f $CONFIG_FILE ]; then
	echo "Generating Synapse config file with values:
	  SERVER_NAME: $SERVER_NAME
	  REPORT_STATS: $REPORT_STATS"

	python3 -m synapse.app.homeserver \
		--server-name $SERVER_NAME \
		--config-path $CONFIG_FILE \
		--generate-config \
		--report-stats $REPORT_STATS
	if [ $? -eq 0 ]; then
		echo "Done."
	fi
else
	echo "Config file $CONFIG_FILE already exists. Please edit it instead"
fi
