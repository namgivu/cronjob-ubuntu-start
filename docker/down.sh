#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

if [[ -z $POLL_SCRIPT ]]; then                         echo "Param :POLL_SCRIPT is required as \$1 - please pick one file in $AH/poll_vault/"; exit 1; fi
if [[ ! -f "$AH/bin/poll_vault/$POLL_SCRIPT" ]]; then  echo "Script $POLL_SCRIPT not found at $AH/bin/poll_vault/$POLL_SCRIPT"; exit 1; fi

CONTAINER_NAME=${CONTAINER_NAME:-'nn-cronjob-ubuntu-start'} ; CONTAINER_NAME="${CONTAINER_NAME}__$POLL_SCRIPT"

docker stop    $CONTAINER_NAME || true
docker rm   -f $CONTAINER_NAME || true
