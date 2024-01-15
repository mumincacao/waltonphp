#!/bin/bash

if [ $# != 1 ]; then
    echo useage build.sh {version}
    exit
fi

IMAGE_NAME="ghcr.io/mumincacao/waltonphp"

docker build -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:v${1} .
