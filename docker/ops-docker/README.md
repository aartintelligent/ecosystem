# AArtIntelligent : Ops Docker

@todo description

---

### Usage

```shell
docker build . -t aartintelligent/ops-docker:latest
```

```shell
docker run -it --rm aartintelligent/ops-docker:latest -v
```

```shell
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock:ro aartintelligent/ops-docker:latest ps -a
```

```shell
docker push aartintelligent/ops-docker:latest
```