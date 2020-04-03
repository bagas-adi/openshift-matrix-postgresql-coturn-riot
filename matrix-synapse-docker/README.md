# matrix-synapse-docker
This is a dockerfile for a [matrix-org/synapse](https://github.com/matrix-org/synapse) homeserver, which will host the user accounts and the rooms, the uploaded media, etc...

The image exposes port `8448`.

**Note:** this image builds with `sqlite` support, so in order to enable postgresql support instead, please edit the configuration files manually. *See: [matrix-org/synapse/blob/master/docs/postgres.rst](https://github.com/matrix-org/synapse/blob/master/docs/postgres.rst).*

**Note:** the image doesn't come with a TURN server, there is no VoIP support out of the box. Again, manual intervention is necessary to configure it. *See: [matrix-org/synapse/blob/master/docs/turn-howto.rst](https://github.com/matrix-org/synapse/blob/master/docs/turn-howto.rst).*

## Building the image

**Arguments:**

It is generally OK to leave the defaults where they exist.

* **SYNAPSE_VERSION** (string): a valid version label found at [matrix-org/synapse/releases](https://github.com/matrix-org/synapse/releases) (example: v0.31.0).

* **SYNAPSE_USERNAME** (string): name of the unprivileged user that will run the synapse server process. This user will be created within the docker image. *Default: `matrix-synapse`*

* **SYNAPSE_GROUPNAME** (string): name of the user group running the synapse server process. Similarly, the group will be created within the docker image.
 *Default: `matrix-synapse`*

* **SERVER_NAME** (string): fully-qualified domain name of the machine which will serve the synapse server. There is no default, hence you must provide a value here. The hostname must be resolvable over the intended network by all potential clients.

 *Note that a self-signed certificate (10 years validity) with CN=$SERVER_NAME will be created automatically. You should consider replacing with a real one, e.g. Let's Encrypt.*
* **CONFIG_FILE** (string): the name of the configuration file. Just the filename, no path.
*Default: `synapse.config.yaml`*

* **REPORT_STATS** [yes|no]: this sets whether the synapse server will report statistics. *Default: `no`*

**Example build command:**

This will create an image named `image_name` for a server url `synapse_server_url` and it will be tagged `latest`.

    docker build --build-arg SERVER_NAME=<synapse_server_url> -t <image_name> .

## Running

**Exposed volumes:**

* /data (configuration files and crypto material, e.g. certificate, private key...)
* /media_store (media sent through channels hosted on this server)
* /uploads

You may wish to make these volumes persist on disk.

**Exposed ports:**

* 8448/TCP

**Example run command:**

    docker run -d -v matrix-data:/data -v matrix-media:/media_store -p 8448:8448 <image_name>
