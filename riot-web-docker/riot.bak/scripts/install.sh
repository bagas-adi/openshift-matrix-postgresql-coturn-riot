#!/bin/sh

DOWNLOAD_DIR=${1}
WEBAPP_DIR=${2}
RIOT_VERSION=${3}

# fetch, verify and unpack riot
mkdir $DOWNLOAD_DIR

wget -O $DOWNLOAD_DIR/riot.asc https://packages.riot.im/riot-release-key.asc
gpg --import $DOWNLOAD_DIR/riot.asc

wget -O $DOWNLOAD_DIR/riot-$RIOT_VERSION.tar.gz  https://github.com/vector-im/riot-web/releases/download/$RIOT_VERSION/riot-$RIOT_VERSION.tar.gz
wget -O $DOWNLOAD_DIR/riot-$RIOT_VERSION.tar.gz.asc https://github.com/vector-im/riot-web/releases/download/$RIOT_VERSION/riot-$RIOT_VERSION.tar.gz.asc

if gpg --verify $DOWNLOAD_DIR/riot-$RIOT_VERSION.tar.gz.asc; then
  tar -xf $DOWNLOAD_DIR/riot-$RIOT_VERSION.tar.gz
  mv riot-$RIOT_VERSION $WEBAPP_DIR
  rm $DOWNLOAD_DIR/riot-$RIOT_VERSION.tar.gz
fi

