#!/bin/bash
set -e

(>&2 echo "[*] Cleanup")

while IFS= read -r file; do

  if [ -f "$file" ]; then

    rm -rf "$file"

  fi

done < <(grep -v '^ *#' < '/docker/d-cleanup.list')
