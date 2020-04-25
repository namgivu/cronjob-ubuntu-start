# Intro
We want to show how cron job/cron task/cron tab be created and managed with Ubuntu 18

Ubuntu image namgivu/ubuntu-pipenv:18.04-3.6
ref. https://hub.docker.com/r/namgivu/ubuntu-pipenv

# Installation
- docker ref. bit.ly/nndockercompose
- python 3.6 and pipenv ref. bit.ly/nnpipenv

# Quickstart
run the container
```bash
# wire up a ubuntu 18 machine
./docker/build.sh ; ./docker/down.sh;  ./docker/run.sh

POLL_SCRIPT=trang-echoNow.sh  ./docker/build.sh ; ./docker/down.sh;  ./docker/run.sh

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
