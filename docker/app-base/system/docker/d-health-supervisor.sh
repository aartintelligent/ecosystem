#!/bin/bash
set -e

exit=0

file='/var/pid/supervisord.pid'

if [ ! -f "$file" ]; then

  exit=1

else

  programs=$(supervisorctl pid all)

  for pid in $programs; do

    if [ "$pid" = "0" ]; then

      exit=1

      break

    fi

  done

fi

echo "$exit"
