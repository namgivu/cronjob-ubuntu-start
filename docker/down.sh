#!/usr/bin/env bash
CONTAINER_NAME=${CONTAINER_NAME:-'nn-cronjob-ubuntu-start'}

docker stop    $CONTAINER_NAME || true
docker rm   -f $CONTAINER_NAME || true
