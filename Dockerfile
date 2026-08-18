FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="zrok-share"
LABEL org.opencontainers.image.description="Share a local HTTP service through zrok"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/ilinyhgleb/zrok-share"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg && \
    rm -rf /var/lib/apt/lists/*
RUN curl -sSLf https://get.openziti.io/install.bash | bash -s zrok2

RUN useradd -m -u 2171 ziggy

USER ziggy
WORKDIR /home/ziggy

COPY --chmod=755 start.sh /usr/local/bin/start.sh

ENV ZROK2_TARGET=http://localhost:30109
ENV ZROK2_MODE=public

ENTRYPOINT ["/usr/local/bin/start.sh"]

