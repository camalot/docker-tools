#!/usr/bin/env bash

curl -X GET https://github.com/jessfraz/dockerfiles/raw/master/android-tools/Dockerfile --output ./.Dockerfile --silent

docker build -t android-tools:local -f ./.Dockerfile .

rm ./.Dockerfile
