# riot-web-docker
A docker image for a Matrix [Riot.im web client -- vector-im/riot-web](https://github.com/vector-im/riot-web).

This is a web client for Matrix. It's a bundle of static files destined to run on the client machine, so there is no need for a complicated web server installation to serve it.

The image exposes port `8080`.

## Building the image

**Arguments:**

It is generally OK to leave the defaults where they exist.

* **RIOT_VERSION** (string): a valid release label found at [vector-im/riot-web](https://github.com/vector-im/riot-web/releases) (example: v0.15.4).

* **SERVER_NAME** (string): fully-qualified domain name of the machine which will serve the static files for the riot.im client. There is no default, hence you must provide a value here. The hostname must be resolvable over the intended network by all potential clients.

 *Note that a self-signed certificate (10 years validity) with CN=$SERVER_NAME will be created automatically. You should consider replacing with a real one, e.g. Let's Encrypt.*

* **RIOT_USERNAME** (string): the name of the system user that will run the static files web server serving the riot.im client. It will be created within the docker image. *Default: `matrix-riot-web`*

* **RIOT_GROUPNAME** (string): the name of the system user group that will run the static files web server serving the riot.im client. Similarly, it will be created within the docker image. *Default: `matrix-riot-web`*

* **DEFAULT_HS_HOSTNAME** (string): the full hostname of the default Matrix server the riot.im client should show when brought up on a user-agent. This is not the same as `SERVER_NAME` unless both riot.im and the Matrix server are hosted on the same host. *Default: `matrix.org`*

* **DEFAULT_HS_PORT** (int): the port of the default Matrix server shown on this instance of riot.im. *Default: `8448`*

**Example build command:**

This will create an image named `image_name` for a server url `synapse_server_url` and it will be tagged `latest`.

    docker build --build-arg SERVER_NAME=<riot.im_server_name> --build-arg DEFAULT_HS_HOSTNAME=<myownmatrixserver.org> --build-arg RIOT_VERSION=<label_version> -t <image_name> .

## Running

**Exposed volumes:**

* /certs (certificates)

**Exposed ports:**

* 8080/TCP

**Example run command:**

    docker run -d -v riot-certs:/certs -p 8080:8080 <image_name>
