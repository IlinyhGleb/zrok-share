# zrok-share

A lightweight Docker image that exposes a local HTTP service through zrok.

## Features

- Uses an existing zrok environment
- No enable token stored in the container
- Generic: works with any HTTP service
- Suitable for Docker and TrueNAS SCALE

## Build

```bash
docker build -t zrok-share .
```

## Initialize zrok

Run once on any machine:

```bash
mkdir zrok

docker run --rm -it \
    -v $(pwd)/zrok:/root/.zrok \
    openziti/zrok enable YOUR_ENABLE_TOKEN
```

The generated `environment.json` is your zrok identity.

## Run

```bash
docker run -d \
    --name zrok-share \
    -e ZROK_TARGET=http://host.docker.internal:5678 \
    -v $(pwd)/zrok:/root/.zrok:ro \
    zrok-share
```

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `ZROK_TARGET` | `http://localhost:30109` | Service to expose |
| `ZROK_MODE` | `public` | Share mode |

## Example

Expose n8n:

```text
ZROK_TARGET=http://n8n:5678
```

Expose Home Assistant:

```text
ZROK_TARGET=http://homeassistant:8123
```

Expose any local web server:

```text
ZROK_TARGET=http://192.168.1.10:8080
```

## TrueNAS SCALE

Create a Custom App.

Mount:

| Host | Container |
|------|-----------|
| `/mnt/apps/zrok` | `/root/.zrok` |

Environment variables:

```text
ZROK_TARGET=http://n8n:5678
```

Deploy the app and check the logs.

zrok prints the public URL after startup.
