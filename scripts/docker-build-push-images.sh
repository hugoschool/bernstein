#!/usr/bin/env bash

BASE_DIR=$(realpath $(dirname "$0"))
ENV_FILE=$BASE_DIR/../.env

if ! [ -f $ENV_FILE ]; then
    echo "Missing .env file, proceeding..."
else
    source $ENV_FILE
fi

if [ -z "$DOCKER_REGISTRY" ]; then
    echo "Docker registry not set"
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "docker could not be found"
    exit 1
fi

if ! grep -q $DOCKER_REGISTRY ~/.docker/config.json ; then
    echo "Could not verify that you are logged into the docker registry."
    echo "Proceeding..."
fi

build_image() {
    IMAGE_NAME=$1
    IMAGE_PATH=$2

    echo "Building image $IMAGE_NAME using path $(realpath $IMAGE_PATH)"
    docker build -t $IMAGE_NAME:latest $IMAGE_PATH
    echo "Image $IMAGE_NAME has been built"
}

tag_image() {
    IMAGE_NAME=$1
    IMAGE_NAME_WITH_REGISTRY="$DOCKER_REGISTRY/$IMAGE_NAME"

    echo "Tagging image $IMAGE_NAME as $IMAGE_NAME_WITH_REGISTRY"
    docker image tag $IMAGE_NAME $IMAGE_NAME_WITH_REGISTRY
}

push_image() {
    IMAGE_NAME=$1

    tag_image $IMAGE_NAME
    echo "Pushing image $IMAGE_NAME"
    docker image push $DOCKER_REGISTRY/$IMAGE_NAME
    echo "Image $IMAGE_NAME has been pushed to $DOCKER_REGISTRY"
}

build_image bernstein-poll $BASE_DIR/../poll-application/poll
build_image bernstein-result $BASE_DIR/../poll-application/result
build_image bernstein-worker $BASE_DIR/../poll-application/worker

push_image bernstein-poll:latest
push_image bernstein-result:latest
push_image bernstein-worker:latest
