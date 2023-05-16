# Ops Helm

@todo description

---

### Usage

```shell
docker build . -t aartintelligent/ops-helm:latest
```

```shell
docker run -it --rm \
-u $(id -u):$(id -g) \
-v $(pwd):/src aartintelligent/ops-helm:latest \
version
```

```shell
docker push aartintelligent/ops-helm:latest
```
