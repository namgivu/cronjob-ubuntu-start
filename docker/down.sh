#!/usr/bin/env bash
if [[ -z $CONTAINER ]]; then echo "Param :CONTAINER is required as \$1"; exit 1; fi

docker stop    $CONTAINER || true
docker rm   -f $CONTAINER || true
