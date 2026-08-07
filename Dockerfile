FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="zrok-share"
LABEL org.opencontainers.image.description="Share a local HTTP service through zrok"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/ilinyhgleb/zrok-share"

ARG TARGETARCH
ARG ZROK_VERSION=v2.0.4

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        tar && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL \
      "https://github.com/openziti/zrok/releases/download/${ZROK_VERSION}/zrok_${ZROK_VERSION#v}_linux_${TARGETARCH}.tar.gz" \
      | tar -xz -C /usr/local/bin

RUN useradd -m -u 2171 ziggy

USER ziggy
WORKDIR /home/ziggy

COPY --chmod=755 start.sh /usr/local/bin/start.sh

# For local run
COPY --chmod=755 ./zrok2 /home/ziggy/.zrok2

ENV ZROK_TARGET=http://localhost:30109
ENV ZROK_MODE=public

ENTRYPOINT ["/usr/local/bin/start.sh"]
