# Ops Yarn

@todo description

---

### Usage

```shell
docker build . \
--tag aartintelligent/ops-yarn:latest
```

```shell
docker build . \
--tag aartintelligent/ops-yarn:18 \
--build-arg NODE_VERSION=18
```

```shell
docker build . \
--tag aartintelligent/ops-yarn:16 \
--build-arg NODE_VERSION=16
```

```shell
docker run -it --rm \
-v $(pwd):/src \
aartintelligent/ops-yarn:latest \
-v
```

```shell
docker push aartintelligent/ops-yarn:16
```

```shell
docker push aartintelligent/ops-yarn:18
```

```shell
docker push aartintelligent/ops-yarn:latest
```
