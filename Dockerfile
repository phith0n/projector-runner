FROM openjdk:11-jre

LABEL maintainer="phith0n <root@leavesongs.com>"

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends libxext6 libxrender1 libxtst6; \
    wget -qO /tmp/projector.zip https://github.com/JetBrains/projector-server/releases/download/agent-v1.2.3/projector-plugin-agent-v1.2.3.zip; \
    mkdir /opt/projector; \
    cd /opt/projector; \
    unzip /tmp/projector.zip -d .; \
    mv projector-*/* ./; \
    rm -rf projector-*/ /tmp/projector.zip /var/lib/apt/lists/*

WORKDIR /opt/projector
EXPOSE 8887
ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
