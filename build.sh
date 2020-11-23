#!/bin/bash
DURATION=$1
# Remove existing jmeter container if present
docker rm -f jmeter
# Set jmeter version
VERSION='5.3'
URL=https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${VERSION}.tgz
# Download Jmeter.
curl $URL > apache-jmeter-${VERSION}.tgz
gunzip apache-jmeter-${VERSION}.tgz
# Build docker image containing jmeter.
docker build . --tag jmeter:latest
# Run docker container.
docker run -d --name jmeter -it jmeter:latest
docker rm -f jmeter
sleep $(($DURATION + 60))
docker cp jmeter:/LoadReports .
