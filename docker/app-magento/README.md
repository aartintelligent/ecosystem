# App Magento

@todo description

---

### Composer usage

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
aartintelligent/ops-composer:8.2 \
install
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd)/src:/src \
aartintelligent/ops-composer:8.2 \
update
```

---

### Registry Usage

```shell
docker build . -t aartintelligent/app-magento:latest
```

```shell
docker build . -t aartintelligent/app-magento:2.4
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
