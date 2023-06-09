#!/bin/bash
set -e

if [ "$1" = 'supervisor' ] || [ "$1" = 'cron' ]; then

  (>&2 echo "Run docker entrypoint")

  while IFS= read -r script; do

    if [ -f "$script" ]; then

      bash "$script" "$@"

    fi

  done < <(grep -v '^ *#' < '/docker/d-entrypoint.list')

  (>&2 echo "[*] Start")

  if [ "$1" = 'supervisor' ]; then

    echo "/docker/d-health-supervisor.sh" >> /docker/d-health.list

    supervisord > /dev/null 2>&1 || true

    (>&2 echo "[*] Start SUPERVISOR")

  fi

  if [ "$1" = 'cron' ]; then

    echo "/docker/d-health-cron.sh" >> /docker/d-health.list

    cron > /dev/null 2>&1 || true

    (>&2 echo "[*] Start CRON")

  fi

  bash /docker/d-start.sh "$@"

  until bash /docker/d-health.sh >/dev/null 2>&1; do

    (echo >&2 "[!] Waiting $1 to be started...")

    sleep 2

  done

  exec tail -f /dev/stdout

else

  exec "$@"

fi
