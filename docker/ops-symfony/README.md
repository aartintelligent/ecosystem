# Ops Symfony

@todo description

---

### Usage

```shell
docker build . \
--tag aartintelligent/ops-symfony:latest
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd):/src \
aartintelligent/ops-symfony:latest \
-v
```

```shell
docker push aartintelligent/ops-symfony:latest
```
