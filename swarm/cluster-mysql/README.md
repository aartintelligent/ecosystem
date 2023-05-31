# Cluster Mysql

```shell
echo $(openssl rand -base64 32) > data/mysql_root_password
```

```shell
docker secret create mysql_root_password data/mysql_root_password
```

```shell
docker secret create mysql_router data/mysql_router
```
