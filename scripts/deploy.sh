#!/usr/bin/env bash

BASE_DIR=$(realpath $(dirname "$0"))
DEPLOY_FOLDER=$BASE_DIR/../deploy
ENV_FILE=$BASE_DIR/../.env

if ! [ -f $ENV_FILE ]; then
    echo "Missing .env file, proceeding..."
else
    source $ENV_FILE
fi

if [ -z "$POSTGRES_PASSWORD" ]; then
    echo "POSTGRES_PASSWORD not set"
    exit 1
fi

DELETE_EVERYTHING=0

usage() {
    echo "Usage: $0" 1>&2
    echo "Options:" 1>&2
    echo "  -y: Delete automatically everything in the cluster" 1>&2
    exit $1
}

while getopts ":yh" opt; do
    case "${opt}" in
        y)
            DELETE_EVERYTHING=1
            ;;
        h)
            usage 0
            ;;
        *)
            usage 1
            ;;
    esac
done

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

if ! kubectl get secret db-password 2>&1 >/dev/null; then
    echo "Creating secret db-password"

    kubectl create secret generic db-password --from-literal=db-password=$POSTGRES_PASSWORD
fi

delete_everything_in_cluster() {
    kubectl delete pod poll
    kubectl delete pod result
    kubectl delete pod worker
    kubectl delete pod redis
    kubectl delete pod postgresql
}

if [ $DELETE_EVERYTHING -eq 0 ]; then
    read -p "Delete everything in cluster? (y/n) " yn
    case $yn in
        [Yy]* )
            delete_everything_in_cluster
            ;;
        [Nn]* )
            :
            ;;
        * )
            :
            ;;
    esac
else
    echo "Deleting everything from cluster"
    delete_everything_in_cluster
fi

echo "Applying all pods"
kubectl apply -f $DEPLOY_FOLDER/pods/poll.yaml
kubectl apply -f $DEPLOY_FOLDER/pods/result.yaml
kubectl apply -f $DEPLOY_FOLDER/pods/worker.yaml
kubectl apply -f $DEPLOY_FOLDER/pods/redis.yaml
kubectl apply -f $DEPLOY_FOLDER/pods/postgresql.yaml

# kubectl apply -f deploy/services/poll.yaml

# kubectl create deployment poll-deployment --image=deploy/pods/poll.yaml
