# Intro
We want to show how cron job/cron task/cron tab be created and managed with Ubuntu 18

Ubuntu image namgivu/ubuntu-pipenv:18.04-3.6
ref. https://hub.docker.com/r/namgivu/ubuntu-pipenv

# listener process-flow  
Dockerfile creates cron task that runs ticker `/app/bin/tick.sh` and log to :cron_log `/app/log/cron.log` 
That :ticker will run `/app/bin/poll_vault/:YOURPOLL.sh` and log to `/applog/:YOURPOLL.sh.log`
                      that run `app/src/listen_for_new_file.py` which will scan for & process new files on azure storage

# Quickstart
Wire up the cron task under ubuntu 18.04 running `trang-echoNow.sh`
```bash
export CONTAINER_NAME='cronjob' ; export POLL_SCRIPT='trang-echoNow.sh' ;
    ./docker/down.sh ; ./docker/build-run.sh ;
    c="$POLL_SCRIPT-${CONTAINER_NAME}" ; echo $c ;
```

Or wire up the cron task under ubuntu 18.04 running `nam.pollAPI.sh`
```bash
POLL_SCRIPT='nam.pollAPI.sh' ./docker/down.sh ; CONTAINER_NAME='cronjob' POLL_SCRIPT='nam.pollAPI.sh' ./docker/build-run.sh ;
                                                CONTAINER_NAME='cronjob' POLL_SCRIPT='nam.pollAPI.sh' c="${POLL_SCRIPT}-${CONTAINER_NAME}" ; echo $c
```

After the container up, the cron will run as schedule every minute.
Some commands at this stage to mange it as below
```bash
    docker logs $c ;
    docker exec $c crontab -l ;
    
    docker exec $c ls         /app/log/ ;
    docker exec $c tail -n11 "/app/log/$POLL_SCRIPT.log" ;

    docker exec $c tail -F   "/app/log/$POLL_SCRIPT.log" ;
    
    # debug
    s='debug cron error';   docker exec $c cat /app/log/cron.log ;
    s='debug a poll run';   docker exec $c "/app/bin/poll_vault/$POLL_SCRIPT" ;
    s='debug a tick run';   docker exec $c bash -c "POLL_SCRIPT=$POLL_SCRIPT ./bin/tick.sh" ;
```


# misc
interesting note on [docker_buildtime_w_runtime_var](./__doc__/note.md)
