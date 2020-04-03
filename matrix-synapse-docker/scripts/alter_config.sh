#!/bin/sh
# Configures the log settings for the Synapse server

DATA_DIR=${1}
CONFIG_FILE=${2}
SERVER_NAME=${3}

# log file location in server's main config
sed -i "s|log_file: \"/homeserver.log\"|log_file: \"$DATA_DIR/synapse.log\"|g" $DATA_DIR/$CONFIG_FILE

# log file location in log-specific config file
sed -i "s|filename:\s/homeserver.log|filename: $DATA_DIR/synapse.log|g" $DATA_DIR/$SERVER_NAME.log.config

# database location
sed -i "s|database:\s\"/homeserver.db\"|    database: \"$DATA_DIR/synapse.db\"|g" $DATA_DIR/$CONFIG_FILE

# pidfile location
sed -i "s|pid_file:\s/homeserver.pid|pid_file: $DATA_DIR/synapse.pid|g" $DATA_DIR/$CONFIG_FILE

# disable bundled client
sed -i "s|- webclient  # The bundled|# - webclient  # The bundled|g" $DATA_DIR/$CONFIG_FILE

# URL preview
sed -i "s|url_preview_enabled: False|url_preview_enabled: True|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# url_preview_ip_range_blacklist:|url_preview_ip_range_blacklist:|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# - '127.0.0.0/8'| - '127.0.0.0/8'|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# - '10.0.0.0/8'| - '10.0.0.0/8'|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# - '172.16.0.0/12'| - '172.16.0.0/12'|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# - '192.168.0.0/16'| - '192.168.0.0/16'|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# - '100.64.0.0/10'| - '100.64.0.0/10'|g" $DATA_DIR/$CONFIG_FILE
sed -i "s|# - '169.254.0.0/16'| - '169.254.0.0/16'|g" $DATA_DIR/$CONFIG_FILE
