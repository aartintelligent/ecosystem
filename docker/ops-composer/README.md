# Ops Composer

@todo description

---

### Usage

```shell
docker build . \
--tag aartintelligent/ops-composer:latest
```

```shell
docker build . \
--tag aartintelligent/ops-composer:8.2 \
--build-arg 'PHP_VERSION=8.2'
```

```shell
docker build . \
--tag aartintelligent/ops-composer:8.1 \
--build-arg 'PHP_VERSION=8.1'
```

```shell
docker run -it --rm \
-v $(pwd):/src \
aartintelligent/ops-composer:latest \
-v
```

```shell
docker run -it --rm \
-v $(pwd):/src \
aartintelligent/ops-composer:8.2 \
-v
```

```shell
docker run -it --rm \
-v $(pwd):/src \
aartintelligent/ops-composer:8.1 \
-v
```

```shell
docker push aartintelligent/ops-composer:8.1
```

```shell
docker push aartintelligent/ops-composer:8.2
```

```shell
docker push aartintelligent/ops-composer:latest
```
