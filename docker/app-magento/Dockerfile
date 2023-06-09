ARG PHP_VERSION='8.2'

FROM aartintelligent/ops-composer:${PHP_VERSION} AS magento-ops-composer

ARG COMPOSER_AUTH=""

ENV \
COMPOSER_ALLOW_SUPERUSER="0" \
COMPOSER_ALLOW_XDEBUG="0" \
COMPOSER_CACHE_DIR="/var/cache/composer" \
COMPOSER_AUTH="${COMPOSER_AUTH}"

VOLUME ["/var/cache/composer"]

COPY src /src

RUN set -eux; \
composer install \
--prefer-dist \
--no-autoloader \
--no-interaction \
--no-scripts \
--no-progress \
--no-dev; \
composer dump-autoload \
--optimize

FROM aartintelligent/ops-php:${PHP_VERSION} AS magento-ops-di-compile

COPY src /src

COPY --from=magento-ops-composer /src/vendor /src/vendor

RUN set -eux; \
bin/magento setup:di:compile

FROM aartintelligent/ops-php:${PHP_VERSION} AS magento-ops-static-deploy

ARG STATIC_JOBS="3"
ARG STATIC_LANGUAGES=""

COPY src /src

COPY --from=magento-ops-composer /src/vendor /src/vendor

RUN set -eux; \
bin/magento setup:static-content:deploy \
--force \
--no-interaction \
--jobs=${STATIC_JOBS} \
${STATIC_LANGUAGES}

FROM aartintelligent/app-php:${PHP_VERSION}

USER root

ENV \
MAGE_MODE="production" \
MAGE_RUN_TYPE="website" \
MAGE_RUN_CODE="base" \
CRYPT_KEY="030bf837c0fd8baa0b1d20d7ea96f1a9" \
PHP_MEMORY_LIMIT="4096M" \
PHP_OPCACHE__ENABLE="1" \
PHP_OPCACHE__ENABLE_CLI="1" \
PHP_OPCACHE__PRELOAD="/var/www/app/preload.php" \
PHP_OPCACHE__JIT="function"

COPY --chown=rootless:rootless src /var/www

COPY --chown=rootless:rootless --from=magento-ops-composer /src/vendor /var/www/vendor

COPY --chown=rootless:rootless --from=magento-ops-di-compile /src/generated /var/www/generated

COPY --chown=rootless:rootless --from=magento-ops-static-deploy /src/pub/static /var/www/pub/static

COPY --chown=rootless:rootless system /

RUN set -eux; \
echo "/docker/d-bootstrap-magento.sh" >> /docker/d-bootstrap.list; \
chmod +x /docker/d-bootstrap-magento.sh

USER rootless
