# Ops Phing

@todo description

---

### Usage

```shell
docker build . -t aartintelligent/ops-phing:latest
```

```shell
docker run -it --rm -v $(pwd):/src aartintelligent/ops-phing:latest -v
```

```shell
docker run -it --rm \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
-v $(pwd):/src \
aartintelligent/ops-phing:latest phing
```

```shell
docker push aartintelligent/ops-phing:latest
```
