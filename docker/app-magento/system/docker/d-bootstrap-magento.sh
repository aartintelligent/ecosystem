#!/bin/bash
set -e

(>&2 echo "[*] Bootstrap MAGENTO")

if [ -f "/var/www/app/etc/env.php" ]; then

  if [ "$(bin/magento setup:db:status)" == '1' ]; then

    bin/magento setup:upgrade --keep-generated

  fi

  until bin/magento setup:db:status >/dev/null 2>&1; do

    (echo >&2 "[!] Waiting for upgrade to be ready...")

    sleep 2

  done

fi

(>&2 echo "[*] Bootstrap UPGRADE")
