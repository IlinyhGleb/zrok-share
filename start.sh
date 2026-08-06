#!/bin/sh

set -eu

CONFIG=/root/.zrok/environment.json

if [ ! -f "$CONFIG" ]; then
    echo
    echo "ERROR: zrok is not initialized."
    echo
    echo "Mount a directory containing:"
    echo
    echo "  /root/.zrok/environment.json"
    echo
    echo "Generate it once with:"
    echo
    echo "  zrok enable <your_enable_token>"
    echo
    exit 1
fi

echo "Sharing ${ZROK_TARGET}..."

exec zrok share "${ZROK_MODE}" "${ZROK_TARGET}"
