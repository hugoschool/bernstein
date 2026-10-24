# Deploy

## Cluster

For your cluster, you need to choose:
- whether you host it locally ([minikube, example in minikube.md](./minikube.md))
- or whether you host it on [Azure (azure-kubernetes-cluster.md)](./azure-kubernetes-cluster.md)

## Setup

Copy and fill the `.env.example` file:
```sh
cp .env.example .env
```

Replace the placeholder values with:
- the values the ones you obtained when [setting up the Docker Registry](./docker-registry.md)
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
