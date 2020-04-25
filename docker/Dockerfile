# ubuntu 16.04 with python 3.7 w/ pipenv ref. https://github.com/namgivu/ubuntu-pipenv
FROM namgivu/ubuntu-pipenv:18.04-3.6

# change suffix _x to any new value to force a rebuild from this step
RUN echo 200424_x1

# create & set current-working folder
WORKDIR /app

# install pip packages
COPY ./Pipfile      ./
COPY ./Pipfile.lock ./
RUN pipenv sync

# bundle app source
COPY . .

# var in Docker file as ARG ref. https://vsupalov.com/docker-env-vars/#docker-image-build-time-variables
ARG TICK_SCRIPT=/app/bin/tick.sh
ARG   CRON_FILE=/tmp/mycron
ARG   POLL_SCRIPT

# add cronjob to run tick script
RUN chmod u+x $TICK_SCRIPT
RUN chmod u+x $TICK_SCRIPT
RUN echo "* * * * * POLL_SCRIPT=$POLL_SCRIPT $TICK_SCRIPT 1>>/app/log/cron.log 2>&1" >> $CRON_FILE
RUN     crontab $CRON_FILE

# get cronjob running and keep running by tail any file
CMD service cron start && tail -F `mktemp`
