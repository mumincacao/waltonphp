#!/bin/bash

if [ $# != 1 ]; then
    echo useage build.sh {version}
    exit
fi

IMAGE_NAME="ghcr.io/mumincacao/waltonphp"

docker build --target base -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:v${1} .
docker build --target dev -t ${IMAGE_NAME}-dev:latest -t ${IMAGE_NAME}-dev:v${1} .
