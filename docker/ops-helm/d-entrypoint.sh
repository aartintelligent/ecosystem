#!/bin/sh
isCommand() {
  if [ "$1" = "sh" ]; then
    return 1
  fi
  helm --help "$1" >/dev/null 2>&1
}
if [ "${1#-}" != "$1" ]; then
  set -- tini -- helm "$@"
elif [ "$1" = 'helm' ]; then
  set -- tini -- "$@"
elif isCommand "$1"; then
  set -- tini -- helm "$@"
fi
exec "$@"
