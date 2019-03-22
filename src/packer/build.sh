#!/usr/bin/env bash

curl -X GET https://github.com/jessfraz/dockerfiles/raw/master/packer/Dockerfile --output ./.Dockerfile --silent

docker build -t packer:local -f ./.Dockerfile .

rm ./.Dockerfile
