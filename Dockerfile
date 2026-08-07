FROM openziti/zrok:latest

LABEL org.opencontainers.image.title="zrok-share"
LABEL org.opencontainers.image.description="Share a local HTTP service through zrok"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/ilinyhgleb/zrok-share"

USER root

COPY --chmod=755 start.sh /usr/local/bin/start.sh

# For local run
#COPY --chmod=755 ./zrok /home/ziggy/.zrok

USER ziggy

ENV ZROK_TARGET=http://192.168.1.5:30109
ENV ZROK_MODE=public

ENTRYPOINT ["/usr/local/bin/start.sh"]
