#!/usr/bin/env bash
# arg1: name of destination dockerhub
# arg2: dockerhub username
# arg3: dockerhub password

set -x -e

buildnumber=${4-$(date -u +"%y%m%d%H%M")}

docker login -u "$2" -p "$3"

# build base images
docker build -q -t "$1"/php:5.6-apache_"$buildnumber" 5.6-apache
docker build -q -t "$1"/php:7.0-apache_"$buildnumber" 7.0-apache
docker build -q -t "$1"/php:7.2-apache_"$buildnumber" 7.2-apache
docker build -q -t "$1"/php:7.3-apache_"$buildnumber" -t "$1"/php:latest_"$buildnumber" 7.3-apache
docker tag "$1"/php:latest_"$buildnumber" "$1"/php:latest

docker push "$1"/php:5.6-apache_"$buildnumber"
docker push "$1"/php:7.0-apache_"$buildnumber"
docker push "$1"/php:7.2-apache_"$buildnumber"
docker push "$1"/php:7.3-apache_"$buildnumber"
docker push "$1"/php:latest_"$buildnumber"
docker push "$1"/php:latest

docker logout
