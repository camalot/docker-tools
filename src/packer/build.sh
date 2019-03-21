#!/usr/bin/env bash

curl -X GET -s -O https://github.com/jessfraz/dockerfiles/raw/master/packer/Dockerfile ./.Dockerfile

docker build -t packer:lastest .

rm ./.Dockerfile
