#!/usr/bin/env bash

curl -X GET https://github.com/jessfraz/dockerfiles/raw/master/azure-cli/Dockerfile --output ./.Dockerfile --silent

docker build -t azure-cli:local -f ./.Dockerfile .

rm ./.Dockerfile
