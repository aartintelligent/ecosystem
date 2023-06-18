#!/bin/bash
set -e

counter=1

while [ $counter -le 3 ]; do

  exit=0

  while IFS= read -r script; do

    if [ -f "$script" ]; then

      echo "$script"

      exit=$(bash "$script")

      if [ "$exit" != "0" ]; then

        break

      fi

    fi

  done < <(grep -v '^ *#' < '/docker/d-health.list')

  counter=$((counter+1))

  if [ "$exit" == "0" ]; then

    break

  fi

  sleep 0.2

done

exit "$exit"
