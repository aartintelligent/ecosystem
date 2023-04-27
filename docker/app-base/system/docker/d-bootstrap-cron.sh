#!/bin/bash
set -e

cron > /dev/null 2>&1 || true

(>&2 echo "[*] Bootstrap CRON")
