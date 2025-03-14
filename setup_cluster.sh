#!/bin/bash

# build base docker image with image name hadoop-base:3.3.6
docker build -t hadoop-base:3.3.6 ./Dockerfiles/base

# running image to container, -d to run it in daemon mode
docker-compose -f ./docker-compose.yml up -d

echo "Current dir is $PWD"
