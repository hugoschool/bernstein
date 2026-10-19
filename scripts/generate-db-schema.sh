#!/usr/bin/env bash
# To be ran in case you wish to change the SQL schema

BASE_DIR=$(realpath $(dirname "$0"))
DEPLOY_FOLDER=$BASE_DIR/../deploy

if kubectl get configmaps db-schema 2>&1 >/dev/null; then
    kubectl delete configmap db-schema
fi

kubectl create configmap db-schema --from-file=$BASE_DIR/../poll-application/schema.sql
kubectl get configmaps db-schema -o yaml > $DEPLOY_FOLDER/configmaps/db-schema.yaml
