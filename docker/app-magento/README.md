# App Magento

@todo description

---

### Install

Bind domains on your /etc/hosts

```shell
sudo nano /etc/hosts
```

```text
127.0.0.1       traefik.local
127.0.0.1       mailhog.local
127.0.0.1       phpmyadmin.local
127.0.0.1       rabbitmq.local
127.0.0.1       magento.local
```

Build your local docker image

```shell
docker build . -t aartintelligent/app-magento:2.4 \
--build-arg "UID=$(id -u)" \
--build-arg "GID=$(id -g)"
```

Install dependencies composer

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
aartintelligent/ops-composer:8.2 \
install
```

Start docker compose

```shell
docker compose up
```

Install magento project

```shell
docker compose exec magento \
bin/magento setup:install \
--base-url=https://magento.local \
--db-host=mysql \
--db-name=magento \
--db-user=root \
--db-password=nopassword \
--admin-firstname=$(whoami) \
--admin-lastname=$(whoami) \
--admin-email=$(whoami)@mail.local \
--admin-user=$(whoami) \
--admin-password=$(whoami)123 \
--language=fr_FR \
--currency=EUR \
--timezone=Europe/Paris \
--use-rewrites=1 \
--search-engine=elasticsearch7 \
--elasticsearch-host=elasticsearch \
--elasticsearch-port=9200 \
--elasticsearch-index-prefix=magento2 \
--elasticsearch-timeout=15
```

Apply custom env.php

```shell
cp \
src/app/etc/env.template.php \
src/app/etc/env.php 
```

Cleanup

```shell
docker compose exec magento \
bin/magento cache:clean
```

Ready to go

---

### Registry Usage

```shell
docker build . -t aartintelligent/app-magento:latest
```

```shell
docker build . -t aartintelligent/app-magento:2.4
```

```shell
docker login
```

```shell
docker push aartintelligent/app-magento:2.4
```

```shell
docker push aartintelligent/app-magento:latest
```

---

### Docker Usage

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
docker exec -it app-magento bash
```

```shell
docker stop app-magento
```

```shell
docker rm app-magento
```

---

### Logs Usage

```shell
docker run -d \
--net host \
--name app-magento \
aartintelligent/app-magento:latest
```

```shell
docker container logs app-magento
```

```shell
docker exec -it app-magento supervisorctl status
```

---

### Health Usage

```shell
docker run -d \
--net host \
--name app-magento \
aartintelligent/app-magento:latest
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
