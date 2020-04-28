#!/usr/bin/env bash
docstring=`cat<<EOF
POLL_SCRIPT=trang-echoNow.sh  ./docker/build-run.sh

--build-arg ref. https://vsupalov.com/docker-env-vars/#docker-image-build-time-variables
EOF`

SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

if [[ -z $POLL_SCRIPT ]]; then                         echo "Param :POLL_SCRIPT is required as \$1 - please pick one file in $AH/bin/poll_vault/"; exit 1; fi
if [[ ! -f "$AH/bin/poll_vault/$POLL_SCRIPT" ]]; then  echo "Script $POLL_SCRIPT not found at $AH/bin/poll_vault/$POLL_SCRIPT"; exit 1; fi

IMAGE_TAG=${IMAGE_TAG:-'nn/cronjob-ubuntu-start:200424'}
IMAGE_TAG="$POLL_SCRIPT-$IMAGE_TAG"  # put in POLL_SCRIPT in image tag


# BUILD
docker image rm $IMAGE_TAG || true
    docker build \
                 --build-arg POLL_SCRIPT=$POLL_SCRIPT \
                 --file "$SH/Dockerfile"             -t $IMAGE_TAG             $AH
    #            #build image from this Dockerfile   #t aka tag of the image   #set :pwd folder for Dockerfile


# RUN
CONTAINER_NAME=${CONTAINER_NAME:-'nn-cronjob-ubuntu-start'}      ; CONTAINER_NAME="$POLL_SCRIPT-${CONTAINER_NAME}"
  NETWORK_NAME=${NETWORK_NAME:-'nn-cronjob-ubuntu-start-network'} ;   NETWORK_NAME="$POLL_SCRIPT-${NETWORK_NAME}"
    docker network rm  $NETWORK_NAME || true
    docker network create  --driver bridge  $NETWORK_NAME || true  # create network if not exists ref. https://stackoverflow.com/a/48643576/248616

        docker run --name $CONTAINER_NAME  --net $NETWORK_NAME  -d                      --restart unless-stopped    $IMAGE_TAG
        #          #container name         #docker network      #daemon aka background  #auto-restart ref. http://bit.ly/2sDBc9k unless-stopped
        #                                                                               #the container sometimes crashes --> this help auto-restart it


# aftermath
docker ps | grep -E "IMAGE|$IMAGE_TAG|NAME|$CONTAINER_NAME" --color=always
