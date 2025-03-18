#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2024-04-30 18:51:36
# @LastEditTime: 2025-03-18 16:53:34
# @LastEditors: Cloudflying
# @Description: Dockenv Manager
###

ROOT_PATH=$(dirname "$(realpath "$0")")

if [[ ! -f "${ROOT_PATH}/.env" ]]; then
  cp -fr "${ROOT_PATH}/.example.env" "${ROOT_PATH}/.env"
fi

DOCKENV_NAME=$1

if [[ -z ${DOCKENV_NAME} ]]; then
  echo "Error: No dockenv specified."
  exit 1
fi

COMPOSE_FILE="${ROOT_PATH}/.dev/compose/${DOCKENV_NAME}.compose.yml"
COMPOSE_OPTS="--env-file ${ROOT_PATH}/.env --progress=tty --project-name=${DOCKENV_NAME} -f ${COMPOSE_FILE}"

if [[ ! -f ${COMPOSE_FILE} ]]; then
  echo "error: Service $2 Not Found, See ./dockenv.sh -h"
  exit 1
fi

# Remove first Command Line Options
shift

docker-compose ${COMPOSE_OPTS} "$@"
