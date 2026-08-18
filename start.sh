#!/bin/sh

set -eux

CONFIG="${HOME}/.zrok2/environment.json"

if [ ! -f "$CONFIG" ]; then
    echo "ERROR: ${CONFIG} not found."
    exit 1
fi

mkdir -p "${HOME}/shared"

LOG="${HOME}/shared/zrok.log"
URL_FILE="${HOME}/shared/zrok-url"

# Start zrok and save its output to the shared log.
zrok2 share "$ZROK2_MODE" --headless "$ZROK2_TARGET" 2>&1 |
    tee "$LOG" &

# Wait until zrok prints its public URL.
while ! grep -qE '[[:alnum:]]+\.shares\.zrok\.io' "$LOG"; do
    sleep 1
done

# Extract the public zrok URL.
grep -oE '[[:alnum:]]+\.shares\.zrok\.io' "$LOG" |
    head -n 1 |
    sed 's|^|https://|' > "$URL_FILE"

if [ ! -s "$URL_FILE" ]; then
    echo "ERROR: failed to extract zrok URL."
    exit 1
fi

echo "zrok URL: $(cat "$URL_FILE")"

# Keep the container running while zrok is running.
wait
