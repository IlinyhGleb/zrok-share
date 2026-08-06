# zrok-share

A lightweight Docker image that exposes a local HTTP service through zrok.

## Features

- Uses an existing zrok environment
- No enable token stored in the container
- Generic: works with any HTTP service
- Suitable for Docker and TrueNAS SCALE

## Repository

```text
.
├── Dockerfile
├── start.sh
├── example_environment.json
└── README.md
```

## Build

```bash
docker build -t zrok-share .
```

## Initialize zrok

Generate your zrok identity once:

```bash
mkdir zrok

docker run --rm -it \
    -v $(pwd)/zrok:/home/ziggy/.zrok \
    openziti/zrok enable YOUR_ENABLE_TOKEN
```

This creates:

```text
zrok/
└── environment.json
```

The file contains your zrok identity and should be kept private.

See `example_environment.json` for the expected file name and location.

## Run

```bash
docker run -d \
  --name zrok-share \
  -e ZROK_TARGET=http://host.docker.internal:5678 \
  -v $(pwd)/zrok:/home/ziggy/.zrok:ro \
  ghcr.io/ilinyhgleb/zrok-share:latest
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
| `/mnt/apps/zrok` | `/home/ziggy/.zrok` |

Environment variables:

```text
ZROK_TARGET=http://n8n:5678
```

Deploy the app and check the logs.

zrok prints the public URL after startup.

## Security

`environment.json` contains your zrok identity. Do not commit it to Git or share it publicly.
