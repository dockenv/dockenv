#!/usr/bin/env bash
###
# @Author: Cloudflying
# @Date: 2025-04-26 21:26:34
# @LastEditTime: 2025-12-23 16:12:03
# @LastEditors: Cloudflying
# @Description: Dockenv is a tool to manage docker environment variables.
###
START_TIME=$(date +%s)

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

ROOT_PATH=$(dirname $(dirname $(readlink -f "${BASH_SOURCE[0]}")))

cd $ROOT_PATH

DOCKER_IMAGES_PATH="images"

if [[ -n "$(command -v docker)" ]]; then
  DOCKCLI='docker'
elif [[ -n "$(command -v podman)" ]]; then
  DOCKCLI='podman'
elif [[ -n "$(command -v nerdctl)" ]]; then
  DOCKCLI='nerdctl'
else
  echo "No docker or podman found."
  exit 1
fi

if [[ ! -f ".env" ]] && [[ -f ".example.env" ]]; then
  cp -fr ".example.env" ".env"
fi

if [ -f ".env" ]; then
  . ".env"
elif [ -f "$HOME/.env" ]; then
  . "$HOME/.env"
else
  echo "No .env file found."
  exit 1
fi

if [ -z "$DOCKER_REGISTRY" ]; then
  echo "DOCKER_REGISTRY is not set."
  exit 1
fi

_compose_bin()
{
  if [[ -n "$(command -v docker-compose)" ]]; then
    docker-compose "${@}"
  elif [[ -n "$(docker compose)" ]]; then
    docker compose "${@}"
  else
    echo "No docker-compose or docker compose found."
    exit 1
  fi
}

_red()
{
  printf '\033[1;31;31m%b\033[0m' "$1"
}

_green()
{
  printf '\033[1;31;32m%b\033[0m' "$1"
}

_yellow()
{
  printf '\033[1;31;33m%b\033[0m' "$1"
}

_info()
{
  _green "[Info] "
  printf -- "%s" "$1"
  printf "\n"
}

_warn()
{
  _yellow "[Warning] "
  printf -- "%s" "$1"
  printf "\n"
}

_error()
{
  _red "[Error] "
  printf -- "%s" "$1"
  printf "\n"
  exit 1
}

_compose()
{

  if [[ -f "${ROOT_PATH}/.dev/compose/${1}.compose.yml" ]]; then
    DOCKER_COMPOSE_FILE="${ROOT_PATH}/.dev/compose/${1}.compose.yml"
  else
    echo "${1} docker compose file found."
  fi

  _compose_bin --env-file .env --progress=tty --project-name=${1} -f ${DOCKER_COMPOSE_FILE} "${@:2}"
}

_build()
{
  IMAGE_NAME="${1}"
  IMAGE_TAG="${2:-latest}"

  cd ../dockenv-images || exit 1

  if [[ -f "${DOCKER_IMAGES_PATH}/${IMAGE_NAME}/${IMAGE_TAG}/Dockerfile" ]]; then
    cd ${DOCKER_IMAGES_PATH}/${IMAGE_NAME}/${IMAGE_TAG} || exit 1
    docker build \
      --build-arg http_proxy="${http_proxy}" \
      --build-arg https_proxy="${http_proxy}" \
      --build-arg NO_PROXY="${no_proxy}" \
      --progress tty \
      --no-cache \
      -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}" \
      .
    cd - || exit 1
  fi
}

# 批量构建
_builds()
{
  NAME=$1
  [ -d "${DOCKER_IMAGES_PATH}/${NAME}" ] && cd "${DOCKER_IMAGES_PATH}/${NAME}" || echo "${NAME} Not Exist" && exit 1
  # shellcheck disable=SC2066
  for VERSION in "$(ls)"; do
    _build "${NAME}" "${VERSION}"
  done
}

_init_network()
{
  docker network create \
    --driver=bridge \
    --subnet="172.172.0.0/16" \
    --gateway="172.172.0.1" \
    --ip-range="172.172.0.0/16" \
    --ipv4 \
    --ipv6 \
    --opt com.docker.network.bridge.enable_icc=true \
    --opt com.docker.network.bridge.enable_ip_masquerade=true \
    --opt com.docker.network.bridge.host_binding_ipv4=0.0.0.0 \
    --opt com.docker.network.driver.mtu=1450 \
    dockenv
}

_usage()
{
  echo "	Docker Env Build Tool"
  echo '/--------------------------------------------------------\'
  echo "| Usage: dockenv [dev|build|pull|run|stop|rm|exec|logs]"
  echo "|  dev:   Run the docker container in development mode."
  echo "|  build: Build the docker image."
  echo "|  push: Push the docker image to registry(Offcial|Github|Aliyun|Tencent|HuaweiCloud|Baidu)."
  echo "|  pull:  Pull the docker image."
  echo "|  run:   Run the docker container."
  echo "|  stop:  Stop the docker container."
  echo "|  rm:    Remove the docker container."
  echo "|  exec:  Execute a command in the running container."
  echo "|  logs:  View the logs of the running container."
  echo '\--------------------------------------------------------/'
}

# echo $DOCKER_REGISTRY

case "$1" in
  dev)
    _compose "${@:2}"
    ;;
  build)
    _build "${@:2}"
    ;;
  --build-all | -ba)
    _builds "${@:2}"
    ;;
  push)
    # shellcheck disable=SC2145
    ${DOCKCLI} push "${DOCKER_REGISTRY}/${@:2}"
    ;;
  pull)
    # shellcheck disable=SC2145
    ${DOCKCLI} pull "${DOCKER_REGISTRY}/${@:2}"
    ;;
  init-network | -in)
    _init_network
    ;;
  *)
    _usage
    ;;
esac

END_TIME=$(date +%s)
FULL_EXEC_TIME=$(expr ${END_TIME} - ${START_TIME})
_info "==> Total Time: ${FULL_EXEC_TIME} Second "
