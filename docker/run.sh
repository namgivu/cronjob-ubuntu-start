#!/usr/bin/env bash
CONTAINER_NAME=${CONTAINER_NAME:-'nn-cronjob-ubuntu-start'}
  NETWORK_NAME=${NETWORK_NAME:-'nn-cronjob-ubuntu-start-network'}
     IMAGE_TAG=${IMAGE_TAG:-'nn/cronjob-ubuntu-start:200424'}  #NOTE: must be same with ./docker/build.sh

docker network create  --driver bridge  $NETWORK_NAME || true  # create network if not exists ref. https://stackoverflow.com/a/48643576/248616

docker run --name $CONTAINER_NAME  --net $NETWORK_NAME  -d                      --restart unless-stopped    $IMAGE_TAG
#          #container name         #docker network      #daemon aka background  #auto-restart ref. http://bit.ly/2sDBc9k unless-stopped
#                                                                               #the container sometimes crashes --> this help auto-restart it
