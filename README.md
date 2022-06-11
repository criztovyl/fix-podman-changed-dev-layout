Script for fixing missing `/dev` nodes for starting a stopped podman container, e.g. after USB device was newly plugged in or one unplugged.

    ./fix.sh container-id dev-node

for example

    ./fix.sh d43fdc7199a4c9475c9b51ee3e0cc667d55376ff7182befcaecfe6779b6d56cb /dev/bus/usb/003/003
