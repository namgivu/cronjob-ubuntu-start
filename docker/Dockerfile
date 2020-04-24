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

#TODO make .sh path and .log path as input via environ; param -e ref. https://docs.docker.com/engine/reference/commandline/run/
# add cronjob to run .sh script
RUN echo '* * * * * /bin/sh /app/bin/test.sh' >> mycron
RUN chmod u+x /app/bin/test.sh
RUN crontab mycron

# Default command when running container
CMD tail -F `mktemp`
CMD service cron start && tail -F /var/log/mysql/error.log
