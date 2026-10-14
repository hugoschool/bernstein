#!/usr/bin/env bash

source .env

# TODO maybe add some error handling

kubectl create secret docker-registry registry-key \
    --docker-server=ffbernstein-dwffekbygbane5d9.azurecr.io \
    --docker-username=$DOCKER_USERNAME \
    --docker-password=$DOCKER_PASSWORD

# TODO do it with realpath
# kubectl apply -f deploy/pods/poll.yaml
# kubectl apply -f pods/result.yaml
# kubectl apply -f pods/worker.yaml

# kubectl apply -f deploy/services/poll.yaml

# kubectl create deployment poll-deployment --image=deploy/pods/poll.yaml
