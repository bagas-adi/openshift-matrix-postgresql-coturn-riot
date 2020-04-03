FROM alpine:3.9

# this arg here ensures the dependencies are updated along with riot itself
ARG RIOT_VERSION

RUN apk update && apk add shadow openssl gnupg apache2

ENV DOWNLOAD_DIR="/download"
ENV WEBAPP_DIR="/var/www/localhost/htdocs/riot-web"

# setup "build" envirionment
# get some scripts
RUN mkdir /build
COPY scripts/ensure_user_and_group.sh /build/ensure_user_and_group.sh
COPY scripts/alter_config.sh /build/alter_config.sh
COPY scripts/install.sh /build/install.sh

# fetch, verify and install riot.im
RUN /build/install.sh $DOWNLOAD_DIR $WEBAPP_DIR $RIOT_VERSION

# patch pamd permissions for chpasswd (https://bugs.alpinelinux.org/issues/10209)
COPY scripts/patch_pamd_chpasswd /etc/pam.d/chpasswd

# certificate handling
ENV CERT_NAME=riot-web-app-cert.pem
ENV KEY_NAME=riot-web-app-key.pem
ENV CERT_DIR="/certs"
ARG SERVER_NAME
RUN mkdir $CERT_DIR
RUN openssl req -newkey rsa:4096 -new -nodes -x509 -days 3650 -keyout $CERT_DIR/$CERT_NAME -out $CERT_DIR/$CERT_NAME -subj "/C=FR/ST=BarbedLand/O=BarbedGroup/CN=$SERVER_NAME"

ARG RIOT_USERNAME=matrix-riot-web
ARG RIOT_GROUPNAME=matrix-riot-web
ARG DEFAULT_HS_HOSTNAME=matrix.org
ARG DEFAULT_HS_PORT=8448
# create the unprivileged user and group matrix-synapse
RUN /build/ensure_user_and_group.sh $RIOT_USERNAME $RIOT_GROUPNAME
RUN chmod o+r $WEBAPP_DIR

# change some config points
RUN /build/alter_config.sh $WEBAPP_DIR $DEFAULT_HS_HOSTNAME $DEFAULT_HS_PORT

#USER $RIOT_USERNAME:$RIOT_GROUPNAME
USER root
ENTRYPOINT exec httpd -D FOREGROUND -E $CERT_DIR/$CERT_NAME -d $WEBAPP_DIR
EXPOSE 80
VOLUME ["$CERT_DIR"]
