#!/bin/sh
isCommand() {
  if [ "$1" = "sh" ]; then
    return 1
  fi
  docker --help "$1" >/dev/null 2>&1
}
if [ "${1#-}" != "$1" ]; then
  set -- tini -- docker "$@"
elif [ "$1" = 'docker' ]; then
  set -- tini -- "$@"
elif isCommand "$1"; then
  set -- tini -- docker "$@"
fi
exec "$@"
