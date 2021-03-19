FROM ubuntu

WORKDIR /app

COPY . .
RUN apt-get update && \
    apt-get install cron -y
# var in Docker file as ARG ref. https://vsupalov.com/docker-env-vars/#docker-image-build-time-variables
ARG   LOG_SCRIPT=/app/bin/logs.sh
ARG   CRON_FILE=/app/mycron
ARG   SCRIPT

# add cronjob to run tick script
RUN chmod u+x $LOG_SCRIPT
RUN echo "* * * * * SCRIPT=$SCRIPT $LOG_SCRIPT 1>>/app/log/cron.log 2>&1" >> $CRON_FILE
RUN crontab $CRON_FILE

# get cronjob running and keep running by tail any file
CMD service cron start && tail -F `mktemp`
