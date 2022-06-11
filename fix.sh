#!/usr/bin/env bash

if [ $# -lt 2 ]; then
    echo >&2 "Usage: $0 container-id dev"
    exit 1
fi

container=$1
dev=$2

bolt_image=criztovyl/boltcli
if ! podman inspect --type image $bolt_image >/dev/null
then podman build -t $bolt_image .
fi

run-bolt-lua-tmp(){

    lua_tmp=$1

    podman run --rm \
        -v $lua_tmp:/mnt/lua -v ~/.local/share/containers/storage/libpod/bolt_state.db:/mnt/db \
        $bolt_image \
        boltcli -e /mnt/lua /mnt/db

    rm -f $lua_tmp

}

get_config_lua=$(mktemp)
cat >$get_config_lua <<EOT
print(bolt.get("ctr","$container", "config"))
EOT

fixed_config_json=$(
run-bolt-lua-tmp $get_config_lua | tee config.json |
    jq ".spec.mounts |= map(select(.source != \"$dev\"))" | tee fixed.json |
    jq ".|tojson"
)

diff -u <(jq . config.json) <(jq . fixed.json)

set_lua=$(mktemp)
cat >$set_lua <<EOT
bolt.set("ctr", "$container", "config", $fixed_config_json)
EOT

run-bolt-lua-tmp $set_lua
