#!/usr/bin/env bash

BASE_DIR=$(realpath $(dirname "$0"))
DEPLOY_FOLDER=$BASE_DIR/../deploy
ENV_FILE=$BASE_DIR/../.env

if ! [ -f $ENV_FILE ]; then
    echo "Missing .env file, proceeding..."
else
    source $ENV_FILE
fi

# TODO maybe add some error handling

if ! kubectl get secret registry-key 2>&1 >/dev/null; then
    echo "Creating the registry-key secret"
    echo "Docker registry: $DOCKER_REGISTRY"
    echo "Docker username: $DOCKER_USERNAME"
    echo "Docker password: $DOCKER_PASSWORD"

    kubectl create secret docker-registry registry-key \
        --docker-server=$DOCKER_REGISTRY \
        --docker-username=$DOCKER_USERNAME \
        --docker-password=$DOCKER_PASSWORD
fi

echo "Applying all pods"
kubectl apply -f $DEPLOY_FOLDER/pods/poll.yaml
kubectl apply -f $DEPLOY_FOLDER/pods/result.yaml
kubectl apply -f $DEPLOY_FOLDER/pods/worker.yaml

# kubectl apply -f deploy/services/poll.yaml

# kubectl create deployment poll-deployment --image=deploy/pods/poll.yaml
