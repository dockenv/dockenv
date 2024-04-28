#!/usr/bin/env bash

ROOT_PWD=$(dirname $(dirname $(readlink -f $0)))

docker-compose --file ${ROOT_PWD}/compose/lnmp.compose.yml \
    --project-name lnmp \
    --verbose \
    --log-level DEBUG \
    --env-file ${ROOT_PWD}/.env
