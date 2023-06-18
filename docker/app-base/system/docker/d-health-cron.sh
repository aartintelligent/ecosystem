#!/bin/bash
set -e

exit=0

file='/var/run/crond.pid'

if [ ! -f "$file" ]; then

  exit=1

fi

echo "$exit"
