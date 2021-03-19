#!/usr/bin/env bash
docstring='
CONTAINER_NAME=test-qq   ./stoprm.sh
'
[ -z $CONTAINER_NAME ] && ( echo "Param :CONTAINER_NAME is required"; kill $$ )

docker rm   -f scheduling-$CONTAINER_NAME
