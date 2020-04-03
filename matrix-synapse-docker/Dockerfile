FROM alpine:3.11

# install runtime and build-time dependencies
ENV RT_DEPS="python3 libjpeg zlib sqlite libpq shadow libxslt openssl libffi"
ENV BUILD_DEPS="git gcc make python3-dev musl-dev libffi-dev openssl-dev linux-headers jpeg-dev zlib-dev postgresql-dev libxslt-dev"
ENV CHECKOUT_DIR=synapse
ARG SYNAPSE_VERSION

# copy setup scripts and entry point
COPY scripts/install.sh /build/install.sh
COPY scripts/ensure_user_and_group.sh /build/ensure_user_and_group.sh
COPY scripts/alter_config.sh /build/alter_config.sh
COPY scripts/generate_config.sh /build/generate_config.sh

# install from github (haha!)
RUN /build/install.sh "$RT_DEPS" "$BUILD_DEPS" $CHECKOUT_DIR $SYNAPSE_VERSION

ARG SYNAPSE_USERNAME=matrix-synapse
ARG SYNAPSE_GROUPNAME=matrix-synapse
# create the unprivileged user and group matrix-synapse
RUN /build/ensure_user_and_group.sh $SYNAPSE_USERNAME $SYNAPSE_GROUPNAME

# these folders are to be exported into docker volumes
ENV DATA_DIR="/data"
RUN mkdir $DATA_DIR
# TODO: maybe make this dynamic?
RUN mkdir /uploads
RUN mkdir /media_store

ARG SERVER_NAME
ARG CONFIG_FILE="synapse.config.yaml"
ARG REPORT_STATS="no"
# create initial config file
RUN /build/generate_config.sh $SERVER_NAME $DATA_DIR/$CONFIG_FILE $REPORT_STATS
# configure log files to be in the /data folder
RUN /build/alter_config.sh $DATA_DIR $CONFIG_FILE $SERVER_NAME

# set some permissions for the unprivileged user to be able to do anything
RUN chmod -R o+rw /data
RUN chmod -R o+rw /media_store
RUN chmod -R o+rw /uploads

USER $SYNAPSE_USERNAME:$SYNAPSE_GROUPNAME

# this is a shell form entrypoint to enable var expansion
ENTRYPOINT exec python3 -m synapse.app.homeserver -c $DATA_DIR/$CONFIG_FILE
EXPOSE 8448
VOLUME ["$DATA_DIR", "/media_store", "/uploads"]
