#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2024-04-30 18:51:36
# @LastEditTime: 2024-07-22 11:42:01
# @LastEditors: Cloudflying
# @Description: Dockenv Compose Manager
###
# Docker Compose Manager

ROOT_PATH=$(dirname "$(realpath "$0")")

if [[ ! -f "${ROOT_PATH}/.env" ]]; then
  cp -fr "${ROOT_PATH}/.env-example" "${ROOT_PATH}/.env"
fi

_start() {
  "$@" up -d
}

_stop() {
  "$@" stop
}

_restart() {
  "$@" restart
}

_remove() {
  "$@" down
}

_recreate() {
  "$@" up --force-recreate -d
}

_ps() {
  "$@" ps
}

_pull() {
  "$@" pull
}

_service() {
  COMPOSE_FILE="${ROOT_PATH}/.dev/compose/${2}.compose.yml"
  [ -z "${2}" ] && echo "error: Service is empty" && exit 1

  if [[ -f "${COMPOSE_FILE}" ]]; then
    "_${1}" docker-compose -f "${COMPOSE_FILE}" --env-file "${ROOT_PATH}/.env" --project-name "${2}"
  else
    echo "error: Service $2 Not Found, See ./dockenv.sh -h"
  fi
}

_usage() {
  echo "Usage: bash $0 [start|stop|restart|recreate|remove] [anmp|elk|services|gitea|downloader|mariadb]"
}

case "$1" in
start)
  _service "$@"
  ;;
stop)
  _service "$@"
  ;;
restart)
  _service "$@"
  ;;
recreate)
  _service "$@"
  ;;
remove)
  _service "$@"
  ;;
ps)
  _service "$@"
  ;;
pull)
  _service "$@"
  ;;
"-h|--help|usage|--usage")
  _usage
  ;;
*)
  _usage
  ;;
esac
