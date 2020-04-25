#!/bin/bash
docstring=`cat<<EOF
c=nn-cronjob-ubuntu-start  # c aka container_name; replace default by yours if any

# open shell prompt to it
docker exec -it $c bash

# poll it again
docker exec $c /app/bin/test.sh

# view log
docker exec $c ls /app/log

EOF`

# now=$(date +%F%H%M%S)
now=$(date +%s%N)  # get nanosecond ref. https://serverfault.com/a/151112/41015
touch /app/log/$now.txt
