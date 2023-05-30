# App Magento

@todo description

---

### Composer Usage

```shell
mkdir -p $(pwd)/.composer
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
-v $(pwd)/.composer:/var/cache/composer \
-e COMPOSER_AUTH="$(cat auth.json)" \
aartintelligent/ops-composer:8.2 \
install
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
-v $(pwd)/.composer:/var/cache/composer \
-e COMPOSER_AUTH="$(cat auth.json)" \
aartintelligent/ops-composer:8.2 \
update
```

---

### Docker Usage

```shell
docker build . \
--tag aartintelligent/app-magento:latest \
--build-arg "UID=$(id -u)" \
--build-arg "GID=$(id -g)" \
--build-arg "GIT_COMMIT=$(git rev-parse HEAD)" \
--build-arg "COMPOSER_AUTH=$(cat auth.json)" \
--build-arg "STATIC_LANGUAGES=en_US fr_FR" \
--build-arg "STATIC_JOBS=6"
```

```shell
docker build . \
--tag aartintelligent/app-magento:2.4 \
--build-arg "UID=$(id -u)" \
--build-arg "GID=$(id -g)" \
--build-arg "GIT_COMMIT=$(git rev-parse HEAD)" \
--build-arg "COMPOSER_AUTH=$(cat auth.json)" \
--build-arg "STATIC_LANGUAGES=en_US fr_FR" \
--build-arg "STATIC_JOBS=6"
```

```shell
docker run -d \
--net host \
--name app-magento \
aartintelligent/app-magento:latest
```

```shell
docker run -d \
--net host \
--name app-magento \
aartintelligent/app-magento:2.4
```

```shell
docker container logs app-magento
```

```shell
docker exec -it app-magento supervisorctl status
```

```shell
docker exec -it app-magento supervisorctl stop server:server-fpm
```

```shell
until docker exec -it app-php /docker/d-health.sh >/dev/null 2>&1; do \
  (echo >&2 "Waiting..."); \
  sleep 2; \
done
```

```shell
docker exec -it app-magento supervisorctl start server:server-fpm
```

```shell
docker exec -it app-magento bash
```

```shell
docker stop app-magento
```

```shell
docker rm app-magento
```

```shell
docker push aartintelligent/app-magento:2.4
```

```shell
docker push aartintelligent/app-magento:latest
```
