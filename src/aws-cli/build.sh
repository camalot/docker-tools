#!/usr/bin/env bash

curl -X GET https://github.com/jessfraz/dockerfiles/raw/master/awscli/Dockerfile --output ./.Dockerfile --silent

docker build -t aws-cli:local -f ./.Dockerfile .

rm ./.Dockerfile
