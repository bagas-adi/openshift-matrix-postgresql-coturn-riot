# matrix-postgres-docker
A custom postgres image for use with a Matrix server based on [`postgres:10.3-alpine`](https://hub.docker.com/_/postgres/).

This is an optional backend for the synapse server. It is recommended for long-running or production instances.

This image has been customised to automatically create a database and db user for the synapse server, as described in [matrix-org/synapse/blob/master/docs/postgres.rst](https://github.com/matrix-org/synapse/blob/master/docs/postgres.rst).

The image exposes port `5432`.

## Building the image

**Arguments:** none! (yay!)

The created db user is `synapse_user` and the related database is `synapse`.

**Note:** the build script will output something like `The generated user password is: <64 char long password>`. This is the db user's password that goes into the synapse server's configuration file.

**Example build command:**

This will create an image named `image_name` for a server url `synapse_server_url` and it will be tagged `latest`.

    docker build -t <image_name> .

## Running

**Exposed volumes:**

* /var/lib/postgresql/data (as per the base image [`postgres:10.3-alpine`](https://hub.docker.com/_/postgres/))

**Exposed ports:**

* 5432/TCP (as per the base image [`postgres:10.3-alpine`](https://hub.docker.com/_/postgres/))

**Example run command:**

    docker run -d -v postgres-data:/var/lib/postgresql/data -p 5432:5432 <image_name>

Note that when using within docker-compose, there is no need to forward the port (omitting the `-p` option).
