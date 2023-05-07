FROM debian:stable-slim

ENV \
XDG_CACHE_HOME="/var/cache/helm"

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
patch \
unzip \
git \
tini \
curl \
wget

RUN set -eux; \
mkdir -p /usr/share/keyrings; \
curl -fsSL https://baltocdn.com/helm/signing.asc \
| gpg --dearmor -o /usr/share/keyrings/helm.gpg; \
echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/helm.gpg] \
https://baltocdn.com/helm/stable/debian/ all main" \
| tee /etc/apt/sources.list.d/helm.list > /dev/null

RUN set -eux; \
apt-get update; \
apt-get install -y --no-install-recommends \
helm

COPY d-entrypoint.sh /d-entrypoint.sh

RUN set -eux; \
mkdir -p \
/var/cache/helm \
/src; \
chmod 777 -R \
/var/cache \
/src; \
chmod +x \
/d-entrypoint.sh

WORKDIR /src

ENTRYPOINT ["/d-entrypoint.sh"]
