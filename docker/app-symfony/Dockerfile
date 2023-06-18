ARG PHP_VERSION='8.2'

FROM aartintelligent/ops-composer:${PHP_VERSION} AS symfony-ops-composer

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

FROM aartintelligent/ops-yarn:latest AS symfony-ops-yarn

COPY src /src

RUN set -eux; \
yarn install; \
yarn run encore production

FROM aartintelligent/app-php:${PHP_VERSION}

USER root

ENV \
APP_ENV="prod" \
APP_DEBUG="1" \
APP_SECRET="8a173d6f3c8bc1a030c4ff378866f834" \
DATABASE_URL="mysql://rootless:nopassword@mysql:3306/symfony?serverVersion=8&charset=utf8mb4" \
MESSENGER_TRANSPORT_DSN="amqp://rootless:nopassword@rabbitmq:5672/%2f/messages" \
PHP_MEMORY_LIMIT="2048M" \
PHP_OPCACHE__ENABLE="1" \
PHP_OPCACHE__ENABLE_CLI="1" \
PHP_OPCACHE__PRELOAD="/var/www/config/preload.php" \
PHP_OPCACHE__JIT="function"

COPY --chown=rootless:rootless src /var/www

COPY --chown=rootless:rootless --from=symfony-ops-composer /src/vendor /var/www/vendor

COPY --chown=rootless:rootless --from=symfony-ops-yarn /src/public/build /var/www/public/build

COPY --chown=rootless:rootless system /

RUN set -eux; \
echo "/docker/d-bootstrap-symfony.sh" >> /docker/d-bootstrap.list; \
chmod +x /docker/d-bootstrap-symfony.sh

USER rootless
