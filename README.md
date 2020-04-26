# Intro
We want to show how cron job/cron task/cron tab be created and managed with Ubuntu 18

Ubuntu image namgivu/ubuntu-pipenv:18.04-3.6
ref. https://hub.docker.com/r/namgivu/ubuntu-pipenv

# Installation
- docker ref. bit.ly/nndockercompose
- python 3.6 and pipenv ref. bit.ly/nnpipenv


# the tick.sh
demo a tick
```bash
POLL_SCRIPT=nam.pollAPI.sh ./bin/tick.sh
```


# Quickstart
Wire up the cron task under ubuntu 18.04 running `trang-echoNow.sh`
```bash
export CONTAINER_NAME='cronjob' ; export POLL_SCRIPT='trang-echoNow.sh' ; ./docker/down.sh ; ./docker/build-run.sh
c="${CONTAINER_NAME}__${POLL_SCRIPT}" ; echo $c
```

Or wire up the cron task under ubuntu 18.04 running `nam.pollAPI.sh`
```bash
POLL_SCRIPT='nam.pollAPI.sh' ./docker/down.sh ; CONTAINER_NAME='cronjob' POLL_SCRIPT='nam.pollAPI.sh' ./docker/build-run.sh ;
                                                CONTAINER_NAME='cronjob' POLL_SCRIPT='nam.pollAPI.sh' c="${CONTAINER_NAME}__${POLL_SCRIPT}" ; echo $c
```

After the container up, the cron will run as schedule every minute.
Some commands at this stage to mange it as below
```bash
    docker logs $c ;
    docker exec $c crontab -l ;
    
    docker exec $c ls         /app/log/ ;
    docker exec $c tail -n11 "/app/log/$POLL_SCRIPT.log" ;

    docker exec $c tail -F /app/log/nam.pollAPI.sh.log ;
    
    # debug
    s='debug cron error';   docker exec $c cat /app/log/cron.log ;
    s='debug a poll run';   docker exec $c "/app/bin/poll_vault/$POLL_SCRIPT" ;
    s='debug a tick run';   docker exec $c bash -c "POLL_SCRIPT=nam.pollAPI.sh ./bin/tick.sh" ;
```


# misc
interesting note on [docker_buildtime_w_runtime_var](./__doc__/note.md)
