#!/usr/bin/env bash

curl -X GET https://github.com/jessfraz/dockerfiles/raw/master/packer/Dockerfile --output ./.Dockerfile --silent

docker build -t camalot/packer:lastest -f ./.Dockerfile .

rm ./.Dockerfile
