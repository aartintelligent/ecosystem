#!/bin/bash
set -e

(>&2 echo "[*] Bootstrap SYLIUS")

if [ -n "$(ls -A /var/www/src/Migrations/*.php 2>/dev/null)" ]; then

  until bin/console doctrine:query:sql "select 1" >/dev/null 2>&1; do

    (echo >&2 "[!] Waiting for MySQL to be ready...")

    sleep 2

  done

  bin/console doctrine:migrations:migrate --no-interaction

fi

(>&2 echo "[*] Bootstrap MIGRATION")
