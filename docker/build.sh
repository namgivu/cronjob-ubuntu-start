#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

IMAGE_TAG=${IMAGE_TAG:-'nn/cronjob-ubuntu-start:200424'}

docker build --file "$SH/Dockerfile"             -t $IMAGE_TAG             $AH
#            #build image from this Dockerfile   #t aka tag of the image   #set :pwd folder for Dockerfile
