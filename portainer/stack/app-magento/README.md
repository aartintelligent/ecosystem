# Portainer App Magento

### Install

```shell
bin/magento setup:install \
--base-url=https://magento.local \
--db-host=mysql \
--db-name=magento \
--db-user=root \
--db-password=nopassword \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123 \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--search-engine=opensearch \
--opensearch-host=https://opensearch \
--opensearch-port=9300 \
--opensearch-index-prefix=magento2 \
--opensearch-timeout=15
```
