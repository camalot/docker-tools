#!/usr/bin/env bash

curl -X GET https://github.com/jessfraz/dockerfiles/raw/master/terraform/Dockerfile --output ./.Dockerfile --silent

docker build -t terraform:local -f ./.Dockerfile .

rm ./.Dockerfile
