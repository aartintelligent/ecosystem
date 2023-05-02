# AArtIntelligent : App Sylius

@todo description

---

### Docker Usage

```shell
docker build . -t aartintelligent/app-sylius:latest
```

```shell
docker build . -t aartintelligent/app-sylius:1.12
```

```shell
docker run -d --net host --name app-sylius aartintelligent/app-sylius:latest
```

```shell
docker run -d --net host --name app-sylius aartintelligent/app-sylius:1.12
```

```shell
docker container logs app-sylius
```

```shell
docker exec -it app-sylius supervisorctl status
```

```shell
docker exec -it app-sylius supervisorctl stop server:server-fpm
```

```shell
until docker exec -it app-php /docker/d-health.sh >/dev/null 2>&1; do \
  (echo >&2 "Waiting..."); \
  sleep 2; \
done
```

```shell
docker exec -it app-sylius supervisorctl start server:server-fpm
```

```shell
docker exec -it app-sylius bash
```

```shell
docker stop app-sylius
```

```shell
docker rm app-sylius
```

```shell
docker push aartintelligent/app-sylius:1.12
```

```shell
docker push aartintelligent/app-sylius:latest
```