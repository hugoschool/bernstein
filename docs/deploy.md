# Deploy

## Cluster

For your cluster, you need to choose:
- whether you host it locally ([minikube, example in minikube.md](./minikube.md))
- or whether you host it on [Azure (azure-kubernetes-cluster.md)](./azure-kubernetes-cluster.md)

## Setup

Firstly, copy the `.env.example` file:
```sh
cp .env.example .env
```

> You will need to fill the values once the docker registry is up and working.

Then setup a [private Docker registry](./docker-registry.md) and push the images there.

You will then need to replace the current docker registry with yours.

The current docker registry in use is `ffbernstein-dwffekbygbane5d9.azurecr.io`, so you will need to replace it with yours in all files that contain it:
- `deploy/deployments/poll.yaml`
- `deploy/deployments/result.yaml`
- `deploy/deployments/worker.yaml`
- `deploy/pods/poll.yaml`
- `deploy/pods/result.yaml`
- `deploy/pods/worker.yaml`

Replace the placeholder values with:
- the values you obtained when setting up the Docker Registry
- a secure password for the database (`POSTGRES_PASSWORD`)

## Running the script

To deploy the application, a script is provided:

```sh
./scripts/deploy.sh
```

A couple of options are available in the script (list all of them `./scripts/deploy.sh -h`):
- Delete everything in the cluster
```sh
./scripts/deploy.sh -y
```
- Only delete everything in the cluster, don't apply
```sh
./scripts/deploy.sh -d
```
- Only apply pods, don't use deployments
```sh
./scripts/deploy.sh -p
```
