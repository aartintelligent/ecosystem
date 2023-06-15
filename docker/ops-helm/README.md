# Ops Helm

@todo description

---

### Usage

```shell
docker build . \
--tag aartintelligent/ops-helm:latest
```

```shell
docker run -it --rm \
-v $(pwd):/src aartintelligent/ops-helm:latest \
version
```

```shell
docker push aartintelligent/ops-helm:latest
```
