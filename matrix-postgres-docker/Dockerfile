FROM postgres:10.3-alpine

# some packages
RUN apk update && apk add pwgen

# create a folder and copy the build scripts
RUN mkdir /build
COPY scripts/alter_db_config.sh /build/alter_db_config.sh
COPY scripts/create_and_output_pw.sh /build/create_and_output_pw.sh
COPY scripts/create_db.sql /docker-entrypoint-initdb.d/create_db.sql

# generate and replace pw
RUN /build/alter_db_config.sh /docker-entrypoint-initdb.d/create_db.sql $(/build/create_and_output_pw.sh)
