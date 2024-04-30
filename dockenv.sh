#!/usr/bin/env bash
# Docker Compose Manager

ROOT_PATH=$(dirname "$(realpath "$0")")

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

_service()
{
    COMPOSE_FILE="${ROOT_PATH}/compose/${2}.compose.yml"
    [ -z "${2}" ] && echo "error: Service is empty" && exit 1

    if [[ -f "${COMPOSE_FILE}" ]]; then
        # echo "==> $1 $2"
        "_${1}" docker-compose -f "${COMPOSE_FILE}" --env-file "${ROOT_PATH}/.env" --project-name "${2}"
    else
        echo "error: Service $2 Not Found, See ./dockenv.sh -h"
    fi
}

_usage()
{
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
    "-h|--help|usage|--usage")
        _usage
        ;;
    *)
        _usage
        ;;
esac
