# Intro
We want to show how cron job/cron task/cron tab be created and managed with Ubuntu 18

Ubuntu image namgivu/ubuntu-pipenv:18.04-3.6
ref. https://hub.docker.com/r/namgivu/ubuntu-pipenv

# Installation
- docker ref. bit.ly/nndockercompose
- python 3.6 and pipenv ref. bit.ly/nnpipenv

# the tick.sh
```bash
POLL_SCRIPT=nam.pollAzureStorage.sh ./bin/tick.sh
```

# Quickstart 0th @ trang-echoNow.sh
wire up the cron task under ubuntu 18.04
```bash
./docker/down.sh ; POLL_SCRIPT=nam.pollAzureStorage.sh ./docker/build-run.sh
```

afterward
```bash
# ensure log shows success
docker logs nn-cronjob-ubuntu-start
    o='
    * Starting periodic command scheduler cron
    ...done.
    '

# open shell prompt to it
docker exec -it nn-cronjob-ubuntu-start bash

    # view running cronjob
    docker exec nn-cronjob-ubuntu-start crontab -l
        o='
        * * * * * POLL_SCRIPT=trang-echoNow.sh /bin/sh /app/bin/tick.sh
        '


# poll it aka run again
docker exec     nn-cronjob-ubuntu-start bash -c "POLL_SCRIPT=trang-echoNow.sh /app/bin/tick.sh"

# view log
docker exec     nn-cronjob-ubuntu-start ls  /app/log/
docker exec     nn-cronjob-ubuntu-start cat /app/log/trang-echoNow.sh.log
```


# Quickstart 2nd @ nam.pollAzureStorage.sh
```bash
./docker/down.sh ; CONTAINER_NAME='cronjob' POLL_SCRIPT='nam.pollAzureStorage.sh' ./docker/build-run.sh ;
                   CONTAINER_NAME='cronjob' POLL_SCRIPT='nam.pollAzureStorage.sh' c="${CONTAINER_NAME}__${POLL_SCRIPT}" ; echo $c
    docker logs $c ;
    docker exec $c crontab -l ;
    
    docker exec $c ls        /app/log/ ;
    docker exec $c tail -n11 /app/log/nam.pollAzureStorage.sh.log ;

    docker exec $c tail -F /app/log/nam.pollAzureStorage.sh.log ;
    
    # debug
    s='debug cron error';   docker exec $c cat /app/log/cron.log ;
    s='debug poll';         docker exec $c /app/bin/poll_vault/nam.pollAzureStorage.sh ;
    s='debug tick';         docker exec $c bash -c "POLL_SCRIPT=nam.pollAzureStorage.sh ./bin/tick.sh" ;
```


# misc
interesting note on [docker_buildtime_w_runtime_var](./__doc__/note.md)
