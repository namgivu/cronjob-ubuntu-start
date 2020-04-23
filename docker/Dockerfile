# ubuntu 16.04 with python 3.7 w/ pipenv ref. https://github.com/namgivu/ubuntu-pipenv
FROM namgivu/ubuntu-pipenv:18.04-3.7

WORKDIR /app

COPY . .

# Default command when running container
CMD tail -F `mktemp`
