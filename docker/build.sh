#!/usr/bin/env bash
docstring=`cat<<EOF
POLL_SCRIPT=trang-echoNow.sh  ./docker/build.sh

--build-arg ref. https://vsupalov.com/docker-env-vars/#docker-image-build-time-variables
EOF`

SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

if [[ -z POLL_SCRIPT ]]; then echo "Param :POLL_SCRIPT is required as \$1 - please pick one file in $AH/poll_vault/"; exit 1; fi

IMAGE_TAG=${IMAGE_TAG:-'nn/cronjob-ubuntu-start:200424'}

docker image rm $IMAGE_TAG || true

docker build \
             --build-arg POLL_SCRIPT=$POLL_SCRIPT \
             --file "$SH/Dockerfile"             -t $IMAGE_TAG             $AH
#            #build image from this Dockerfile   #t aka tag of the image   #set :pwd folder for Dockerfile
