#!/bin/sh

RT_DEPS=${1}
BUILD_DEPS=${2}
CHECKOUT_DIR=${3}
SYNAPSE_VERSION=${4}

# this installs not only runtime dependencies, but also build-time dependencies
apk update && apk add $RT_DEPS $BUILD_DEPS

# python packages, dependencies
# from https://github.com/matrix-org/synapse/blob/master/UPGRADE.rst
pip3 install --upgrade pip setuptools
pip3 install --upgrade psycopg2 lxml

# install the main package
pip3 install matrix-synapse[all]==${SYNAPSE_VERSION:1}

# cleanup
rm -rf $CHECKOUT_DIR
apk del $BUILD_DEPS

