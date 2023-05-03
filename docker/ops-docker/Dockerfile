FROM debian:stable-slim

ARG DOCKER_VERSION='23.0.5'

RUN apt-get update \
&&  apt-get install -y --no-install-recommends \
software-properties-common \
apt-utils \
apt-transport-https \
lsb-release \
ca-certificates \
gnupg \
gnupg1 \
gnupg2 \
tini \
curl \
wget

RUN set -eux; \
curl -fsSL https://get.docker.com | sh

COPY d-entrypoint.sh /d-entrypoint.sh

RUN set -eux; \
mkdir -p \
/src \
/var/run; \
chmod 777 -R \
/src \
/var/run; \
chmod +x \
/d-entrypoint.sh

WORKDIR /src

ENTRYPOINT ["/d-entrypoint.sh"]
