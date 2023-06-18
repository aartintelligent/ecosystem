FROM debian:stable-slim

ARG UID=1000
ARG GID=1000
ARG GIT_COMMIT

ENV \
GIT_COMMIT="${GIT_COMMIT}" \
SUPERVISOR_USERNAME="rootless" \
SUPERVISOR_PASSWORD="nopassword" \
SUPERVISOR_LOG_LEVEL="error" \
SUPERVISOR_LOG_FILE="/dev/stdout" \
SUPERVISOR_INCLUDE_FILES="/etc/supervisor/conf.d/*.conf" \
SSTMP_MAIL_HUB="" \
SSTMP_START_TLS="" \
SSTMP_USE_TLS="" \
SSTMP_FROM_LINE_OVERRIDE="" \
SSTMP_AUTH_USER="" \
SSTMP_AUTH_PASSWORD="" \
SSTMP_AUTH_METHOD="" \
SSTMP_REWRITE_DOMAIN="" \
SSTMP_HOSTNAME="" \
SSTMP_ROOT=""

RUN set -eux; \
apt-get update; \
apt-get install -y --no-install-recommends \
software-properties-common \
apt-transport-https \
apt-utils \
ca-certificates \
lsb-release \
supervisor \
ssmtp \
cron \
systemd \
patch \
unzip \
git \
vim \
gnupg \
gnupg1 \
gnupg2 \
wget \
curl

RUN set -eux; \
adduser -h /home/rootless -g "rootless" -D -u ${UID} rootless; \
echo "rootless:${UID}:${GID}" >> /etc/subuid; \
echo "rootless:${UID}:${GID}" >> /etc/subgid; \
echo "rootless:rootless:${UID}:${GID}:/rootless:/usr/bin" >> /etc/passwd; \
echo "rootless::${GID}:rootless" >> /etc/group

COPY --chown=rootless:rootless system /

RUN set -eux; \
mkdir -p \
/etc/supervisor \
/etc/cron.d \
/etc/cron.daily \
/etc/cron.hourly \
/etc/cron.monthly \
/etc/cron.weekly \
/var/pid \
/var/run \
/var/lock \
/var/log \
/var/cache \
/var/lib \
/var/www; \
chmod 777 -R \
/etc/supervisor \
/etc/crontab \
/etc/cron.d \
/etc/cron.daily \
/etc/cron.hourly \
/etc/cron.monthly \
/etc/cron.weekly \
/var/pid \
/var/run \
/var/lock \
/var/log \
/var/cache \
/var/lib \
/var/www; \
chown rootless:rootless \
/etc/supervisor \
/etc/crontab \
/etc/cron.d \
/etc/cron.daily \
/etc/cron.hourly \
/etc/cron.monthly \
/etc/cron.weekly \
/var/pid \
/var/run \
/var/lock \
/var/log \
/var/cache \
/var/lib \
/var/www; \
rm -rf \
/etc/cron.d/* \
/etc/cron.daily/* \
/etc/cron.hourly/* \
/etc/cron.monthly/* \
/etc/cron.weekly/*; \
chmod +x \
/docker/d-bootstrap.sh \
/docker/d-bootstrap-supervisor.sh \
/docker/d-bootstrap-environment.sh \
/docker/d-bootstrap-ssmtp.sh \
/docker/d-cleanup.sh \
/docker/d-entrypoint.sh \
/docker/d-health.sh \
/docker/d-start.sh \
/docker/d-health-cron.sh \
/docker/d-health-supervisor.sh \
/docker/d-stop.sh; \
touch /etc/cron.allow; \
echo "rootless"  > /etc/cron.allow; \
chmod u+s /usr/sbin/cron; \
touch /etc/environment; \
chown rootless:rootless /etc/environment; \
echo "/docker/d-bootstrap-supervisor.sh" >> /docker/d-bootstrap.list; \
echo "/docker/d-bootstrap-environment.sh" >> /docker/d-bootstrap.list; \
echo "/docker/d-bootstrap-ssmtp.sh" >> /docker/d-bootstrap.list; \
echo "/docker/d-bootstrap.sh" >> /docker/d-entrypoint.list; \
echo "/docker/d-cleanup.sh" >> /docker/d-entrypoint.list

ENTRYPOINT ["/docker/d-entrypoint.sh"]

WORKDIR /var/www

STOPSIGNAL SIGQUIT

CMD ["supervisor"]

USER rootless
