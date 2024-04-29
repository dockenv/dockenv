#!/usr/bin/env bash

ROOT_PWD=$(dirname $(readlink -f $0))

docker-compose --file ${ROOT_PWD}/docker-compose.yml \
    --project-name dockenv \
    --env-file ${ROOT_PWD}/.env $@
