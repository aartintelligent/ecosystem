# App Symfony

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
aartintelligent/ops-composer:8.2 \
install
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
-v $(pwd)/.composer:/var/cache/composer \
aartintelligent/ops-composer:8.2 \
update
```

---

### Yarn Usage

```shell
mkdir -p $(pwd)/.yarn
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
-v $(pwd)/.yarn:/var/cache/yarn \
aartintelligent/ops-yarn:latest \
install
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
-v $(pwd)/.yarn:/var/cache/yarn \
aartintelligent/ops-yarn:latest \
build
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
-v $(pwd)/.yarn:/var/cache/yarn \
aartintelligent/ops-yarn:latest \
watch
```

---

### Docker Usage

```shell
docker build . \
--tag aartintelligent/app-symfony:latest \
--build-arg "UID=$(id -u)" \
--build-arg "GID=$(id -g)" \
--build-arg "GIT_COMMIT=$(git rev-parse HEAD)"
```

```shell
docker build . \
--tag aartintelligent/app-symfony:6.2 \
--build-arg "UID=$(id -u)" \
--build-arg "GID=$(id -g)" \
--build-arg "GIT_COMMIT=$(git rev-parse HEAD)"
```

```shell
docker run -d \
--net host \
--name app-symfony \
aartintelligent/app-symfony:latest
```

```shell
docker run -d \
--net host \
--name app-symfony \
aartintelligent/app-symfony:6.2
```

```shell
docker container logs app-symfony
```

```shell
docker exec -it app-symfony supervisorctl status
```

```shell
docker exec -it app-symfony supervisorctl stop server:server-fpm
```

```shell
until docker exec -it app-symfony /docker/d-health.sh >/dev/null 2>&1; do \
  (echo >&2 "Waiting..."); \
  sleep 2; \
done
```

```shell
docker exec -it app-symfony supervisorctl start server:server-fpm
```

```shell
docker exec -it app-symfony bash
```

```shell
docker stop app-symfony
```

```shell
docker rm app-symfony
```

```shell
docker push aartintelligent/app-symfony:6.2
```

```shell
docker push aartintelligent/app-symfony:latest
```
