#!/bin/sh

set -eux

CONFIG="${HOME}/.zrok2/environment.json"

if [ ! -f "$CONFIG" ]; then
    echo "ERROR: ${CONFIG} not found."
    exit 1
fi

echo "stdin:"
test -t 0 && echo "TTY" || echo "NO TTY"

echo "stdout:"
test -t 1 && echo "TTY" || echo "NO TTY"

echo "stderr:"
test -t 2 && echo "TTY" || echo "NO TTY"

exec zrok2 share "$ZROK2_MODE" "$ZROK2_TARGET"
