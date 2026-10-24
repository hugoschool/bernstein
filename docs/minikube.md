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

## Get the apps URL

To get the apps URL on your browser, you need to get their URL from the load balancers:

```sh
minikube service poll-load-balancer --url
minikube service result-load-balancer --url
```
