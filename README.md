# zrok-share

A lightweight Docker image that exposes a local HTTP service through zrok.

## Features

- Uses an existing zrok environment
- No enable token stored in the container
- Generic: works with any HTTP service
- Runs zrok in headless mode
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

Generate your zrok environment once:

```bash
mkdir zrok2

docker run --rm -it \
    -v "$(pwd)/zrok2:/home/ziggy/.zrok2" \
    --entrypoint zrok2 \
    zrok-share \
    enable YOUR_ENABLE_TOKEN
```

For the published image:

```bash
mkdir zrok2

docker run --rm -it \
    -v "$(pwd)/zrok2:/home/ziggy/.zrok2" \
    --entrypoint zrok2 \
    ghcr.io/ilinyhgleb/zrok-share:latest \
    enable YOUR_ENABLE_TOKEN
```

This creates the zrok environment in:

```text
zrok2/
├── environment.json
├── identities/
│   └── environment.json
└── metadata.json
```

The files contain your zrok identity and should be kept private.

See `example_environment.json` for an example of the environment configuration.

## Run

For a service accessible from the container as `localhost`:

```bash
docker run -d \
  --name zrok-share \
  -e ZROK2_TARGET=http://localhost:30109 \
  -e ZROK2_MODE=public \
  -v "$(pwd)/zrok2:/home/ziggy/.zrok2:ro" \
  ghcr.io/ilinyhgleb/zrok-share:latest
```

For a service running on another host:

```bash
docker run -d \
  --name zrok-share \
  -e ZROK2_TARGET=http://192.168.1.5:30109 \
  -e ZROK2_MODE=public \
  -v "$(pwd)/zrok2:/home/ziggy/.zrok2:ro" \
  ghcr.io/ilinyhgleb/zrok-share:dev
```

The container runs:

```bash
zrok2 share "$ZROK2_MODE" --headless "$ZROK2_TARGET"
```

zrok prints the public URL in the container logs.

## Environment variables

| Variable       | Default                  | Description            |
| -------------- | ------------------------ | ---------------------- |
| `ZROK2_TARGET` | `http://localhost:30109` | HTTP service to expose |
| `ZROK2_MODE`   | `public`                 | zrok share mode        |

## Examples

Expose n8n:

```text
ZROK2_TARGET=http://n8n:5678
```

Expose Home Assistant:

```text
ZROK2_TARGET=http://homeassistant:8123
```

Expose a web server on the local network:

```text
ZROK2_TARGET=http://192.168.1.10:8080
```

## TrueNAS SCALE

Create a **Custom App**.

Mount the directory containing your zrok2 environment:

| Host              | Container            |
| ----------------- | -------------------- |
| `/mnt/apps/zrok2` | `/home/ziggy/.zrok2` |

Set the environment variables:

```text
ZROK2_TARGET=http://n8n:5678
ZROK2_MODE=public
```

Deploy the app and check the container logs.

zrok prints the public URL after startup.

## Security

The zrok environment files contain authentication information. Do not commit them to Git or share them publicly.

Keep the `zrok2` directory outside the repository or add it to `.gitignore`.
