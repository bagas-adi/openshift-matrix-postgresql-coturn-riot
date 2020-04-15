FROM alpine:3.11

# install runtime and build-time dependencies
ENV RT_DEPS="python3 libjpeg zlib sqlite libpq shadow libxslt openssl libffi"
ENV BUILD_DEPS="git gcc make python3-dev musl-dev libffi-dev openssl-dev linux-headers jpeg-dev zlib-dev postgresql-dev libxslt-dev"
ENV CHECKOUT_DIR=synapse
ARG SYNAPSE_VERSION

# copy setup scripts and entry point
COPY install.sh /build/install.sh
RUN /build/install.sh "$RT_DEPS" "$BUILD_DEPS" $CHECKOUT_DIR $SYNAPSE_VERSION

# these folders are to be exported into docker volumes
ENV DATA_DIR="/data"
RUN mkdir $DATA_DIR
RUN mkdir /uploads
RUN mkdir /media_store

# set some permissions for the unprivileged user to be able to do anything
RUN chmod -R o+rw /data
RUN chmod -R o+rw /media_store
RUN chmod -R o+rw /uploads

