#!/usr/bin/env bash

# TODO maybe add some error handling

kubectl apply -f pods/poll.yaml
kubectl apply -f pods/result.yaml
kubectl apply -f pods/worker.yaml
