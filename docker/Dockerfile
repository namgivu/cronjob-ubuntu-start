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

#TODO Trang script to add cronjob
RUN echo '* * * * * /bin/sh /app/bin/test.sh' >> mycron
RUN chmod u+x /app/bin/test.sh
RUN crontab mycron

# run demo python file  #TODO we will run it via a cron task
RUN /app/bin/run-main.sh

# Default command when running container
CMD tail -F `mktemp`
CMD service cron start && tail -F /var/log/mysql/error.log
