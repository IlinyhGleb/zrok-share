FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="zrok-share"
LABEL org.opencontainers.image.description="Share a local HTTP service through zrok"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/ilinyhgleb/zrok-share"

RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download zrok
ARG ZROK_VERSION=v2.0.4

RUN curl -L \
  -o /tmp/zrok.tar.gz \
  https://github.com/openziti/zrok/releases/download/${ZROK_VERSION}/zrok_${ZROK_VERSION#v}_linux_amd64.tar.gz

RUN useradd -m -u 2171 ziggy

USER ziggy
WORKDIR /home/ziggy

COPY --chmod=755 start.sh /usr/local/bin/start.sh

# For local run
#COPY --chmod=755 ./zrok /home/ziggy/.zrok

ENV ZROK_TARGET=http://localhost:30109
ENV ZROK_MODE=public

ENTRYPOINT ["/usr/local/bin/start.sh"]
