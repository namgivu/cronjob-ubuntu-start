# ref https://dev.to/s1ntaxe770r/how-to-setup-ssh-within-a-docker-container-i5i
FROM ubuntu:18.04

WORKDIR /app
COPY . .
# setup cron & ssh
RUN apt-get update && \
    apt-get install cron -y && \
    apt-get install nano sudo openssh-client -y && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    ssh-keyscan -H prototype.referreach.com  >> ~/.ssh/known_hosts

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
