#!/bin/sh

set -eux

CONFIG="${HOME}/.zrok/environment.json"

echo "HOME=$HOME"
echo "USER=$(id)"
pwd

ls -la "$HOME"
ls -la "$HOME/.zrok"

if [ ! -f "$CONFIG" ]; then
    echo "ERROR: ${CONFIG} not found."
    exit 1
fi

echo "=== zrok status ==="
zrok status || true

echo "=== starting share ==="
zrok -v share "${ZROK_MODE}" "${ZROK_TARGET}" 2>&1 | tee /tmp/zrok.log

echo "Exit code: $?"

echo "=== log ==="
cat /tmp/zrok.log

sleep 6000
