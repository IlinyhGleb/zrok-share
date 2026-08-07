#!/bin/sh

set -eux

CONFIG="${HOME}/.zrok/environment.json"

if [ ! -f "$CONFIG" ]; then
    echo "ERROR: ${CONFIG} not found."
    exit 1
fi

#zrok overview

zrok -v share "${ZROK_MODE}" "${ZROK_TARGET}"

#curl -v https://api-v1.zrok.io/api/v1/

#sleep 6000
