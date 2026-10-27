# Minikube

## Setup

Launch a simple minikube instance:
```sh
minikube start
```

If you wish to use multiple nodes:
```sh
minikube start --nodes 2
```

The minikube instance needs the addon-server to be launched for Horizontal Pod Scaling to work:
```sh
minikube addons enable metrics-server
```

> This should be already automatically done by the `deploy.sh` script.

## Get the apps URL

To get the apps URL on your browser, you need to get their URL from the load balancers:

```sh
minikube service poll-load-balancer --url
minikube service result-load-balancer --url
```
