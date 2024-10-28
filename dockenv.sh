#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2024-04-30 18:51:36
 # @LastEditTime: 2024-10-28 10:23:26
 # @LastEditors: Cloudflying
# @Description: Dockenv Manager
###

ROOT_PATH=$(dirname "$(realpath "$0")")

if [[ ! -f "${ROOT_PATH}/.env" ]]; then
  cp -fr "${ROOT_PATH}/.env-example" "${ROOT_PATH}/.env"
fi

DOCKENV_NAME=$1

if [[ -z ${DOCKENV_NAME} ]]; then
  echo "Error: No dockenv specified."
  exit 1
fi

COMPOSE_CMD=$2

if [[ -z "${COMPOSE_CMD}" ]]; then
  COMPOSE_CMD="--help"
fi

COMPOSE_FILE="${ROOT_PATH}/.dev/compose/${DOCKENV_NAME}.compose.yml"
COMPOSE_OPTS="--env-file ${ROOT_PATH}/.env --progress=tty --project-name=${DOCKENV_NAME} -f ${COMPOSE_FILE}"

if [[ ! -f "${COMPOSE_FILE}" ]]; then
  echo "error: Service $2 Not Found, See ./dockenv.sh -h"
  exit 1
fi

__exec()
{
  docker-compose ${COMPOSE_OPTS} ${COMPOSE_CMD}
}

__exec
