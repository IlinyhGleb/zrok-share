#!/bin/sh

set -eux

CONFIG="${HOME}/.zrok/environment.json"

if [ ! -f "$CONFIG" ]; then
    echo "ERROR: ${CONFIG} not found."
    exit 1
fi

exec zrok share "$ZROK_MODE" "$ZROK_TARGET"
