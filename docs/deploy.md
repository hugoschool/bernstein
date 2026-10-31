# Deploy

## Docker registry

To get your cluster up and going, you first need to push the images to a docker registry.

[Here is a document on how to set it up for Azure Container Registry](./docker-registry.md#azure-docker-registry-creation)

## Cluster

For your cluster, you need to choose:
- whether you host it locally ([minikube, example in minikube.md](./minikube.md))
- or whether you host it on [Azure (azure-kubernetes-cluster.md)](./azure-kubernetes-cluster.md)

Read the documents linked above for guidance on how to set it up in the context of this project.

## Setup

### Env file

Copy the `.env.example` file:
```sh
cp .env.example .env
```

Replace the placeholder values with:
- [the values you obtained when setting up the Docker Registry](./docker-registry.md#logging-in)
- a secure password for the database (`POSTGRES_PASSWORD`)

### Docker registry URL

You should [push the images from your docker registry if not already done earlier.](./docker-registry.md#build-and-push-the-images)

You will then need to replace the current docker registry with yours.

The current docker registry in use is `ffbernstein-dwffekbygbane5d9.azurecr.io`, so you will need to replace it with yours in all files that contain it:
- `deploy/deployments/poll.yaml`
- `deploy/deployments/result.yaml`
- `deploy/deployments/worker.yaml`
- `deploy/pods/poll.yaml`
- `deploy/pods/result.yaml`
- `deploy/pods/worker.yaml`

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
