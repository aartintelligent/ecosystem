# Ops Grunt

@todo description

---

### Usage

```shell
docker build . \
--tag aartintelligent/ops-grunt:latest
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd):/src \
aartintelligent/ops-grunt:latest \
-v
```

```shell
docker push aartintelligent/ops-grunt:latest
```
