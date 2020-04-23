We want to show how cron job/cron task/cron tab be created and managed with Ubuntu 18

Ubuntu image namgivu/ubuntu-pipenv:18.04-3.6
ref. https://hub.docker.com/r/namgivu/ubuntu-pipenv

Installation
- docker ref. bit.ly/nndockercompose
- python 3.6 and pipenv ref. bit.ly/nnpipenv

Quickstart
```bash
# wire up a ubuntu 18 machine
./docker/build.sh ; ./docker/down.sh;  ./docker/run.sh

# open shell prompt to it
docker exec -it nn-cronjob-ubuntu-start bash

# poll it aka run again
docker exec nn-cronjob-ubuntu-start /app/bin/app.py

# view log
docker exec nn-cronjob-ubuntu-start cat /app/log/log.txt
```
