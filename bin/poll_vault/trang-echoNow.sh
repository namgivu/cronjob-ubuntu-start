#!/bin/bash
docstring='
c=nn-cronjob-ubuntu-start  # c aka container_name; replace default by yours if any
    docker exec -it $c bash          # open shell prompt to it
    docker exec $c /app/bin/test.sh  # poll it again
    docker exec $c ls /app/log       # view log
'

THIS_FILE=`basename "$0"`  # get this script filename ref. https://stackoverflow.com/a/192337/248616

timestamp=$(date +%F%H%M%S)  # we MAY also add nanosecond as %s%N ref. https://serverfault.com/a/151112/41015
    echo $timestamp >> $THIS_FILE
