#!/usr/bin/env bash
docstring='
SCRIPT=backup_vol_postgres.sh ./build.sh

--build-arg ref. https://vsupalov.com/docker-env-vars/#docker-image-build-time-variables
'

SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

[ -z $SCRIPT   ] && ( echo "$SCRIPT is required"; kill $$ )

IMAGE_TAG="$SCRIPT-cronjob"  # put in SCRIPT in image tag

# BUILD
docker image rm $IMAGE_TAG || true
    docker build \
                --build-arg SCRIPT=$SCRIPT \
                --file "$SH/Dockerfile"  -t $IMAGE_TAG   $AH
