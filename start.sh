#!/bin/sh

set -eux

CONFIG="${HOME}/.zrok2/environment.json"

if [ ! -f "$CONFIG" ]; then
    echo "ERROR: ${CONFIG} not found."
    exit 1
fi

exec zrok2 share --headless "$ZROK2_MODE" "$ZROK2_TARGET"
