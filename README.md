Script for fixing Podman not being able to start stopped, privileged, containers due to gone-missing `/dev` nodes, e.g. when a USB device was unplugged since container creation.

Requires `jq`.

[podman#4900: a rootless privileged container refuses to start if a host device layout has changed](https://github.com/containers/podman/issues/4900)

    ./fix.sh container-id dev-node

for example

    ./fix.sh d43fdc7199a4c9475c9b51ee3e0cc667d55376ff7182befcaecfe6779b6d56cb /dev/bus/usb/003/003

Used tools:
* [Podman](https://github.com/containers/podman) from Debian repos
* [boltcli](https://github.com/spacewander/boltcli) from source, containerized in [docker.io/golang](https://hub.docker.com/_/golang/)
* [jq](https://github.com/stedolan/jq) from Debian repos
