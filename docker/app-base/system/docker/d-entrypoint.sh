#!/bin/bash
set -e

if [ "$1" = 'supervisor' ] || [ "$1" = 'cron' ]; then

  (>&2 echo "Run docker entrypoint")

  while IFS= read -r script; do

    if [ -f "$script" ]; then

      bash "$script" "$@"

    fi

  done < <(grep -v '^ *#' < '/docker/d-entrypoint.list')

  if [ "$1" = 'supervisor' ]; then

    (>&2 echo "[*] Run supervisor")

    echo "/docker/d-health-supervisor.sh" >> /docker/d-health.list

    exec supervisord

  fi

  if [ "$1" = 'cron' ]; then

    (>&2 echo "[*] Run cron")

    echo "/docker/d-health-cron.sh" >> /docker/d-health.list

    cron > /dev/null 2>&1 || true

  fi

  bash /docker/d-start.sh "$@"

  exec tail -f /dev/null

else

  exec "$@"

fi
